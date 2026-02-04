# 🎯 Git Commands Cheat Sheet

Essential Git commands for daily development workflow.

## 📑 Table of Contents
- [Setup](#setup)
- [Creating Repositories](#creating-repositories)
- [Basic Commands](#basic-commands)
- [Branching](#branching)
- [Remote Repositories](#remote-repositories)
- [Undoing Changes](#undoing-changes)
- [Stashing](#stashing)
- [Viewing History](#viewing-history)
- [Tags](#tags)
- [Advanced](#advanced)

---

## Setup

```bash
# Set your identity
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Set default branch name
git config --global init.defaultBranch main

# Set default editor
git config --global core.editor "code --wait"

# Enable colored output
git config --global color.ui true

# View all settings
git config --list

# Get help
git help <command>
```

## Creating Repositories

```bash
# Initialize a new repository
git init

# Clone an existing repository
git clone <url>

# Clone to specific directory
git clone <url> <directory>

# Clone specific branch
git clone -b <branch> <url>
```

## Basic Commands

```bash
# Check status
git status

# Add files to staging
git add <file>
git add .                    # Add all files
git add *.js                 # Add all JS files

# Commit changes
git commit -m "Commit message"
git commit -am "Message"     # Add and commit in one step

# View differences
git diff                     # Unstaged changes
git diff --staged            # Staged changes
git diff HEAD                # All changes

# Remove files
git rm <file>
git rm --cached <file>       # Remove from Git, keep locally

# Move/rename files
git mv <old> <new>
```

## Branching

```bash
# List branches
git branch                   # Local branches
git branch -a                # All branches
git branch -r                # Remote branches

# Create new branch
git branch <branch-name>

# Switch branches
git checkout <branch-name>
git switch <branch-name>     # Modern way

# Create and switch
git checkout -b <branch-name>
git switch -c <branch-name>  # Modern way

# Delete branch
git branch -d <branch-name>  # Safe delete
git branch -D <branch-name>  # Force delete

# Rename branch
git branch -m <old> <new>

# Merge branches
git merge <branch-name>

# Rebase
git rebase <branch-name>
git rebase --continue
git rebase --abort
```

## Remote Repositories

```bash
# View remotes
git remote
git remote -v                # Verbose

# Add remote
git remote add origin <url>

# Remove remote
git remote remove <name>

# Rename remote
git remote rename <old> <new>

# Fetch changes
git fetch
git fetch <remote>

# Pull changes
git pull
git pull origin main

# Push changes
git push
git push origin main
git push -u origin main      # Set upstream

# Push all branches
git push --all

# Push tags
git push --tags

# Delete remote branch
git push origin --delete <branch>
```

## Undoing Changes

```bash
# Discard changes in working directory
git restore <file>
git checkout -- <file>       # Old way

# Unstage files
git restore --staged <file>
git reset HEAD <file>        # Old way

# Amend last commit
git commit --amend
git commit --amend --no-edit

# Reset to specific commit
git reset --soft HEAD~1      # Keep changes
git reset --mixed HEAD~1     # Unstage changes
git reset --hard HEAD~1      # Discard changes

# Revert commit (create new commit)
git revert <commit-hash>

# Clean untracked files
git clean -n                 # Dry run
git clean -f                 # Remove files
git clean -fd                # Remove files and directories
```

## Stashing

```bash
# Stash changes
git stash
git stash save "message"

# List stashes
git stash list

# Apply stash
git stash apply
git stash apply stash@{0}

# Pop stash (apply and remove)
git stash pop

# Drop stash
git stash drop stash@{0}

# Clear all stashes
git stash clear

# Show stash contents
git stash show
git stash show -p
```

## Viewing History

```bash
# View commit history
git log
git log --oneline
git log --graph
git log --all --graph --decorate --oneline

# View specific file history
git log <file>
git log -p <file>            # Show changes

# View commits by author
git log --author="name"

# View commits in date range
git log --since="2 weeks ago"
git log --after="2024-01-01"
git log --before="2024-12-31"

# Search commits
git log --grep="keyword"
git log -S "code"            # Search code changes

# Show specific commit
git show <commit-hash>

# Blame (who changed what)
git blame <file>
```

## Tags

```bash
# List tags
git tag

# Create tag
git tag <tag-name>
git tag -a v1.0 -m "Version 1.0"

# Tag specific commit
git tag <tag-name> <commit-hash>

# Push tags
git push --tags
git push origin <tag-name>

# Delete tag
git tag -d <tag-name>
git push origin --delete <tag-name>

# Checkout tag
git checkout <tag-name>
```

## Advanced

```bash
# Cherry-pick commit
git cherry-pick <commit-hash>

# Interactive rebase
git rebase -i HEAD~3

# Squash commits
git rebase -i HEAD~3
# Change 'pick' to 'squash' for commits to combine

# Find commit that introduced bug
git bisect start
git bisect bad
git bisect good <commit>

# View reflog (command history)
git reflog

# Archive repository
git archive --format=zip --output=archive.zip main

# Submodules
git submodule add <url>
git submodule update --init --recursive

# Show who contributed
git shortlog -sn

# Count commits
git rev-list --count HEAD

# Find commits that affect specific lines
git log -L 1,10:file.txt
```

## 💡 Common Workflows

### Starting a New Feature

```bash
git checkout main
git pull
git checkout -b feature/new-feature
# Make changes
git add .
git commit -m "Add new feature"
git push -u origin feature/new-feature
```

### Updating Feature Branch

```bash
git checkout main
git pull
git checkout feature/new-feature
git merge main
# Or use rebase
git rebase main
```

### Creating a Release

```bash
git checkout main
git pull
git tag -a v1.0.0 -m "Release version 1.0.0"
git push --tags
```

### Fixing a Mistake

```bash
# Undo last commit but keep changes
git reset --soft HEAD~1

# Completely undo last commit
git reset --hard HEAD~1

# Fix commit message
git commit --amend -m "New message"
```

### Emergency Bug Fix

```bash
git stash                    # Save current work
git checkout main
git checkout -b hotfix/bug-fix
# Fix bug
git commit -am "Fix critical bug"
git checkout main
git merge hotfix/bug-fix
git branch -d hotfix/bug-fix
git stash pop                # Restore work
```

## 🛠️ Git Aliases

Add these to your `~/.gitconfig`:

```ini
[alias]
    st = status
    co = checkout
    br = branch
    ci = commit
    unstage = restore --staged
    last = log -1 HEAD
    visual = log --all --graph --decorate --oneline
    amend = commit --amend --no-edit
    undo = reset --soft HEAD~1
```

## 📚 Learn More

- [Official Git Documentation](https://git-scm.com/doc)
- [Git Book](https://git-scm.com/book/en/v2)
- [GitHub Git Cheat Sheet](https://training.github.com/)

---

**Happy Coding! 🎉**
