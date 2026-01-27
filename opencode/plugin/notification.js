export const NotificationPlugin = async ({ project, client, $, directory, worktree }) => {
  return {
    event: async ({ event }) => {
      if (event.type === "session.idle") {
        const dirName = directory.split("/").pop()
        await $`terminal-notifier -title "OpenCode" -message "Task completed in ${dirName}" -sound "default"`
      }
    },
  }
}
