# 🔗 Git Configuration & Version Control

Complete guide to setting up Git and using version control.

## Prerequisites

- Git v2.40+ installed
- GitHub account (optional but recommended)
- Basic command line knowledge

## Git Installation

### Verify Installation

```powershell
git --version
git config --list
```

### Initial Configuration

```powershell
# Set your name
git config --global user.name "Your Name"

# Set your email
git config --global user.email "your-email@example.com"

# Set default editor
git config --global core.editor "code --wait"

# Set pull strategy
git config --global pull.rebase true

# Set default branch name
git config --global init.defaultBranch main

# View all config
git config --list
```

---

## Repository Setup

### Create New Repository

```powershell
# Create project directory
mkdir my-project
cd my-project

# Initialize git repository
git init

# Create first file
@"
# My Project

This is my awesome project!
"@ | Out-File README.md

# Add files
git add README.md

# Commit
git commit -m "Initial commit"

# Check status
git status
```

### Clone Existing Repository

```powershell
# Clone a repository
git clone https://github.com/username/repository.git

# Clone into specific directory
git clone https://github.com/username/repository.git my-folder

# Navigate to cloned repo
cd repository
```

---

## Basic Git Workflow

### Daily Workflow

```powershell
# 1. Check status
git status

# 2. Make changes to files

# 3. Stage changes
git add file.txt              # Add specific file
git add .                     # Add all changes
git add src/                  # Add entire directory

# 4. Commit changes
git commit -m "Describe your changes"

# 5. Push to remote
git push origin main

# 6. Pull latest changes
git pull origin main
```

### Example Workflow

```powershell
# 1. Create a new feature branch
git checkout -b feature/user-auth

# 2. Make changes
echo "New feature code" >> feature.js

# 3. Stage and commit
git add feature.js
git commit -m "Add user authentication"

# 4. Push to remote
git push origin feature/user-auth

# 5. Create pull request on GitHub
# (Then merge and delete branch)

# 6. Back to main
git checkout main

# 7. Pull latest
git pull origin main

# 8. Delete local branch
git branch -d feature/user-auth
```

---

## Essential Git Commands

### Status & Information

```powershell
# Check repository status
git status

# View commit history
git log

# View commit history (one line)
git log --oneline

# View commits by author
git log --author="John Doe"

# View commits since date
git log --since="2 weeks ago"

# View specific commits
git show <commit-hash>

# View differences
git diff                        # Unstaged changes
git diff --staged              # Staged changes
git diff HEAD~1                # Last commit
```

### Staging & Committing

```powershell
# Stage specific file
git add file.txt

# Stage all changes
git add .

# Stage with interactive selection
git add -i

# Unstage file
git reset HEAD file.txt

# Discard changes
git checkout -- file.txt

# Commit staged changes
git commit -m "Your commit message"

# Commit all tracked files
git commit -am "Your message"

# Amend last commit
git commit --amend

# Undo last commit (keep changes)
git reset --soft HEAD~1

# Undo last commit (discard changes)
git reset --hard HEAD~1
```

### Branches

```powershell
# List all branches
git branch

# List remote branches
git branch -r

# List all branches
git branch -a

# Create new branch
git branch feature/new-feature

# Create and switch to new branch
git checkout -b feature/new-feature

# Switch to branch
git checkout main

# Delete branch (local)
git branch -d feature/new-feature

# Force delete branch
git branch -D feature/new-feature

# Delete remote branch
git push origin --delete feature/new-feature

# Rename branch
git branch -m old-name new-name

# Rename and push
git push origin --delete old-name
git push origin new-name
```

### Remote Repositories

```powershell
# List remote repositories
git remote -v

# Add remote repository
git remote add origin https://github.com/user/repo.git

# Remove remote
git remote remove origin

# Change remote URL
git remote set-url origin https://github.com/user/new-repo.git

# Fetch changes (doesn't merge)
git fetch origin

# Pull changes (fetch + merge)
git pull origin main

# Push commits
git push origin main

# Push all branches
git push -u origin --all

# Push specific branch
git push origin feature/my-feature

# Force push (use with caution!)
git push origin main --force
```

---

## Branching Strategy

### Git Flow

```
main branch
├── release-1.0
└── release-2.0

develop branch
├── feature/user-auth
├── feature/payment
└── bugfix/login-error

hotfix branch
└── hotfix/critical-bug
```

### Main Branches

**main** - Production-ready code
```powershell
# Only merge when releasing
git checkout main
git merge --no-ff release/1.0.0
git tag -a v1.0.0 -m "Version 1.0.0"
```

