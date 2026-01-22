####################################################
#     PowerShell Git Toolkit — SAFE & COMPLETE     #
#      GitHub Flow Ready | Copy into $PROFILE      #
####################################################

# --------------------------------------------------
# Git Helper: Show Only Names or Full (Safe Version)
# --------------------------------------------------

$GitFunctionDescriptions = @{

    # --- Identity & One-Time Setup ---
    "gitCheckUser"            = "Check global Git username & email"
    "gitSetupUser"            = "Configure global Git username & email"

    # --- Repo Initialization / Publishing ---
    "gitInitPush"             = "Initialize new repo, first commit, set origin, push to GitHub"
    "gitPushExistingRepo"     = "Publish an already-initialized local repo to GitHub"

    # --- Cloning & Remote Setup ---
    "gitClone"                = "Clone a remote repository"
    "gitSetRemote"            = "Set or replace remote origin URL"
    "gitShowRemotes"          = "Show configured Git remotes"
    "gitPreviewRemote"        = "Preview a remote branch locally using a temp branch"

    # --- Daily Development ---
    "gitStatus"               = "Show working tree status"
    "gitAddCommit"            = "Stage all changes and commit"
    "gitPush"                 = "Safely pull & push current branch"

    # --- Feature Development (GitHub Flow) ---
    "gitNewBranch"            = "Create a new feature branch from main"
    "gitSwitch"               = "Safely switch branches with auto-stash"
    "gitPushNewBranch"        = "Push new branch & set upstream"

    # --- Branch Maintenance ---
    "gitRenameBranch"         = "Rename a local branch"
    "gitDeleteBranch"         = "Delete local branch"
    "gitDeleteRemoteBranch"   = "Delete remote branch"
    "gitBranchTrack"          = "Show branch tracking info"

    # --- Merging & Sync ---
    "gitFetch"                = "Fetch updates from remote"
    "gitPull"                 = "Pull updates from remote"
    "gitMergeToMain"          = "Merge feature branch into main"
    "gitMergeAbort"           = "Abort an in-progress merge"
    "gitMergeTempBranch"      = "Merge temp/stash branch into main"

    # --- History & Logs ---
    "gitLog"                  = "Full decorated git log graph"
    "gitLog1"                 = "Short oneline git log"

    # --- Diff & Inspection ---
    "gitDiff"                 = "Show unstaged changes"
    "gitDiffStaged"           = "Show staged changes"
    "gitDiffBranches"         = "Compare two branches"

    # --- Stash ---
    "gitStash"                = "Create a stash with message"
    "gitStashList"            = "List all stashes"
    "gitStashApply"           = "Apply a stash"
    "gitStashPop"             = "Apply & remove stash"
    "gitStashDrop"            = "Delete a stash"
    "gitPushStash"            = "Push stash via temporary branch"

    # --- Undo & Recovery ---
    "gitUndoSoft"             = "Undo last commit (keep changes)"
    "gitUndoSoftRemote"       = "Undo last commit safely from remote (keep changes)"
    "gitUndoHard"             = "Undo last commit (delete changes)"
    "gitReflog"               = "Show reflog"
    "gitRestoreFromReflog"    = "Restore commit from reflog"

    # --- Tags / Releases ---
    "gitTagCreate"            = "Create a tag"
    "gitTagPush"              = "Push tag(s) to remote"
    "gitTagList"              = "List local & remote tags"
    "gitTagDeleteLocal"       = "Delete a local tag"
    "gitTagDeleteRemote"      = "Delete a remote tag"

    # --- Cleanup & Utilities ---
    "gitCleanupMerged"        = "Delete branches already merged into main"
    "gitCurrentBranch"        = "Show current branch name"
}


function gitHelp {
    param([string]$Mode = "full")

    Write-Host "`nGit Helper Functions:" -ForegroundColor Green

    $GitHelpOrder = @(

    "# Identity & One-Time Setup",
    "gitCheckUser",
    "gitSetupUser",

    "# New Project --> GitHub",
    "gitInitPush",

    "# Existing Project --> GitHub",
    "gitPushExistingRepo",

    "# Clone & Remote Setup",
    "gitClone",
    "gitSetRemote",
    "gitShowRemotes",
    "gitPreviewRemote",

    "# Daily Development",
    "gitStatus",
    "gitAddCommit",
    "gitPush",

    "# Feature Development (GitHub Flow)",
    "gitNewBranch",
    "gitSwitch",
    "gitPushNewBranch",

    "# Branch Maintenance",
    "gitRenameBranch",
    "gitDeleteBranch",
    "gitDeleteRemoteBranch",
    "gitBranchTrack",

    "# Merging & Sync",
    "gitFetch",
    "gitPull",
    "gitMergeToMain",
    "gitMergeTempBranch",
    "gitMergeAbort",

    "# History & Logs",
    "gitLog",
    "gitLog1",

    "# Diff & Inspection",
    "gitDiff",
    "gitDiffStaged",
    "gitDiffBranches",

    "# Stash (Temporary Save)",
    "gitStash",
    "gitStashList",
    "gitStashApply",
    "gitStashPop",
    "gitStashDrop",
    "gitPushStash",

    "# Undo & Recovery",
    "gitUndoSoft",
    "gitUndoSoftRemote",
    "gitUndoHard",
    "gitReflog",
    "gitRestoreFromReflog",

    "# Tags & Releases",
    "gitTagCreate",
    "gitTagPush",
    "gitTagList",
    "gitTagDeleteLocal",
    "gitTagDeleteRemote",

    "# Cleanup & Utilities",
    "gitCleanupMerged",
    "gitCurrentBranch"
)

    foreach ($item in $GitHelpOrder) {

        if ($item.StartsWith("#")) {
            Write-Host "`n$($item.Substring(2))" -ForegroundColor Blue
            continue
        }

        if ($Mode -eq "names") {
            Write-Host $item -ForegroundColor Yellow
            continue
        }

        if ($GitFunctionDescriptions.ContainsKey($item)) {
            Write-Host ("{0,-30} : {1}" -f $item, $GitFunctionDescriptions[$item])
        } else {
            Write-Host $item -ForegroundColor Yellow
        }
    }
}



