#!/bin/bash

echo "🚀 GitHub CLI Setup Script"
echo "========================="
echo ""
echo "This script will help you set up GitHub CLI for automation."
echo ""

# Check if gh is installed
if ! command -v gh &> /dev/null; then
    echo "❌ GitHub CLI is not installed. Installing..."
    brew install gh
else
    echo "✅ GitHub CLI is already installed"
fi

# Check authentication status
if gh auth status &> /dev/null; then
    echo "✅ You are already authenticated with GitHub"
else
    echo "📋 You need to authenticate with GitHub."
    echo ""
    echo "Choose your preferred authentication method:"
    echo "1) Login with web browser (recommended)"
    echo "2) Login with authentication token"
    
    read -p "Enter your choice (1 or 2): " choice
    
    case $choice in
        1)
            echo ""
            echo "Starting web browser authentication..."
            gh auth login --web
            ;;
        2)
            echo ""
            echo "To use token authentication:"
            echo "1. Go to https://github.com/settings/tokens"
            echo "2. Click 'Generate new token (classic)'"
            echo "3. Give it a name like 'GitHub CLI'"
            echo "4. Select scopes: repo, workflow, admin:org (optional)"
            echo "5. Generate the token and copy it"
            echo ""
            read -p "Paste your token here: " token
            echo $token | gh auth login --with-token
            ;;
        *)
            echo "Invalid choice. Please run the script again."
            exit 1
            ;;
    esac
fi

echo ""
echo "🔧 Setting up useful GitHub CLI aliases..."

# Create useful aliases
gh alias set repo-info 'repo view --json name,description,topics,url'
gh alias set update-desc 'repo edit --description'
gh alias set add-topics 'repo edit --add-topic'
gh alias set pr-create 'pr create --fill'
gh alias set issue-list 'issue list --limit 10'

echo "✅ Aliases created!"
echo ""
echo "📚 Useful commands for the future:"
echo "  - Update repo description: gh repo edit --description \"Your description\""
echo "  - Add topics: gh repo edit --add-topic \"topic-name\""
echo "  - View repo info: gh repo-info"
echo "  - Create PR: gh pr-create"
echo "  - List issues: gh issue-list"
echo ""

# Test if we can access the current repo
if gh repo view &> /dev/null; then
    echo "✅ Successfully connected to your repository!"
    echo ""
    read -p "Would you like to update the repository description and topics now? (y/n): " update_now
    
    if [[ $update_now == "y" || $update_now == "Y" ]]; then
        echo ""
        echo "Updating repository description and topics..."
        
        gh repo edit \
            --description "⏱️ Bold iOS stopwatch app with lap tracking, Bungee font, random vibrant backgrounds, and motivational quotes. Built with SwiftUI." \
            --add-topic "ios" \
            --add-topic "swift" \
            --add-topic "swiftui" \
            --add-topic "stopwatch" \
            --add-topic "timer" \
            --add-topic "ios-app" \
            --add-topic "lap-timer" \
            --add-topic "bungee-font" \
            --add-topic "motivational-quotes" \
            --add-topic "xcode" \
            --add-topic "swift5" \
            --add-topic "ios17" \
            --add-topic "custom-fonts" \
            --add-topic "animation" \
            --add-topic "haptic-feedback"
        
        if [ $? -eq 0 ]; then
            echo "✅ Repository updated successfully!"
            echo ""
            echo "View your repository at: https://github.com/yashthakur1/iOS-native-claudeapp"
        else
            echo "❌ Failed to update repository. Please check your permissions."
        fi
    fi
else
    echo "⚠️  Could not access the repository. Make sure you're in the correct directory."
fi

echo ""
echo "🎉 Setup complete!"