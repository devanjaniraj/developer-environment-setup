#!/bin/bash

# macOS Developer Environment Setup Script
# Professional developer environment for macOS

set -e

echo "🚀 Starting macOS Developer Environment Setup..."
echo "================================================"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

# Check if running on macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script is for macOS only"
    exit 1
fi

# Install Homebrew if not installed
if ! command -v brew &> /dev/null; then
    print_warning "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
    
    print_status "Homebrew installed successfully"
else
    print_status "Homebrew already installed"
    brew update
fi

# Install Git
if ! command -v git &> /dev/null; then
    print_warning "Installing Git..."
    brew install git
    print_status "Git installed successfully"
else
    print_status "Git already installed"
fi

# Install Node.js and npm
if ! command -v node &> /dev/null; then
    print_warning "Installing Node.js..."
    brew install node@20
    brew link node@20
    print_status "Node.js installed successfully"
else
    print_status "Node.js already installed"
fi

# Install Python
if ! command -v python3 &> /dev/null; then
    print_warning "Installing Python..."
    brew install python@3.11
    print_status "Python installed successfully"
else
    print_status "Python already installed"
fi

# Install Docker Desktop
if ! command -v docker &> /dev/null; then
    print_warning "Installing Docker Desktop..."
    brew install --cask docker
    print_status "Docker Desktop installed. Please start Docker Desktop manually."
else
    print_status "Docker already installed"
fi

# Install Visual Studio Code
if ! command -v code &> /dev/null; then
    print_warning "Installing Visual Studio Code..."
    brew install --cask visual-studio-code
    print_status "VS Code installed successfully"
else
    print_status "VS Code already installed"
fi

# Install additional tools
print_warning "Installing additional tools..."
brew install wget curl jq tree htop

# Install useful CLI tools
brew install gh  # GitHub CLI
brew install postgresql@15
brew install mongodb-community
brew install redis

print_status "Additional tools installed"

# Configure Git
print_warning "Configuring Git..."
read -p "Enter your name for Git: " git_name
read -p "Enter your email for Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"
git config --global init.defaultBranch main
git config --global core.editor "code --wait"

print_status "Git configured successfully"

# Install global npm packages
print_warning "Installing global npm packages..."
npm install -g typescript eslint prettier nodemon ts-node
print_status "Global npm packages installed"

# Install Python packages
print_warning "Installing Python packages..."
pip3 install --upgrade pip
pip3 install virtualenv pipenv black pylint pytest
print_status "Python packages installed"

# Create development directories
print_warning "Creating development directories..."
mkdir -p ~/Projects
mkdir -p ~/Projects/Personal
mkdir -p ~/Projects/Work
mkdir -p ~/Projects/Learning
print_status "Development directories created"

# Verify installations
echo ""
echo "================================================"
echo "📊 Verifying Installations..."
echo "================================================"

echo "Node.js: $(node --version)"
echo "npm: $(npm --version)"
echo "Python: $(python3 --version)"
echo "Git: $(git --version)"
echo "Docker: $(docker --version 2>/dev/null || echo 'Not running - please start Docker Desktop')"
echo "VS Code: $(code --version | head -n 1)"

echo ""
echo "================================================"
print_status "macOS Developer Environment Setup Complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo "  1. Start Docker Desktop from Applications"
echo "  2. Restart your terminal"
echo "  3. Run 'brew doctor' to check for any issues"
echo "  4. Open VS Code and install extensions"
echo ""
echo "Happy coding! 🎉"