# ==================================================
# Identity & One-Time Setup
# ==================================================

function gitCheckUser {
    $name  = git config --global user.name
    $email = git config --global user.email

    if (-not $name -and -not $email) {
        Write-Host "Git user is NOT configured." -ForegroundColor Red
        Write-Host "Run: gitSetupUser" -ForegroundColor Yellow
        return
    }

    Write-Host "`nGit user configuration:`n" -ForegroundColor Cyan
    if ($name)  { Write-Host ("Name : {0}" -f $name) -ForegroundColor Green }
    if ($email) { Write-Host ("Email: {0}" -f $email) -ForegroundColor Green }
}

function gitSetupUser {
    $name  = Read-Host "Enter your Git user name"
    $email = Read-Host "Enter your Git email"

    git config --global user.name "$name"
    git config --global user.email "$email"

    Write-Host "Git user configured successfully." -ForegroundColor Green
}


# ==================================================
# New Project --> GitHub
# ==================================================

function gitInitPush {
    Write-Host "Initializing new Git repository..." -ForegroundColor Cyan
    if (-not (Test-Path ".git")) { git init }

    git branch -M main
    git add .
    git commit -m "Initial commit" --allow-empty

    $repoUrl = Read-Host "Enter GitHub repository URL (HTTPS)"
    if (git remote | Select-String "^origin$") { git remote remove origin }

    git remote add origin $repoUrl
    git push -u origin main
    Write-Host "Repository initialized & pushed." -ForegroundColor Green
}


# ==================================================
# Existing Project --> GitHub
# ==================================================

function gitPushExistingRepo {
    Write-Host "`nSafely pushing existing repository..." -ForegroundColor Cyan

    # Ask for remote URL
    $repoUrl = Read-Host "Enter GitHub repository URL (HTTPS)"
    if ([string]::IsNullOrWhiteSpace($repoUrl)) {
        Write-Host "Error: Repository URL cannot be empty." -ForegroundColor Red
        return
    }

    # Show current origin if exists
    $currentOrigin = git remote get-url origin 2>$null
    if ($currentOrigin) {
        Write-Host "`nCurrent origin:" -ForegroundColor Yellow
        Write-Host "  $currentOrigin"
        if ($currentOrigin -ne $repoUrl) {
            Write-Host "Updating origin to the new URL..." -ForegroundColor Yellow
            git remote set-url origin $repoUrl
        } else {
            Write-Host "Origin already matches target." -ForegroundColor Green
        }
    } else {
        git remote add origin $repoUrl
        Write-Host "Origin set to $repoUrl" -ForegroundColor Green
    }

    # Detect current branch
    $branch = git branch --show-current
    if (-not $branch) {
        Write-Host "Cannot detect current branch." -ForegroundColor Red
        return
    }
    Write-Host "`nCurrent branch: $branch" -ForegroundColor Cyan

    # Fetch remote state
    Write-Host "Fetching remote state..." -ForegroundColor Cyan
    git fetch origin

    # Check if remote branch exists
    git rev-parse --verify "origin/$branch" 2>$null
    $remoteExists = ($LASTEXITCODE -eq 0)

    if (-not $remoteExists) {
        Write-Host "`nRemote branch does not exist (empty or new repo)." -ForegroundColor Green
        Write-Host "Pushing branch '$branch'..." -ForegroundColor Cyan
        git push -u origin $branch
        Write-Host "Push successful!" -ForegroundColor Green
        return
    }

    # Remote branch exists → check ahead/behind
    $behind  = git rev-list HEAD..origin/$branch --count
    $ahead   = git rev-list origin/$branch..HEAD --count

    if ($behind -gt 0) {
        Write-Host "`nRemote has $behind commit(s) ahead of your local branch." -ForegroundColor Yellow
        Write-Host "Pulling remote changes..." -ForegroundColor Cyan
        git pull --rebase origin $branch
        if ($LASTEXITCODE -ne 0) {
            Write-Host "Pull failed. Resolve conflicts manually and try again." -ForegroundColor Red
            return
        }
    }

    if ($ahead -eq 0) {
        Write-Host "`nNothing to push. Branch is up-to-date with remote." -ForegroundColor Green
        return
    }

    # Push local commits
    Write-Host "`nPushing $ahead commit(s) to '$branch'..." -ForegroundColor Cyan
    git push origin $branch

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`nPush successful!" -ForegroundColor Green
    } else {
        Write-Host "`nPush failed. Check your Git setup and try again." -ForegroundColor Red
    }
}