**develop** - Development branch
```powershell
# Daily development work
git checkout develop
git merge --no-ff feature/new-feature
```

### Supporting Branches

**feature/** - New features
```powershell
git checkout -b feature/user-profile develop
# ... make changes ...
git push origin feature/user-profile
# Create pull request on GitHub
# Merge when approved
git checkout develop
git merge --no-ff feature/user-profile
git push origin develop
```

**bugfix/** - Bug fixes
```powershell
git checkout -b bugfix/login-error develop
# ... fix bug ...
git push origin bugfix/login-error
# Create pull request
# Merge when fixed
```

**hotfix/** - Critical production fixes
```powershell
git checkout -b hotfix/security-patch main
# ... fix critical issue ...
git checkout main
git merge --no-ff hotfix/security-patch
git tag v1.0.1
git push origin main

git checkout develop
git merge --no-ff hotfix/security-patch
git push origin develop
```

---

## Pull Requests (GitHub Workflow)

### Create Pull Request

1. Create and push feature branch
```powershell
git checkout -b feature/new-feature
# Make changes
git push origin feature/new-feature
```

2. Go to GitHub and create Pull Request
3. Add description and request reviewers
4. Wait for reviews and CI/CD checks
5. Make requested changes if needed
6. Merge when approved

### Review Pull Request

```powershell
# Checkout PR branch
git fetch origin pull/123/head:pr-123
git checkout pr-123

# Review changes
# Test locally

# Approve and merge on GitHub
```

---

## Merge Conflicts

### When Conflicts Occur

```powershell
# Try to merge
git merge feature/other-feature

# View conflicting files
git status

# Edit files to resolve conflicts
# Files will have markers like:
# <<<<<<< HEAD
# your code
# =======
# their code
# >>>>>>> feature/other-feature
```

### Resolve Conflicts

```powershell
# After editing files:

# Stage resolved files
git add resolved-file.js

# Complete merge
git commit -m "Resolve merge conflicts"

# Or abort merge
git merge --abort
```

---

## Stashing

### Temporarily Save Changes

```powershell
# Stash current changes
git stash

# Stash with message
git stash save "WIP: new feature"

# List stashes
git stash list

# Apply stash (keeps it)
git stash apply stash@{0}

# Pop stash (removes it)
git stash pop stash@{0}

# Delete stash
git stash drop stash@{0}

# Delete all stashes
git stash clear
```

---

## Tags

### Create Tags

```powershell
# Create lightweight tag
git tag v1.0.0

# Create annotated tag
git tag -a v1.0.0 -m "Version 1.0.0"

# List tags
git tag

# Show tag details
git show v1.0.0

# Push tags to remote
git push origin v1.0.0

# Push all tags
git push origin --tags

# Delete local tag
git tag -d v1.0.0

# Delete remote tag
git push origin --delete v1.0.0
```

---

## .gitignore

### Create .gitignore File

```powershell
@"
# Dependencies
node_modules/
venv/
__pycache__/

# Environment variables
.env
.env.local

# IDE
.vscode/
.idea/
*.swp
*.swo

# Build
dist/
build/
*.pyc

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Temporary
temp/
tmp/
"@ | Out-File .gitignore

git add .gitignore
git commit -m "Add .gitignore"
```

---

## Common Issues & Solutions

### Issue: Forgot to stage file

```powershell
git add forgotten-file.js
git commit --amend --no-edit
```

### Issue: Wrong commit message

```powershell
git commit --amend -m "Correct message"
```

### Issue: Accidentally committed to wrong branch

```powershell
# Create correct branch from this point
git branch correct-branch

# Reset current branch
git reset --hard origin/main

# Switch to correct branch
git checkout correct-branch
```

### Issue: Need to undo pushed commits

```powershell
# Local undo (keep changes)
git reset --soft HEAD~1

# Or create revert commit
git revert <commit-hash>
```

---

## Best Practices

1. **Commit frequently** - Small, logical commits are better
2. **Write clear messages** - Describe what, not how
3. **Use branches** - One feature per branch
4. **Review code** - Use pull requests
5. **Keep main stable** - Only merge working code
6. **Don't force push** - Unless absolutely necessary
7. **Pull before push** - Avoid conflicts
8. **Use meaningful branch names** - feature/, bugfix/, hotfix/
9. **Tag releases** - Mark stable versions
10. **Document changes** - Update README, CHANGELOG

---

## Resources

- [Git Official Docs](https://git-scm.com/doc)
- [GitHub Docs](https://docs.github.com/)
- [Git Branching Model](https://nvie.com/posts/a-successful-git-branching-model/)
- [Commit Message Guidelines](https://www.conventionalcommits.org/)

