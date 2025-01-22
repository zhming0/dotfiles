#!/usr/bin/env bb

(require '[clojure.string :as string])
(require '[babashka.process :refer [shell]])
(require '[babashka.cli :as cli])

(def cli-arg-spec {:spec {:default-branch {:default "main"}}})

; * find parent branch.
; * optionally create branch
; * create PR based on current branch.

(defn parse-cli-opts []
  (cli/parse-opts *command-line-args* cli-arg-spec))

(defn find-parent-branch [default-branch]
  {:post [(seq %)]}
  (->
   (shell {:out :string} "jj" "log" "--no-graph" "-r" (str default-branch "-..@--") "-T" "local_bookmarks ++ \"\n\"")
   :out
   string/split-lines
   first))

(defn find-current-branch []
  (let [empty->nil (fn [s] (when-not (empty? s) s))]
    (->
     (shell {:out :string} "jj" "log" "--no-graph" "-r" "@-" "-T" "local_bookmarks")
     :out
     empty->nil)))

(defn- get-commit-message []
  (->
   (shell {:out :string} "jj log --no-graph -r @- -T description")
   :out
   string/split-lines
   first))

(defn- get-branch-prefix []
  (->
   (shell {:out :string} "jj config get git.push-bookmark-prefix")
   :out
   string/trim))

(defn- scan-until-colon [s]
  (->> s
       (take-while #(not= % \:))
       (apply str)))

(defn- message->branch-name [msg]
  (->
   msg
   scan-until-colon
   string/lower-case
   (string/replace #"\W+" "-")))

(defn- new-branch-name []
  (let [commit-message (get-commit-message)
        unprefixed-name (message->branch-name commit-message)
        unprefixed-name-capped (->> unprefixed-name (take 62) (apply str))
        prefix (get-branch-prefix)]
    (str prefix unprefixed-name-capped)))

(comment
  (new-branch-name))

(defn create-new-branch! []
  (let [branch-name (new-branch-name)]
    (shell "jj bookmark create" branch-name "-r @-")
    branch-name))

(defn find-current-branch-or-create! []
  {:post [(seq %)]}
  (if-let [existing-branch (find-current-branch)]
    existing-branch
    (create-new-branch!)))

(comment
  (find-current-branch-or-create!))

(defn create-pr! [parent-branch current-branch]
  (println "Creating PR based based on " parent-branch " for " current-branch)
  (shell "gh pr create"
         "--base" parent-branch
         "--head" current-branch
         "--fill-first"
         "--web"))

(defn git-push! [branch]
  (shell "jj git push --allow-new --bookmark" branch))

(defn create-stacked-pr []
  (let [{:keys [default-branch]} (parse-cli-opts)
        parent-branch (find-parent-branch default-branch)
        current-branch (find-current-branch-or-create!)]
    (git-push! current-branch)
    (create-pr! parent-branch current-branch)))

(when (= *file* (System/getProperty "babashka.file"))
  (create-stacked-pr))