# ==================================================
# Clone & Remote Setup
# ==================================================

function gitClone {
    param([string]$RepoUrl, [string]$Folder)
    if ($Folder) { git clone $RepoUrl $Folder } else { git clone $RepoUrl }
}

function gitSetRemote {
    param([string]$Url)
    git remote remove origin 2>$null
    git remote add origin $Url
}

function gitShowRemotes { git remote -v }

function gitPreviewRemote {
    param(
        [string]$RemoteBranch,
        [string]$TempBranch = "temp-check"
    )

    # Fetch remote branches
    git fetch origin

    # Get list of remote branches
    $remoteBranches = git branch -r | ForEach-Object { $_.Trim() } | Where-Object { $_ -match "^origin/" } | ForEach-Object { $_ -replace "^origin/", "" }

    if (-not $RemoteBranch) {
        Write-Host "`nAvailable remote branches:" -ForegroundColor Cyan
        $i = 1
        foreach ($b in $remoteBranches) {
            Write-Host "$i. $b"
            $i++
        }

        $choice = Read-Host "Enter the number of the branch you want to preview"
        if ($choice -match "^\d+$" -and $choice -le $remoteBranches.Count -and $choice -ge 1) {
            $RemoteBranch = $remoteBranches[$choice - 1]
        } else {
            Write-Host "Invalid choice. Exiting." -ForegroundColor Red
            return
        }
    }

    Write-Host "`nPreviewing remote branch '$RemoteBranch' as local temp branch '$TempBranch'" -ForegroundColor Green

    # Delete temp branch if already exists
    if (git branch --list $TempBranch) {
        git branch -D $TempBranch
    }

    # Create temp branch from remote
    git checkout -b $TempBranch origin/$RemoteBranch
}


# ==================================================
# Daily Development
# ==================================================

function gitStatus { git status }

function gitAddCommit {
    param([string]$Message = "update")
    if (-not (git status --porcelain)) {
        Write-Host "No changes to commit." -ForegroundColor Yellow
        return
    }
    git add .
    git commit -m $Message
}

function gitPush {
    # Get current branch
    $branch = git branch --show-current
    if (-not $branch) {
        Write-Host "Unable to determine current branch." -ForegroundColor Red
        return
    }

    Write-Host "`nChecking status for '$branch'..." -ForegroundColor Cyan

    # Fetch latest from origin first
    git fetch origin

    # Count commits ahead and behind
    $ahead  = git rev-list origin/$branch..HEAD --count
    $behind = git rev-list HEAD..origin/$branch --count

    if ($behind -gt 0) {
        Write-Host " Your branch is behind origin by $behind commits." -ForegroundColor Yellow
        Write-Host "Pulling latest changes..." -ForegroundColor Cyan
        git pull origin $branch
    }

    if ($ahead -eq 0) {
        Write-Host " Nothing to push. '$branch' is already up to date." -ForegroundColor Green
        return
    }

    # Push commits
    Write-Host "Pushing $ahead commit(s) to '$branch'..." -ForegroundColor Cyan
    git push origin $branch

    if ($LASTEXITCODE -eq 0) {
        Write-Host "`n Push to '$branch' was successful!" -ForegroundColor Green
    } else {
        Write-Host "`n Push failed. Check your Git setup and try again." -ForegroundColor Red
    }
}


# ==================================================
# Feature Development (GitHub Flow)
# ==================================================

function gitNewBranch {
    param([string]$Name)

    if ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Host "Feature branch name required." -ForegroundColor Red
        Write-Host "Example: gitNewBranch feature-login" -ForegroundColor Yellow
        return
    }

    Write-Host "`nSwitching to main and syncing..." -ForegroundColor Cyan
    git switch main
    git pull origin main

    if (git branch --list $Name) {
        Write-Host "Branch '$Name' already exists." -ForegroundColor Yellow
        Write-Host "Use: gitSwitch $Name" -ForegroundColor Yellow
        return
    }

    git switch -c $Name
    Write-Host "Feature branch '$Name' created from main." -ForegroundColor Green
}

