# GitKit — PowerShell Git Helper Toolkit

**Version:** v1.0.0

**Author:** Siam Al Rabbi

**Date:** 2026-01-17


---

## Overview
GitKit is a comprehensive PowerShell toolkit designed to simplify Git operations for solo developers. It transforms complex Git sequences into single, safe commands, allowing you to manage branches, releases, and recovery directly from the terminal without memorizing obscure flags.

---

## Featured Workflows

### Smart Sync & Push
The standard `git push` can fail if your local branch is behind. `gitPush` handles the entire safety check for you:
* **Auto-Fetch:** Automatically retrieves latest remote data.
* **Conflict Prevention:** Calculates if you are "behind" and forces a pull before allowing a push.
* **Status Reporting:** Provides a clear summary of how many commits were sent.

### Intelligent Branch Switching
Stop losing progress to the "local changes would be overwritten" error. `gitSwitch` manages your workspace state:
* **Auto-Stash:** Detects uncommitted work and stashes it with a descriptive message before switching.
* **Safe Transition:** Ensures the target branch exists before attempting the move.

### Remote Stash Sharing
Normally, stashes are local only. `gitPushStash` allows you to move your "Work in Progress" to the cloud:
* **Bridge Creation:** Creates a temporary branch to house your stashed changes.
* **GitHub Sync:** Commits and pushes the stash to origin so you can pick it up on another machine.

---

## Command Reference

| Category | Command | Description |
| :--- | :--- | :--- |
| **Identity** | `gitCheckUser` | Verifies your global Git username and email. |
| **Setup** | `gitPublishExisting` | Safely publishes an existing local repo to GitHub. |
| **Daily Work** | `gitStatus` | Shows the current working tree status. |
| **Daily Work** | `gitAddCommit` | Stages all changes and commits them with a message. |
| **Daily Work** | `gitPush` | Fetches, checks sync status, and pushes current branch. |
| **Branching** | `gitNewBranch` | Syncs with main and creates a new feature branch. |
| **Branching** | `gitSwitch` | Switches branches with automatic stashing. |
| **Merging** | `gitMergeToMain` | Automates merging a feature branch into main. |
| **Stash** | `gitPushStash` | Pushes local stashed work to a remote branch. |
| **Undo** | `gitUndoSoft` | Reverts the last commit but keeps your files changed. |
| **Undo** | `gitUndoHard` | Deletes the last commit and all changes (with confirmation). |
| **Cleanup** | `gitCleanupMerged` | Deletes local branches already merged into main. |

---

## Installation

1. Open your PowerShell profile using your preferred text editor:
    
    # Open with Notepad
    notepad $PROFILE

    # OR open with VS Code
    code $PROFILE

2. Copy the GitKit functions and paste them into the profile file.

3. Save the file and reload the profile immediately with the following command:

    . $PROFILE

4. Run `gitHelp` to see all available commands.

---

## Best Practices
* **Isolation:** Always work in feature branches; avoid pushing directly to main.
* **Safety:** Use stashes to save uncommitted work before switching branches.
* **Sync:** Push frequently to remote branches to avoid data loss.

---

## Future Enhancements
* **Dynamic Branch Detection:** Automatically detect `main` vs `master` for all sync operations.
* **Semantic Versioning:** Automated tag bumping (patch/minor/major) based on project history.
* **Health Dashboard:** A one-page summary of unpushed work and stale branches.
* **Conventional Commits:** Interactive prompts to ensure professional commit messaging.
* **Conflict Helper:** Streamlined workflow for opening and resolving merge conflicts.
