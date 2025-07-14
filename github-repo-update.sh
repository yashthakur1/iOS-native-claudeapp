#!/bin/bash

# GitHub Repository Automation Script
# This script updates repository description and topics

echo "🚀 GitHub Repository Update Script"
echo "================================="

# Check if gh is authenticated
if ! gh auth status &> /dev/null; then
    echo "❌ Not authenticated. Please run: gh auth login --web"
    exit 1
fi

# Function to update repository
update_repo() {
    echo "📝 Updating repository description and topics..."
    
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
        echo "📊 Current repository info:"
        gh repo view --json name,description,topics,url | jq '.'
    else
        echo "❌ Failed to update repository."
        exit 1
    fi
}

# Function to create release
create_release() {
    local version=$1
    local notes=$2
    
    echo "📦 Creating release v$version..."
    gh release create "v$version" \
        --title "Release v$version" \
        --notes "$notes" \
        --generate-notes
}

# Function to sync with remote
sync_repo() {
    echo "🔄 Syncing with remote..."
    git pull origin main
    git push origin main
}

# Main menu
case "${1:-update}" in
    update)
        update_repo
        ;;
    release)
        if [ -z "$2" ]; then
            echo "Usage: $0 release <version> [notes]"
            exit 1
        fi
        create_release "$2" "${3:-Auto-generated release notes}"
        ;;
    sync)
        sync_repo
        ;;
    info)
        echo "📊 Repository information:"
        gh repo view --json name,description,topics,url,defaultBranchRef,visibility | jq '.'
        ;;
    *)
        echo "Usage: $0 {update|release|sync|info}"
        echo "  update  - Update repo description and topics"
        echo "  release - Create a new release"
        echo "  sync    - Sync with remote repository"
        echo "  info    - Show repository information"
        exit 1
        ;;
esac