function gitSwitch {
    param([string]$Name)

    if ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Host "Branch name required." -ForegroundColor Red
        return
    }

    # Check if target branch exists
    if (-not (git branch --list $Name)) {
        Write-Host "Branch '$Name' does not exist." -ForegroundColor Red
        return
    }

    $stashCreated = $false

    # Detect uncommitted changes
    $status = git status --porcelain
    if ($status) {
        $currentBranch = git branch --show-current
        $stashMsg = "Auto-stash from branch '$currentBranch'"
        git stash push -m "$stashMsg"
        Write-Host "Uncommitted changes detected. Stashed as '$stashMsg'." -ForegroundColor Yellow
        $stashCreated = $true
    }

    # Switch branch
    git switch $Name
    Write-Host "Switched to branch '$Name'." -ForegroundColor Green

    # Show stash message only if a stash was actually created
    if ($stashCreated) {
        Write-Host "You can now apply the stash anytime with 'git stash list' and 'git stash apply <stash@{n}>'." -ForegroundColor Cyan
    }
}


function gitPushNewBranch {
    $branch = git branch --show-current

    if (-not $branch) {
        Write-Host "Could not detect current branch." -ForegroundColor Red
        return
    }

    if ($branch -eq "main") {
        Write-Host "Do NOT push new work directly to 'main'." -ForegroundColor Red
        Write-Host "Create a feature branch first." -ForegroundColor Yellow
        return
    }

    Write-Host "`nPushing feature branch '$branch'..." -ForegroundColor Cyan
    git push -u origin $branch

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Branch '$branch' pushed and upstream set." -ForegroundColor Green
        Write-Host "Open a Pull Request into 'main' on GitHub." -ForegroundColor Cyan
    } else {
        Write-Host "Push failed." -ForegroundColor Red
    }
}


# ==================================================
# Branch Maintenance
# ==================================================

function gitRenameBranch {
    param($Old, $New)
    git branch -m $Old $New
}

function gitDeleteBranch {
    param($Name)
    git branch -d $Name
}

function gitDeleteRemoteBranch {
    param($Name)
    git push origin --delete $Name
}

function gitBranchTrack { git branch -vv }


# ==================================================
# Merging & Sync
# ==================================================

function gitFetch { git fetch origin }

function gitPull {
    param([string]$Branch = "main")
    git pull origin $Branch
}

function gitMergeToMain {
    param([string]$Branch)

    if (-not $Branch) {
        Write-Host "Feature branch name required." -ForegroundColor Red
        return
    }

    Write-Host "Switching to main..." -ForegroundColor Cyan
    git switch main

    Write-Host "Pulling latest main..." -ForegroundColor Cyan
    git pull origin main

    Write-Host "Merging '$Branch' into main..." -ForegroundColor Cyan
    git merge $Branch

    Write-Host "Pushing main to origin..." -ForegroundColor Cyan
    git push origin main

    Write-Host "`nMerge completed successfully " -ForegroundColor Green
}



function gitMergeTempBranch {
    param(
        [string]$TempBranch = "stash-share"
    )

    # Step 0: Check if branch exists locally
    $localBranch = git branch --list $TempBranch
    if (-not $localBranch) {
        Write-Host "Branch '$TempBranch' does not exist locally. Checking remote..." -ForegroundColor Yellow
        $remoteBranch = git ls-remote --heads origin $TempBranch
        if (-not $remoteBranch) {
            Write-Host "Branch '$TempBranch' does not exist on remote either." -ForegroundColor Red
            return
        }

        # Step 0a: Fetch remote branch and create local tracking branch
        Write-Host "Fetching '$TempBranch' from remote..." -ForegroundColor Cyan
        git fetch origin ${TempBranch}:${TempBranch}   # <-- Fixed syntax
        Write-Host "Local tracking branch '$TempBranch' created." -ForegroundColor Green
    }

    # Step 1: Switch to main
    Write-Host "Switching to 'main' branch..." -ForegroundColor Cyan
    git switch main

    # Step 2: Pull latest changes from origin/main
    Write-Host "Pulling latest changes from 'origin/main'..." -ForegroundColor Cyan
    git pull origin main

    # Step 3: Merge the temp branch
    Write-Host "Merging '$TempBranch' into 'main'..." -ForegroundColor Cyan
    $mergeResult = git merge $TempBranch

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Merge successful! '$TempBranch' changes are now in 'main'." -ForegroundColor Green
    } else {
        Write-Host "Merge encountered conflicts. Resolve them manually." -ForegroundColor Yellow
    }
}


function gitMergeAbort { git merge --abort }


# ==================================================
# History & Logs
# ==================================================

function gitLog { git --no-pager log --oneline --graph --decorate --all }

function gitLog1 {
    param(
        [int]$Count = 10
    )

    if (-not (Test-Path ".git")) {
        Write-Host "This is not a Git repository." -ForegroundColor Red
        return
    }

    git log --oneline -n $Count
}


# ==================================================
# Diff & Inspection
# ==================================================

function gitDiff { git diff }

function gitDiffStaged { git diff --staged }

function gitDiffBranches {
    param($A, $B)
    git diff $A $B
}


# ==================================================
# Stash (Temporary Save)
# ==================================================

function gitStash {
    param(
        [string]$Message = "WIP"
    )

    if ([string]::IsNullOrWhiteSpace($Message)) {
        $Message = "WIP"
    }

    git stash push -m "$Message"
    Write-Host "Stash saved with message: '$Message'" -ForegroundColor Green
}

