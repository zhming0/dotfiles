#!/usr/bin/env bb

;; Declarative skill manager - define repos below and run to install all.
;;
;; Usage:
;;   setup.clj
;;
;; Add or remove entries from the `skills` vector to manage your skills.

(require '[babashka.process :refer [shell]])

(def skills
  ;; This allows Agent to know to use Clojure REPL!
  [{:repo "bhauman/clojure-mcp-light"}

   ;; Official Playwright browser automation skill (Microsoft)
   {:repo "microsoft/playwright-cli"
    :skill "playwright-cli"}])

(defn install-skill! [{:keys [repo skill]}]
  (println (str "\n=== " repo " ==="))
  (apply shell {:out :inherit :err :inherit}
         (concat ["npx" "-y" "skills" "add" repo
                  "--global" "--copy" "--yes"]
                 (when skill ["--skill" skill]))))

(defn -main [& _]
  (doseq [s skills]
    (install-skill! s)))

;; TODO: we will do some symlinks using my own skills later

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
