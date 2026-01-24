#!/usr/bin/env bb

;; Install Claude Code skills from a GitHub repository.
;;
;; Skills are identified by SKILL.md files with YAML frontmatter containing
;; `name` and `description` fields. The skill directory is copied to
;; ~/.claude/skills/<name> globally.
;;
;; Usage:
;;   add-skill <repo> [--list] [--skill name]
;;
;; Arguments:
;;   <repo>          GitHub repo (owner/repo) or full git URL
;;
;; Options:
;;   -l, --list      List available skills without installing
;;   -s, --skill     Install only the specified skill by name
;;   -h, --help      Show help
;;
;; Examples:
;;   add-skill anthropics/claude-code-skills          # install all skills
;;   add-skill anthropics/claude-code-skills -l       # list available skills
;;   add-skill anthropics/claude-code-skills -s pr    # install only "pr" skill

(require '[babashka.fs :as fs]
         '[babashka.process :refer [shell]]
         '[clojure.string :as str])

;; Parse YAML frontmatter (simple, no deps)
(defn parse-frontmatter [content]
  (when-let [[_ yaml] (re-find #"(?s)^---\n(.+?)\n---" content)]
    (->> (str/split-lines yaml)
         (map #(re-find #"^(\w+):\s*[\"']?([^\"']+)[\"']?\s*$" %))
         (filter some?)
         (map (fn [[_ k v]] [(keyword k) (str/trim v)]))
         (into {}))))

(defn find-skills [repo-dir]
  (->> (fs/glob repo-dir "**/SKILL.md")
       (map (fn [path]
              (let [content (slurp (str path))
                    meta (parse-frontmatter content)]
                (when (:name meta)
                  {:name (:name meta)
                   :description (:description meta)
                   :dir (str (fs/parent path))}))))
       (filter some?)))

(defn normalize-repo [repo]
  (cond
    (str/starts-with? repo "http") repo
    (str/starts-with? repo "git@") repo
    :else (str "https://github.com/" repo ".git")))

(defn skill-dest [skill-name]
  (str (fs/home) "/.claude/skills/" skill-name))

(defn install-skill! [skill]
  (let [dest (skill-dest (:name skill))]
    (fs/create-dirs dest)
    (fs/copy-tree (:dir skill) dest {:replace-existing true})
    (println (str "  ✓ " (:name skill) " → " dest))))

(defn clone-repo! [url]
  (let [tmp (str (fs/create-temp-dir {:prefix "add-skill-"}))]
    (println (str "Cloning " url "..."))
    (shell {:out :inherit :err :inherit}
           "git" "clone" "--depth" "1" "--quiet" url (str tmp "/repo"))
    (str tmp "/repo")))

;; CLI
(def cli-opts
  {:list false
   :skill nil
   :repo nil})

(defn parse-args [args]
  (loop [args args
         opts cli-opts]
    (if (empty? args)
      opts
      (let [[a & rest] args]
        (case a
          ("--list" "-l") (recur rest (assoc opts :list true))
          ("--skill" "-s") (recur (drop 1 rest) (assoc opts :skill (first rest)))
          ("--help" "-h") (do (println "Usage: add-skill.clj <repo> [--list] [--skill name]")
                              (System/exit 0))
          (recur rest (assoc opts :repo a)))))))

(defn -main [& args]
  (let [{:keys [repo list skill]} (parse-args args)]
    (when-not repo
      (println "Error: No repository specified")
      (System/exit 1))

    (let [url (normalize-repo repo)
          repo-dir (clone-repo! url)
          skills (cond->> (find-skills repo-dir)
                   skill (filter #(= (:name %) skill)))]

      (when (empty? skills)
        (println "No skills found")
        (System/exit 1))

      (if list
        (do
          (println "Available skills:")
          (doseq [s skills]
            (println (str "  " (:name s) ": " (:description s)))))
        (do
          (doseq [s skills]
            (install-skill! s))
          (println "Done!")))

      (fs/delete-tree (fs/parent repo-dir)))))

(when (= *file* (System/getProperty "babashka.file"))
  (apply -main *command-line-args*))