function gitStashList { git stash list }

function gitStashApply {
    param([string]$Ref = "stash@{0}")
    git stash apply $Ref
    Write-Host "Applied stash: $Ref" -ForegroundColor Green
}

function gitStashPop {
    param([string]$Ref = "stash@{0}")
    git stash pop $Ref
    Write-Host "Popped stash: $Ref" -ForegroundColor Green
}

function gitStashDrop {
    param([string]$Ref = "stash@{0}")
    git stash drop $Ref
    Write-Host "Dropped stash: $Ref" -ForegroundColor Green
}


function gitPushStash {
    param(
        [string]$TempBranch = "stash-share",
        [string]$CommitMessage = "Stashed changes",
        [switch]$DeleteAfterPush
    )

    # Step 1: Check if there is anything to stash
    $status = git status --porcelain
    if (-not $status) {
        Write-Host "Nothing to stash. Working directory clean." -ForegroundColor Yellow
        return
    }

    # Step 2: Create stash
    $stashRef = git stash push -m "$CommitMessage"
    Write-Host "Changes stashed locally: $stashRef" -ForegroundColor Green

    # Step 3: Create temporary branch
    git checkout -b $TempBranch
    Write-Host "Temporary branch '$TempBranch' created." -ForegroundColor Cyan

    # Step 4: Apply stash
    git stash apply
    Write-Host "Stash applied to '$TempBranch'." -ForegroundColor Cyan

    # Step 5: Commit the changes
    git add .
    git commit -m "$CommitMessage"
    Write-Host "Stash committed to '$TempBranch'." -ForegroundColor Green

    # Step 6: Push temporary branch to remote
    git push -u origin $TempBranch
    Write-Host "Temporary branch '$TempBranch' pushed to remote." -ForegroundColor Green

    # Step 7: Optionally delete the temp branch locally and/or stash entry
    if ($DeleteAfterPush) {
        git checkout main
        git branch -D $TempBranch
        git stash drop $stashRef
        Write-Host "Temporary branch '$TempBranch' and stash dropped." -ForegroundColor Yellow
    } else {
        Write-Host "You can now review or merge '$TempBranch' on remote." -ForegroundColor Cyan
    }
}


# ==================================================
# Undo & Recovery
# ==================================================

function gitUndoSoft { git reset --soft HEAD~1 }

function gitUndoSoftRemote {

    $branch = git branch --show-current
    if (-not $branch) {
        Write-Host "Cannot detect current branch." -ForegroundColor Red
        return
    }

    Write-Host "`nThis will REMOVE the last commit from:" -ForegroundColor Yellow
    Write-Host "• Local branch  : $branch" -ForegroundColor Cyan
    Write-Host "• Remote branch: origin/$branch" -ForegroundColor Cyan
    Write-Host "• Code will be KEPT (soft reset)" -ForegroundColor Green

    $confirm = Read-Host "`nAre you sure you want to continue? (y/n)"
    if ($confirm -ne "y") {
        Write-Host "Operation cancelled." -ForegroundColor Yellow
        return
    }

    Write-Host "`nUndoing last commit safely..." -ForegroundColor Yellow

    git reset --soft HEAD~1
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Local reset failed." -ForegroundColor Red
        return
    }

    git push origin $branch --force-with-lease
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Last commit removed from remote safely. Changes are preserved locally." -ForegroundColor Green
    } else {
        Write-Host "Remote push failed. Your local changes are still safe." -ForegroundColor Red
    }
}


function gitUndoHard {
    Write-Host "This will permanently delete changes!" -ForegroundColor Red
    if ((Read-Host "Continue? (y/n)") -eq "y") { git reset --hard HEAD~1 }
}

function gitReflog { git reflog }

function gitRestoreFromReflog {
    param($Ref)
    git reset --hard $Ref
}


# ==================================================
# Tags & Releases
# ==================================================

function gitTagCreate {
    param(
        [string]$Name,
        [string]$Msg
    )

    if ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Host "Tag name required." -ForegroundColor Red
        return
    }

    # Prevent duplicate tag creation
    if (git tag --list $Name) {
        Write-Host "Tag '$Name' already exists." -ForegroundColor Yellow
        return
    }

    if ($Msg) {
        git tag -a $Name -m "$Msg"
    } else {
        git tag $Name
    }

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Tag '$Name' created successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to create tag '$Name'." -ForegroundColor Red
    }
}


function gitTagPush {
    param($Name)
    if ($Name) { git push origin $Name } else { git push origin --tags }
}


function gitTagList {
    Write-Host "`nLocal tags:" -ForegroundColor Cyan
    git tag

    Write-Host "`nRemote tags (origin):" -ForegroundColor Cyan
    git ls-remote --tags origin |
        ForEach-Object {
            ($_ -split "refs/tags/")[1]
        } |
        Where-Object { $_ }
}

