# Claude Code Configuration & Rules

## 🤖 Project Context

This is an iOS Timer/Stopwatch app built with SwiftUI. Key characteristics:
- **Design**: Bold, energetic with Bungee font and random vibrant backgrounds
- **Features**: Timer, lap tracking, motivational quotes on splash screen
- **Workflow**: GitFlow with collaborative development

## 📋 Development Rules

### 1. GitFlow Compliance
- **ALWAYS** work on appropriate branches (never directly on main)
- **ALWAYS** create PRs for code review
- **ALWAYS** use conventional commits

### 2. Collaboration Protocol
- **DISCUSS** before implementing major changes
- **PLAN** features using session templates
- **TEST** all changes before committing
- **DOCUMENT** any new features or changes

### 3. Code Standards
- **Font**: Use Bungee font for all UI text
- **Colors**: Maintain vibrant color scheme with white text
- **Style**: Follow existing SwiftUI patterns
- **Testing**: Ensure app builds and runs before committing

## 🛠️ Available Tools

### Scripts
- `./collaborate.sh` - Interactive collaboration helper
- `./github-repo-update.sh` - Repository management
- `./setup-github-cli.sh` - GitHub CLI setup

### Workflows
- PR checks on all pull requests
- Auto-update repository info

## 🎯 Current Focus

- Version: 1.0.0
- Branch: develop
- Status: Ready for new features

## 💡 Quick Commands

```bash
# Start new feature
./collaborate.sh  # Choose option 1

# Check status
git status

# Update repository info
./github-repo-update.sh update

# Create PR
gh pr create --base develop
```

## 🚨 Important Notes

1. **Branch Protection**: main and develop are protected
2. **Commits**: Use conventional format (feat:, fix:, docs:, etc.)
3. **PRs**: Required for all changes
4. **Testing**: Build locally before pushing

## 📝 Session Workflow

1. Run `./collaborate.sh`
2. Discuss goals
3. Create appropriate branch
4. Implement changes
5. Test thoroughly
6. Commit with proper message
7. Push and create PR
8. Update documentation

## 🔗 Resources

- [GitFlow Guide](.github/GITFLOW.md)
- [Session Template](.github/SESSION_TEMPLATE.md)
- [Branch Protection](.github/branch-protection.md)
- [Repository](https://github.com/yashthakur1/iOS-native-claudeapp)