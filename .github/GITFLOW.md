# GitFlow Workflow Guide for iOS Timer App

## 🌊 Branch Structure

### Main Branches
- **`main`** - Production-ready code (protected)
- **`develop`** - Integration branch for features

### Supporting Branches
- **`feature/*`** - New features
- **`release/*`** - Release preparation
- **`hotfix/*`** - Emergency fixes for production
- **`bugfix/*`** - Non-emergency bug fixes

## 🔄 Workflow Rules

### 1. Feature Development
```bash
# Start a new feature
git checkout develop
git pull origin develop
git checkout -b feature/your-feature-name

# Work on feature...
git add .
git commit -m "feat: describe your feature"

# Finish feature
git push origin feature/your-feature-name
# Create PR to develop branch
```

### 2. Release Process
```bash
# Start release
git checkout develop
git pull origin develop
git checkout -b release/1.x.x

# Prepare release...
# Update version numbers, final testing

# Finish release
git push origin release/1.x.x
# Create PR to main AND develop
```

### 3. Hotfix Process
```bash
# Start hotfix
git checkout main
git pull origin main
git checkout -b hotfix/fix-description

# Fix issue...
git push origin hotfix/fix-description
# Create PR to main AND develop
```

## 📝 Commit Message Convention

We follow [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` New feature
- `fix:` Bug fix
- `docs:` Documentation changes
- `style:` Code style changes (formatting, etc.)
- `refactor:` Code refactoring
- `test:` Test additions or changes
- `chore:` Build process or auxiliary tool changes
- `perf:` Performance improvements

### Examples:
```
feat: add splash screen with motivational quotes
fix: resolve timer display padding issue
docs: update README with GitFlow information
style: apply Bungee font consistently
refactor: optimize color manager implementation
```

## 🤝 Collaboration Protocol

### Before Starting Work
1. **Discuss the task** - We'll plan together
2. **Create an issue** - Document what we're building
3. **Choose branch type** - feature/bugfix/etc.
4. **Update local** - Always pull latest changes

### During Development
1. **Regular commits** - Small, focused changes
2. **Test thoroughly** - Run the app, check all features
3. **Update documentation** - Keep README current
4. **Communicate progress** - Let me know if you need help

### Code Review Process
1. **Self-review** - Check your changes first
2. **Create PR** - With detailed description
3. **Request review** - Tag relevant reviewers
4. **Address feedback** - Make requested changes
5. **Merge** - After approval

## 🚀 Version Numbering

We use Semantic Versioning (MAJOR.MINOR.PATCH):
- **MAJOR** - Breaking changes
- **MINOR** - New features (backwards compatible)
- **PATCH** - Bug fixes

Current Version: 1.0.0

## 📋 Checklist for Each Session

When we work together:
1. [ ] Check current branch
2. [ ] Pull latest changes
3. [ ] Discuss goals for session
4. [ ] Create/update issues
5. [ ] Work on appropriate branch
6. [ ] Test changes
7. [ ] Commit with proper messages
8. [ ] Push and create PR if ready
9. [ ] Update documentation
10. [ ] Plan next steps

## 🛡️ Branch Protection Rules

### Main Branch
- Require pull request reviews
- Dismiss stale reviews
- Require status checks
- Include administrators
- No force pushes

### Develop Branch
- Require pull request reviews
- Require up-to-date branches
- No direct pushes

## 🔧 GitFlow Commands Reference

```bash
# Check current branch
git branch

# Switch to develop
git checkout develop

# Create feature branch
git checkout -b feature/feature-name

# Push changes
git push origin feature/feature-name

# Create pull request
gh pr create --base develop

# Merge PR
gh pr merge --merge

# Delete local branch
git branch -d feature/feature-name

# Delete remote branch
git push origin --delete feature/feature-name
```

## 📊 Current Project Status

- **Current Version**: 1.0.0
- **Active Branch**: develop
- **Next Features**: TBD in discussion
- **Known Issues**: None

---

*Last Updated: [Current Date]*
*Maintained by: @yashthakur1 & Claude*