function gitTagDeleteLocal {
    param([string]$Name)

    if ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Host "Tag name required." -ForegroundColor Red
        return
    }

    # Check if tag exists locally
    if (-not (git tag --list $Name)) {
        Write-Host "Local tag '$Name' does not exist." -ForegroundColor Yellow
        return
    }

    git tag -d $Name

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Local tag '$Name' deleted successfully." -ForegroundColor Green
    } else {
        Write-Host "Failed to delete local tag '$Name'." -ForegroundColor Red
    }
}

function gitTagDeleteRemote {
    param([string]$Name)

    if ([string]::IsNullOrWhiteSpace($Name)) {
        Write-Host "Tag name required." -ForegroundColor Red
        return
    }

    # Check if tag exists on remote
    $remoteTag = git ls-remote --tags origin | Select-String "refs/tags/$Name$"

    if (-not $remoteTag) {
        Write-Host "Remote tag '$Name' does not exist on origin." -ForegroundColor Yellow
        return
    }

    git push origin :refs/tags/$Name

    if ($LASTEXITCODE -eq 0) {
        Write-Host "Remote tag '$Name' deleted from origin." -ForegroundColor Green
    } else {
        Write-Host "Failed to delete remote tag '$Name'." -ForegroundColor Red
    }
}


# ==================================================
# Cleanup & Utilities
# ==================================================

function gitCleanupMerged {
    git branch --merged main |
        Where-Object { $_ -notmatch "main" } |
        ForEach-Object { git branch -d $_.Trim() }
}

function gitCurrentBranch { git branch --show-current }




####################################################
#                 END — Git Toolkit                #
####################################################


























# ---------------------------------------------
# Android / RN Helper: Show Only Names or Full
# ---------------------------------------------
$AndroidRNFunctionDescriptions = @{
    "connectMyPhone"          = "Connect your Android phone via ADB using your custom script"
    "viewMyPhone"             = "Launch scrcpy to mirror your phone screen"
    "cleanADB"                = "Restart ADB server and show connected devices"
    "removeGhostDevices"      = "Detect and remove ghost/phantom ADB devices"
    "startEmulator"           = "Start one Android emulator from a list"
    "restartEmulator"         = "Kill all emulators, restart ADB, and reboot all AVDs (with spinner)"
    "fixReactNativeProject"   = "Run custom RN project fix script"
    "startMetro"              = "Restart Metro Bundler on port 8081 (fix port issues)"
    "runRNAppEmu"             = "Start emulator if needed and run RN Android app"
    "cleanAndroid"            = "Run Gradle clean inside /android"
    "startBackend"            = "Start backend server using npm run dev"
    "reactNative-RunAndroid"  = "Run React Native app on Android"
    "reactNative-resetBuild"  = "Reset all builds + reinstall dependencies"
}

function androidHelp {
    param([string]$Mode = "full")

    Write-Host "`nAndroid + React Native Helper Functions:`n" -ForegroundColor Cyan

    $sorted = $AndroidRNFunctionDescriptions.Keys | Sort-Object

    if ($Mode -eq "names") {
        foreach ($func in $sorted) {
            Write-Host $func -ForegroundColor Green
        }
        return
    }

    # DEFAULT → full descriptions
    foreach ($func in $sorted) {
        $desc = $AndroidRNFunctionDescriptions[$func]
        Write-Host ("{0,-30} : {1}" -f $func, $desc)
    }
}
# ---------------------------------------------



# Add NPM global binaries to PATH
$env:Path += ";C:\Users\SiamAR\AppData\Roaming\npm"


# Minimal profile: UTF‑8 + Oh My Posh (if installed) + Fastfetch with explicit config path
try {
    [Console]::InputEncoding  = [System.Text.Encoding]::UTF8
    [Console]::OutputEncoding = [System.Text.Encoding]::UTF8
    $OutputEncoding = [System.Text.UTF8Encoding]::new($false)
    chcp 65001 > $null
} catch {}

Clear-Host


# Force Fastfetch to use YOUR config every time (bypass path confusion)
if (Get-Command fastfetch -ErrorAction SilentlyContinue) {
    fastfetch -c "C:/Users/SiamAR/.config/fastfetch/config.jsonc"
} 
else {
    Write-Host " Fastfetch not found in PATH." -ForegroundColor Yellow
}


#connectMyPhone
function connectMyPhone {
    $scriptPath = "C:\AndroidScripts\connectMyPhone.ps1"

    if (-Not (Test-Path $scriptPath)) {
        Write-Host "Script not found at $scriptPath" -ForegroundColor Red
        return
    }

    # Run the script in the current session
    . $scriptPath
}


#viewMyPhone
function viewMyPhone {
    # Path to your custom scrcpy launcher batch
    $scrcpyBat = "C:\scrcpy-win64-v3.3.3\scrcpy-win64-v3.3.3\scrcpyCustom.bat"

    if (-Not (Test-Path $scrcpyBat)) {
        Write-Host "scrcpy launcher not found at $scrcpyBat" -ForegroundColor Red
        return
    }

    # Launch it in a separate window, like your original batch
    Start-Process -FilePath $scrcpyBat
}


