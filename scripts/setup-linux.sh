#!/bin/bash

# Linux Developer Environment Setup Script
# Professional developer environment for Linux (Ubuntu/Debian)

set -e

echo "🚀 Starting Linux Developer Environment Setup..."
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

# Check if running on Linux
if [[ "$OSTYPE" != "linux-gnu"* ]]; then
    print_error "This script is for Linux only"
    exit 1
fi

# Update package list
print_warning "Updating package list..."
sudo apt-get update
print_status "Package list updated"

# Install essential build tools
print_warning "Installing essential build tools..."
sudo apt-get install -y build-essential curl wget git software-properties-common apt-transport-https
print_status "Build tools installed"

# Install Node.js
if ! command -v node &> /dev/null; then
    print_warning "Installing Node.js..."
    curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
    sudo apt-get install -y nodejs
    print_status "Node.js installed successfully"
else
    print_status "Node.js already installed"
fi

# Install Python
if ! command -v python3 &> /dev/null; then
    print_warning "Installing Python..."
    sudo apt-get install -y python3 python3-pip python3-venv
    print_status "Python installed successfully"
else
    print_status "Python already installed"
fi

# Install Git (if not already installed)
if ! command -v git &> /dev/null; then
    print_warning "Installing Git..."
    sudo apt-get install -y git
    print_status "Git installed successfully"
else
    print_status "Git already installed"
fi

# Install Docker
if ! command -v docker &> /dev/null; then
    print_warning "Installing Docker..."
    
    # Remove old versions
    sudo apt-get remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true
    
    # Install Docker
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    rm get-docker.sh
    
    # Add user to docker group
    sudo usermod -aG docker $USER
    
    # Install Docker Compose
    sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    
    print_status "Docker installed successfully"
    print_warning "Please log out and log back in for Docker group changes to take effect"
else
    print_status "Docker already installed"
fi

# Install Visual Studio Code
if ! command -v code &> /dev/null; then
    print_warning "Installing Visual Studio Code..."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    
    sudo apt-get update
    sudo apt-get install -y code
    print_status "VS Code installed successfully"
else
    print_status "VS Code already installed"
fi

# Install additional tools
print_warning "Installing additional tools..."
sudo apt-get install -y \
    jq \
    tree \
    htop \
    vim \
    nano \
    unzip \
    zip \
    ca-certificates \
    gnupg \
    lsb-release

print_status "Additional tools installed"

# Install PostgreSQL
print_warning "Installing PostgreSQL..."
sudo apt-get install -y postgresql postgresql-contrib
print_status "PostgreSQL installed"

# Install Redis
print_warning "Installing Redis..."
sudo apt-get install -y redis-server
print_status "Redis installed"

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
sudo npm install -g typescript eslint prettier nodemon ts-node
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
echo "Docker: $(docker --version 2>/dev/null || echo 'Not available - please log out and log back in')"
echo "Docker Compose: $(docker-compose --version 2>/dev/null || echo 'Not available')"
echo "VS Code: $(code --version | head -n 1)"
echo "PostgreSQL: $(psql --version)"
echo "Redis: $(redis-server --version)"

echo ""
echo "================================================"
print_status "Linux Developer Environment Setup Complete!"
echo "================================================"
echo ""
echo "Next steps:"
echo "  1. Log out and log back in (for Docker group changes)"
echo "  2. Restart your terminal"
echo "  3. Start Docker: 'sudo systemctl start docker'"
echo "  4. Enable Docker on startup: 'sudo systemctl enable docker'"
echo "  5. Open VS Code and install extensions"
echo ""
echo "Happy coding! 🎉"
