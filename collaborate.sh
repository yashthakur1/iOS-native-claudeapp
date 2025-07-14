#!/bin/bash

# Collaboration Helper Script for GitFlow
# This script helps maintain consistent workflow

YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🤝 iOS Timer App - Collaboration Helper${NC}"
echo "======================================"

# Function to check current branch
check_branch() {
    current_branch=$(git branch --show-current)
    echo -e "${YELLOW}📍 Current branch:${NC} $current_branch"
}

# Function to update branches
update_branches() {
    echo -e "${YELLOW}🔄 Updating branches...${NC}"
    git fetch --all
    git pull origin $(git branch --show-current)
}

# Function to start new work
start_work() {
    echo -e "${BLUE}What would you like to work on?${NC}"
    echo "1) New Feature"
    echo "2) Bug Fix"
    echo "3) Hotfix (Emergency)"
    echo "4) Release Preparation"
    echo "5) Documentation Update"
    
    read -p "Enter your choice (1-5): " choice
    
    case $choice in
        1)
            read -p "Feature name (e.g., 'dark-mode'): " feature_name
            git checkout develop
            git pull origin develop
            git checkout -b "feature/$feature_name"
            echo -e "${GREEN}✅ Created feature/$feature_name branch${NC}"
            ;;
        2)
            read -p "Bug description (e.g., 'timer-overflow'): " bug_name
            git checkout develop
            git pull origin develop
            git checkout -b "bugfix/$bug_name"
            echo -e "${GREEN}✅ Created bugfix/$bug_name branch${NC}"
            ;;
        3)
            read -p "Hotfix description (e.g., 'crash-on-launch'): " hotfix_name
            git checkout main
            git pull origin main
            git checkout -b "hotfix/$hotfix_name"
            echo -e "${GREEN}✅ Created hotfix/$hotfix_name branch${NC}"
            ;;
        4)
            read -p "Release version (e.g., '1.1.0'): " version
            git checkout develop
            git pull origin develop
            git checkout -b "release/$version"
            echo -e "${GREEN}✅ Created release/$version branch${NC}"
            ;;
        5)
            git checkout develop
            git pull origin develop
            git checkout -b "docs/update-$(date +%Y%m%d)"
            echo -e "${GREEN}✅ Created documentation branch${NC}"
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
}

# Function to check status
check_status() {
    echo -e "${YELLOW}📊 Repository Status:${NC}"
    echo ""
    git status --short
    echo ""
    echo -e "${YELLOW}📝 Recent commits:${NC}"
    git log --oneline -5
}

# Function to create commit
create_commit() {
    echo -e "${BLUE}Commit Type:${NC}"
    echo "1) feat     - New feature"
    echo "2) fix      - Bug fix"
    echo "3) docs     - Documentation"
    echo "4) style    - Code style"
    echo "5) refactor - Code refactoring"
    echo "6) test     - Tests"
    echo "7) chore    - Maintenance"
    
    read -p "Select type (1-7): " commit_type
    
    case $commit_type in
        1) prefix="feat" ;;
        2) prefix="fix" ;;
        3) prefix="docs" ;;
        4) prefix="style" ;;
        5) prefix="refactor" ;;
        6) prefix="test" ;;
        7) prefix="chore" ;;
        *) prefix="chore" ;;
    esac
    
    read -p "Commit message: " message
    git add .
    git commit -m "$prefix: $message"
}

# Function to create PR
create_pr() {
    current_branch=$(git branch --show-current)
    
    if [[ $current_branch == "main" ]] || [[ $current_branch == "develop" ]]; then
        echo -e "${RED}❌ Cannot create PR from main/develop branch${NC}"
        return
    fi
    
    echo -e "${YELLOW}🔀 Creating Pull Request...${NC}"
    
    if [[ $current_branch == hotfix/* ]]; then
        base_branch="main"
    else
        base_branch="develop"
    fi
    
    gh pr create --base $base_branch --fill
}

# Function to show collaboration checklist
show_checklist() {
    echo -e "${BLUE}📋 Collaboration Checklist:${NC}"
    echo "[ ] Discussed task objectives"
    echo "[ ] Created/updated GitHub issue"
    echo "[ ] Working on correct branch"
    echo "[ ] Code follows style guide"
    echo "[ ] Tests pass locally"
    echo "[ ] Documentation updated"
    echo "[ ] Ready for code review"
}

# Main menu
while true; do
    echo ""
    echo -e "${BLUE}🚀 What would you like to do?${NC}"
    echo "1) Start new work"
    echo "2) Check status"
    echo "3) Update branches"
    echo "4) Create commit"
    echo "5) Create pull request"
    echo "6) Show checklist"
    echo "7) View current branch"
    echo "8) Switch branch"
    echo "9) Exit"
    
    read -p "Enter your choice (1-9): " main_choice
    
    case $main_choice in
        1) start_work ;;
        2) check_status ;;
        3) update_branches ;;
        4) create_commit ;;
        5) create_pr ;;
        6) show_checklist ;;
        7) check_branch ;;
        8) 
            echo "Available branches:"
            git branch -a
            read -p "Enter branch name: " branch_name
            git checkout $branch_name
            ;;
        9) 
            echo -e "${GREEN}👋 Happy coding!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice${NC}"
            ;;
    esac
done