# --- Fix ADB Connection ---
function cleanADB {
    Write-Host "`n Restarting ADB server..." -ForegroundColor Cyan
    & "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" kill-server
    & "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" start-server
    Write-Host "`n Current connected devices:`n" -ForegroundColor Yellow
    & "$env:LOCALAPPDATA\Android\Sdk\platform-tools\adb.exe" devices
    Write-Host "`n ADB restarted successfully.`n" -ForegroundColor Green
}


#removeGhostDevices
function removeGhostDevices {
    Write-Host ""
    Write-Host "Checking for ghost ADB devices..."

    $ghostList = adb devices | Select-String "_adb-tls-connect"

    if (-not $ghostList) {
        Write-Host "No ghost devices found."
        return
    }

    Write-Host ""
    Write-Host "Ghost devices detected:"

    foreach ($g in $ghostList) {
        $id = $g.ToString().Split()[0]
        Write-Host "Removing: $id"
        adb disconnect $id | Out-Null
    }

    Write-Host ""
    Write-Host "All ghost devices removed."
}


#startEmulator
function startEmulator {
    $emulatorPath = "C:\Users\SiamAR\AppData\Local\Android\Sdk\emulator\emulator.exe"

    if (-not (Test-Path $emulatorPath)) {
        Write-Host "Emulator not found at $emulatorPath" -ForegroundColor Red
        return
    }

    # Get list of AVDs as array of strings
    $avdList = @(& $emulatorPath -list-avds 2>$null)

    if (-not $avdList -or $avdList.Count -eq 0) {
        Write-Host "No Android Virtual Devices found. Create one in Android Studio → AVD Manager." -ForegroundColor Red
        return
    }

    Write-Host "`nAvailable Emulators:`n"
    for ($i = 0; $i -lt $avdList.Count; $i++) {
        Write-Host "$($i + 1). $($avdList[$i].ToString().Trim())"
    }

    $choice = Read-Host "`nEnter number to start"

    if ($choice -match '^\d+$' -and [int]$choice -ge 1 -and [int]$choice -le $avdList.Count) {
        $selectedAvd = $avdList[[int]$choice - 1].ToString().Trim()
        Write-Host "`nStarting emulator: $selectedAvd"
        & $emulatorPath -avd $selectedAvd
    } else {
        Write-Host "Invalid selection." -ForegroundColor Yellow
    }
}


