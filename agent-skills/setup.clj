#!/usr/bin/env bb

;; Declarative skill manager - define repos below and run to install all.
;;
;; Usage:
;;   setup.clj
;;
;; Add or remove repos from the `repos` vector to manage your skills.

(require '[babashka.process :refer [shell]])

(def repos
  ;; This allows Agent to know to use Clojure REPL!
  ["bhauman/clojure-mcp-light"

   ;; A generic playwright browser test skill
   ;; Note this one needs npm setup to function.
   "lackeyjb/playwright-skill"])

(defn install-repo! [repo]
  (println (str "\n=== " repo " ==="))
  (shell {:out :inherit :err :inherit} "add-skill" repo))

(defn -main [& _]
  (doseq [repo repos]
    (install-repo! repo)))

;; TODO: we will do some symlinks using my own skills later

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
