## MY STRATEGY (REBASE THEN SQUASH) THEN FAST FORWARD MERGE

## GIT CONFIG

1. Global (~/.gitconfig) - for all projects
2. Local (.git/config) - for specific project

## GIT CONFIG OPERATIONS

Config Commands: (list, add, get, set, unset, unset-all, remove-section)

1. git config --command --location section.key

## GIT FILE STATES

1. untracked - never indexed
2. staged - in the index
3. commited

## GIT OPERATIONS

1. checking status (git status)
2. staging a file (git add . OR git add file uri OR git add . -p (for hunks but you can do easily with editor instead its easier))
3. commiting changes (git commit -m "Message")
4. logging (git --no-pager log --oneline --graph --decorate --parents --all -number -p)

## GIT MERGE (MERGE BASE HAS MORE COMMITS ON TOP)

Merge: results in a merge commit with two parents

1. git merge branch-name

## GIT MERGE (MERGE BASE DOES NOT HAVE COMMITS ON TOP)

Merge: fast forward (merge no merge commit)

1. git merge branch-name

## GIT REBASE (ALLOWS FOR FAST FORWARD MERGE)

- Rebase: moves the merge base to the main's latest commit
- Note: rebase on OTHER BRANCHES not MAIN
- Tip: prepare commits, rebase, squash, fast forward merge(on main)

1. git rebase main

## GIT RESET (UNDO THE LAST COMMIT(S) OR ANY CHANGES IN THE index)

- Soft: COMMITTED changes will be UNCOMMITTED AND STAGED, while UNCOMMITTED changes will remain STAGED OR UNSTAGED as before.
- Soft: Good when you MESS up REVERT, CHERRYPICK OR REBASE
- Hard: Good when you want to go back to previous commit and DISCARD ALL the changes.

1. git reset --soft commit-hash OR git reset --soft HEAD~number
2. git reset --hard commit-hash OR git reset --hard HEAD~number
3. git commit --amend (edit the last commit)

## GIT REMOTE (EXTERNAL REPOS OFTEN ORIGIN)

- Tip: git ls-remote
- Tip: git remote -v
- Tip: git remote rm remote-name
- Tip: git push remote-name branch-name
- Tip: git pull remote-name branch-name

1. git remote add remote-name remote-uri
2. git fetch (gets the metadata)
3. git log remote/branch
4. git merge remote/branch

## TEAM WORKFLOW (PULL.REBASE = TRUE)

- Tip: git pull origin main
- Tip: git checkout -b feature-branch
- Tip: prepare my commits in feature branch
- Tip: rebase against the origin/main
- Tip: squash into a single commit
- Tip: git push origin feature-branch
- Tip: open a pull request on github for my changes to be added onto main
- Tip: wait for review by a team member
- Tip: once approved click on merge button on github to merge my changes onto main
- Tip: delete my feature branch and start with another branch for new changes

## GIT PLUMBING

Git stores an entire snapshot of files on a per commit level.
Tree: git's way of storing a directory
Blob: git's way of storing a file

1. git cat-file -p commit-hash
2. git cat-file -p tree-hash
3. git cat-file -p blob-hash

## GIT BRANCHES

Git branch: a named pointer to a specific commit

1. list branches (git branch)
2. rename branch (git branch -m oldname newname)
3. create branch head (git checkout -b branch-name OR git switch -c branch-name)
4. create branch specific commit (git checkout -b branch-name commit-hash OR git switch -c branch-name commit-hash)
5. change branch (git checkout branch-name OR git switch branch-name)