#restartEmulator
function restartEmulator {
    Write-Host "======================================================" -ForegroundColor DarkCyan
    Write-Host "            Restarting Android Emulators..." -ForegroundColor Cyan
    Write-Host "======================================================" -ForegroundColor DarkCyan

    # Step 1: Kill all running emulator processes
    Write-Host "`nStopping any running emulator processes..." -ForegroundColor Yellow
    "qemu-system-x86_64","qemu-system-aarch64" | ForEach-Object {
        Get-Process -Name $_ -ErrorAction SilentlyContinue | Stop-Process -Force
    }
    Start-Sleep -Seconds 2

    # Step 2: Restart ADB
    Write-Host "`nRestarting ADB..." -ForegroundColor Yellow
    adb kill-server
    adb start-server
    Start-Sleep -Seconds 2

    # Step 3: Get all available AVDs
    $emulatorPath = "C:\Users\SiamAR\AppData\Local\Android\Sdk\emulator\emulator.exe"
    $avdList = @(& $emulatorPath -list-avds 2>$null) | ForEach-Object { $_.Trim() }

    if (-not $avdList -or $avdList.Count -eq 0) {
        Write-Host "No AVDs found. Please create one in Android Studio → AVD Manager." -ForegroundColor Red
        return
    }

    Write-Host "`nAvailable AVDs:" -ForegroundColor Cyan
    $avdList | ForEach-Object { Write-Host "  - $_" -ForegroundColor Cyan }

    # Spinner characters
    $spinnerChars = @('|','/','-','\')

    # Step 4: Start each selected AVD
    $startedEmulators = @()  # Track which emulators actually started

    foreach ($avd in $avdList) {
        Write-Host "`n------------------------------------------------------" -ForegroundColor DarkCyan
        Write-Host "Ready to start emulator '$avd'." -ForegroundColor Cyan
        Write-Host "Please follow the prompt to continue...`n" -ForegroundColor DarkCyan
        Write-Host "------------------------------------------------------`n" -ForegroundColor DarkCyan

        # Start the emulator with no GUI prompt
        Start-Process -FilePath $emulatorPath -ArgumentList "-avd $avd" -NoNewWindow

        # Step 5: Wait until emulator is online
        Write-Host "Waiting for $avd to fully boot..." -ForegroundColor Yellow -NoNewline
        $timeout = 600      # maximum wait time in seconds
        $elapsed = 0
        $interval = 2
        $spinnerIndex = 0
        $isOnline = $false

        while ($elapsed -lt $timeout) {
            $devices = adb devices | ForEach-Object { ($_ -split "`t")[0] } | Where-Object { $_ -match "^emulator-\d+" }

            foreach ($dev in $devices) {
                try {
                    $state = adb -s $dev get-state 2>$null
                    if ($state -eq "device") {
                        $isOnline = $true
                        break
                    }
                } catch {}
            }

            if ($isOnline) {
                Write-Host "`r$avd is fully online! " -ForegroundColor Green
                $startedEmulators += $avd
                break
            }

            # Display spinner
            Write-Host -NoNewline "`rBooting $avd... $($spinnerChars[$spinnerIndex])" -ForegroundColor Blue
            $spinnerIndex = ($spinnerIndex + 1) % $spinnerChars.Count


            Start-Sleep -Seconds $interval
            $elapsed += $interval
        }

        if (-not $isOnline) {
            Write-Host "`r$avd did not boot in time." -ForegroundColor Red
        }

        Write-Host "`n------------------------------------------------------`n" -ForegroundColor DarkCyan
    }

    # Step 6: Final message with actually started emulators
    Write-Host "======================================================" -ForegroundColor DarkCyan
    if ($startedEmulators.Count -gt 0) {
        Write-Host "Started emulator(s): $($startedEmulators -join ', ')" -ForegroundColor Cyan
    } else {
        Write-Host "No emulators were started." -ForegroundColor Red
    }
    Write-Host "======================================================" -ForegroundColor DarkCyan
}


# Function 1: Clean Android Project
function cleanAndroid {
    Write-Host "Cleaning Android Project..."
    Set-Location -Path "android"
    ./gradlew clean
    Set-Location -Path ..
}


# Function 2: Start Backend Development Server
function startBackend {
    Write-Host "Starting Backend Server..."
    Set-Location -Path ".\backend"
    npm run dev
    Set-Location -Path ..
}


# Function 3: Run React Native Android App
function reactNative-RunAndroid {
    Write-Host "Running React Native Android..."
    yarn react-native run-android --active-arch-only
}


function reactNative-resetBuild {
    Write-Host "Stopping Node processes..." -ForegroundColor Yellow
    Stop-Process -Name node -ErrorAction SilentlyContinue

    Write-Host "Cleaning project directories..." -ForegroundColor Yellow
    rm -Recurse -Force android\.gradle 2>$null
    rm -Recurse -Force android\app\.cxx 2>$null
    rm -Recurse -Force android\build 2>$null
    rm -Recurse -Force android\app\build 2>$null
    rm -Recurse -Force android\app\build\generated\autolinking 2>$null
    rm -Recurse -Force node_modules 2>$null
    rm -Force yarn.lock 2>$null

    Write-Host "Clearing NPM cache..." -ForegroundColor Yellow
    npm cache clean --force

    Write-Host "Installing dependencies with Yarn..." -ForegroundColor Yellow
    yarn install

    Write-Host "Rebuilding Gradle..." -ForegroundColor Yellow
    Push-Location android
    .\gradlew clean
    Pop-Location

}


#fixReactNativeProject
function fixReactNativeProject { param($path) & "C:\AndroidScripts\fixReactNativeProject.ps1" -projectPath $path }

# Now try from anywhere:

# fixReactNativeProject "P:\Code_Vault\React_Native\testProject01"

# or, if you’re already inside the project folder:

# fixReactNativeProject .



#fixMetro
function startMetro {
    Write-Host "Killing all Node/Metro processes..." -ForegroundColor Yellow
    taskkill /F /IM node.exe /T 2>$null
    Write-Host "Starting Metro Bundler on port 8081 (cache cleared)..." -ForegroundColor Green
    npx react-native start --port 8081 --reset-cache
}


#runRNAppEmu
function runRNAppEmu {
    param(
        [string]$ProjectPath = (Get-Location)
    )

    # Go to project directory
    Set-Location $ProjectPath

    # Check if any emulator is running
    $emulator = adb devices | Where-Object { $_ -match 'emulator' -and $_ -notmatch 'offline|unauthorized' }

    if (-not $emulator) {
        Write-Host "No emulator running. Starting emulator..."
        
        # List available emulators
        $emulators = & "$env:ANDROID_SDK_ROOT\emulator\emulator.exe" -list-avds
        $i = 1
        $emulators | ForEach-Object { Write-Host "$i. $_"; $i++ }
        
        $choice = Read-Host "Enter number to start"
        $selectedEmu = $emulators[$choice - 1]

        # Start emulator in background
        Start-Process -FilePath "$env:ANDROID_SDK_ROOT\emulator\emulator.exe" -ArgumentList "-avd $selectedEmu" -NoNewWindow
        Write-Host "Starting emulator: $selectedEmu"

        # Wait until device is online
        do {
            Start-Sleep -Seconds 2
            $emulator = adb devices | Where-Object { $_ -match 'emulator' -and $_ -notmatch 'offline|unauthorized' }
        } until ($emulator)
    } else {
        Write-Host "Emulator already running."
    }

    # Run React Native app
    Write-Host "Running React Native app..."
    npx react-native run-android
}





function enter-adminShell {
    [CmdletBinding()]
    param()

    Start-Process powershell -Verb RunAs
}



# End of PowerShell Profile