#!/bin/bash
###############################################################################
# Setup script for Vim configuration
# This script runs inside .vim_config folder, which is a cloned repo from
# https://github.com/nisidabay/vim_config.git
###############################################################################

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Important paths
VIM_CONFIG_DIR="$HOME/vim_config"
VIM_DIR="$HOME/.vim"

# Function to log messages
log() {
    local level=$1
    shift
    case "$level" in
    "error") echo -e "${RED}ERROR: $*${NC}" ;;
    "success") echo -e "${GREEN}SUCCESS: $*${NC}" ;;
    "warning") echo -e "${YELLOW}WARNING: $*${NC}" ;;
    *) echo -e "$*" ;;
    esac
}

# Function to verify working directory
verify_working_directory() {
    if [ ! "$PWD" = "$VIM_CONFIG_DIR" ]; then
        log "error" "Script must be run from $VIM_CONFIG_DIR"
        log "error" "Current directory is $PWD"
        exit 1
    fi
}

# Function to check Vim installation
check_vim_installation() {
    log "info" "Checking current Vim installation..."

    # Initialize variables
    local vim_paths=()
    local vim_version=""
    local has_system_vim=false

    # Find all vim binaries
    while IFS= read -r vim_path; do
        vim_paths+=("$vim_path")
        if [ "$vim_path" = "/usr/bin/vim" ]; then
            has_system_vim=true
        fi
    done < <(which -a vim 2>/dev/null)

    if [ ${#vim_paths[@]} -eq 0 ]; then
        log "info" "No existing Vim installation found. Ready to proceed with installation."
        return 0
    fi

    # Show found Vim installations
    log "warning" "Found existing Vim installation(s):"
    for vim_path in "${vim_paths[@]}"; do
        vim_version=$("$vim_path" --version | head -n 1)
        log "warning" "  - $vim_path ($vim_version)"
    done

    if [ "$has_system_vim" = true ]; then
        log "warning" "Found system Vim installation at /usr/bin/vim"
        log "warning" "It's recommended to install Vim via your package manager for full feature support"
        log "warning" "If this is a MacOs and you have already uninstall Vim with brew, it's the default MacOs Vim installation. Brew will override it"
        echo
        read -p "Do you want to proceed with system Vim? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            log "error" "Please install Vim via your package manager and run this script again."
            exit 1
        fi
        log "warning" "Proceeding with system Vim - some features may be limited"
    fi
}

# Configuration files to be symlinked
CONFIG_FILES=(
    "settings.vim"
    "mappings.vim"
    "plugins.vim"
    "coc-config.vim"
    "coc-settings.json"
)

# Required files check
REQUIRED_FILES=(
    "$VIM_CONFIG_DIR/settings.vim"
    "$VIM_CONFIG_DIR/mappings.vim"
    "$VIM_CONFIG_DIR/plugins.vim"
    "$VIM_CONFIG_DIR/coc-config.vim"
    "$VIM_CONFIG_DIR/coc-settings.json"
    "$VIM_CONFIG_DIR/local_plugins/Colorizer.vim"
    "$VIM_CONFIG_DIR/local_plugins/snippets.vim"
    "$VIM_CONFIG_DIR/local_plugins/c.vim"
)

# Function to check required files
check_required_files() {
    local missing_files=0

    log "info" "Checking for required files in $VIM_CONFIG_DIR"
    for file in "${REQUIRED_FILES[@]}"; do
        if [ ! -f "$file" ]; then
            log "error" "Missing required file: $file"
            missing_files=1
        else
            log "success" "Found: $file"
        fi
    done

    if [ $missing_files -eq 1 ]; then
        log "error" "Some required files are missing. Please check your repository."
        exit 1
    fi
}

# Function to backup existing config
backup_existing_config() {
    if [ -d "$VIM_DIR" ] || [ -f "$HOME/.vimrc" ]; then
        local backup_dir="$HOME/vim_backup_$(date +%Y%m%d_%H%M%S)"
        log "warning" "Existing Vim configuration found. Creating backup at $backup_dir"
        mkdir -p "$backup_dir/.vim" # Create .vim subdirectory in backup

        # Backup main vim directory if it exists
        if [ -d "$VIM_DIR" ]; then
            cp -r "$VIM_DIR" "$backup_dir/" 2>/dev/null || true
        fi

        # Backup individual files
        [ -f "$HOME/.vimrc" ] && cp "$HOME/.vimrc" "$backup_dir/" 2>/dev/null || true
        [ -f "$HOME/.viminfo" ] && cp "$HOME/.viminfo" "$backup_dir/" 2>/dev/null || true

        # Specifically handle coc-settings.json
        if [ -f "$VIM_DIR/coc-settings.json" ]; then
            cp "$VIM_DIR/coc-settings.json" "$backup_dir/.vim/" 2>/dev/null || true
        fi
    fi
}

# Function to create symlinks
create_symlinks() {
    log "info" "Creating symlinks for configuration files..."

    # Ensure .vim directory exists
    mkdir -p "$VIM_DIR"

    for file in "${CONFIG_FILES[@]}"; do
        local source_file="$VIM_CONFIG_DIR/$file"
        local target_file="$VIM_DIR/$file"

        # Remove existing file/symlink if it exists
        if [ -e "$target_file" ] || [ -L "$target_file" ]; then
            rm "$target_file"
        fi

        # Create symlink
        ln -s "$source_file" "$target_file"
        if [ $? -eq 0 ]; then
            log "success" "Created symlink: $target_file -> $source_file"
        else
            log "error" "Failed to create symlink for $file"
            exit 1
        fi
    done

    # Ensure coc-settings.json exists
    if [ ! -f "$VIM_DIR/coc-settings.json" ]; then
        cp "$VIM_CONFIG_DIR/coc-settings.json" "$VIM_DIR/" || {
            log "error" "Failed to copy coc-settings.json"
            exit 1
        }
    fi
}

# Function to install local plugin files
install_local_plugin() {
    local plugin_file="$1" # Source file
    local target_dir="$2"  # Target directory

    if [ ! -d "$target_dir" ]; then
        mkdir -p "$target_dir"
    fi

    if [ -f "$plugin_file" ]; then
        log "success" "Installing local plugin: $(basename "$plugin_file")"
        cp "$plugin_file" "$target_dir/" || {
            log "error" "Failed to copy $(basename "$plugin_file") to $target_dir"
            exit 1
        }
    else
        log "error" "Plugin file not found: $plugin_file"
        exit 1
    fi
}

# Main installation process
main() {
    log "info" "Starting Vim configuration setup..."

    # Verify working directory first
    verify_working_directory

    # Then check Vim installation
    check_vim_installation

    # Check required files
    check_required_files

    # Backup existing configuration
    backup_existing_config

    # Remove existing vim configurations
    log "info" "Removing existing Vim configuration..."
    rm -rf "$VIM_DIR" "$HOME/.vimrc" "$HOME/.viminfo"

    # Create initial Vim configuration
    log "info" "Creating initial Vim configuration..."
    vim -E -s -c ":quit"

    # Check Node.js installation
    if ! command -v node &>/dev/null; then
        log "warning" "Node.js not found. Installing..."
        curl -sL install-node.vercel.app/lts | bash
        if ! command -v node &>/dev/null; then
            log "error" "Failed to install Node.js"
            exit 1
        fi
    fi

    # Install vim-plug
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

    # Create symlinks for configuration files
    create_symlinks

    # Create .vimrc
    log "info" "Creating .vimrc..."
    cat >"$HOME/.vimrc" <<'EOL' || exit 1
source ~/.vim/settings.vim
source ~/.vim/mappings.vim
source ~/.vim/plugins.vim
source ~/.vim/coc-config.vim
EOL

    # Install local plugins using absolute paths
    log "info" "Installing local plugins..."
    install_local_plugin "$VIM_CONFIG_DIR/local_plugins/Colorizer.vim" "$VIM_DIR/plugin"
    install_local_plugin "$VIM_CONFIG_DIR/local_plugins/snippets.vim" "$VIM_DIR/plugin"
    install_local_plugin "$VIM_CONFIG_DIR/local_plugins/c.vim" "$VIM_DIR/ftplugin"

    log "success" "Setup complete!"
    log "info" "You can now start Vim and run :PlugInstall, :PluginInstall to install plugins"
}

# Run the script
main
