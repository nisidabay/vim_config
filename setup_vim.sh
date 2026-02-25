#!/usr/bin/env bash
###############################################################################
# Setup script for Vim configuration (Refactored)
# This script runs inside the vim_config folder, which is a cloned repo from
# https://github.com/nisidabay/vim_config.git
###############################################################################

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Config paths
VIM_CONFIG_DIR="$HOME/vim_config"
VIM_DIR="$HOME/.vim"

# --- Helper Functions --------------------------------------------------------

log() {
    local level=$1
    shift
    case "$level" in
    "error") echo -e "${RED}ERROR: $*${NC}" >&2 ;;
    "success") echo -e "${GREEN}SUCCESS: $*${NC}" ;;
    "warning") echo -e "${YELLOW}WARNING: $*${NC}" ;;
    *) echo -e "$*" ;;
    esac
}

verify_working_directory() {
    if [ "$PWD" != "$VIM_CONFIG_DIR" ]; then
        log "error" "Script must be run from $VIM_CONFIG_DIR"
        log "error" "Current directory is $PWD"
        exit 1
    fi
    log "success" "Running in correct directory: $VIM_CONFIG_DIR"
}

check_dependencies() {
    log "info" "Checking dependencies..."
    if ! command -v vim &>/dev/null; then
        log "error" "Vim is not installed. Please install it with 'sudo pacman -S vim' and run this script again."
        exit 1
    fi
    if ! command -v node &>/dev/null; then
        log "error" "Node.js is not installed. It is required for CoC. Please install it with 'sudo pacman -S nodejs npm' and run this script again."
        exit 1
    fi
    if ! command -v git &>/dev/null; then
        log "error" "Git is not installed. It is required for installing plugins. Please install it with 'sudo pacman -S git'."
        exit 1
    fi
    log "success" "All dependencies (vim, node, git) are installed."
}

# --- Main Functions ----------------------------------------------------------

# Configuration and local files to be handled by the script
CONFIG_FILES=(
    "settings.vim"
    "mappings.vim"
    "plugins.vim"
    "coc-config.vim"
    "coc-settings.json"
)
LOCAL_FILES=(
    "local_plugins/snippets.vim"
    "local_plugins/c.vim"
)

check_required_repo_files() {
    log "info" "Checking for required files in repository..."
    local all_files_found=true
    for file in "${CONFIG_FILES[@]}" "${LOCAL_FILES[@]}"; do
        if [ ! -f "$VIM_CONFIG_DIR/$file" ]; then
            log "error" "Missing required file in repo: $file"
            all_files_found=false
        fi
    done

    if [ "$all_files_found" = false ]; then
        log "error" "Some required files are missing. Please check your repository."
        exit 1
    fi
    log "success" "All required repository files found."
}

backup_existing_config() {
    # Check if it's already our config, skip backup if true to preserve plugins
    if [ -L "$VIM_DIR/settings.vim" ] && [ "$(readlink "$VIM_DIR/settings.vim")" = "$VIM_CONFIG_DIR/settings.vim" ]; then
        log "info" "Vim configuration already belongs to $VIM_CONFIG_DIR. Skipping backup phase."
        return
    fi

    if [ -d "$VIM_DIR" ] || [ -f "$HOME/.vimrc" ]; then
        local backup_dir="$HOME/vim_backup_$(date +%Y%m%d_%H%M%S)"
        log "warning" "Existing Vim configuration found. Backing it up to $backup_dir"
        mkdir -p "$backup_dir"
        mv "$VIM_DIR" "$backup_dir/" 2>/dev/null || true
        mv "$HOME/.vimrc" "$backup_dir/" 2>/dev/null || true
        mv "$HOME/.viminfo" "$backup_dir/" 2>/dev/null || true
        log "success" "Backup complete."
    fi
}

create_vim_structure() {
    log "info" "Creating/verifying ~/.vim directory structure..."

    # Create all standard directories without deleting existing plugins
    mkdir -p "$VIM_DIR/autoload" \
        "$VIM_DIR/plugin" \
        "$VIM_DIR/ftplugin" \
        "$VIM_DIR/syntax" \
        "$VIM_DIR/indent" \
        "$VIM_DIR/sessions" \
        "$VIM_DIR/undodir"
    log "success" "Verified standard Vim directories."
}

install_vim_plug() {
    log "info" "Installing vim-plug..."
    curl -fLo "$VIM_DIR/autoload/plug.vim" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    log "success" "vim-plug installed."
}

link_and_copy_files() {
    log "info" "Linking configuration files..."
    for file in "${CONFIG_FILES[@]}"; do
        ln -sf "$VIM_CONFIG_DIR/$file" "$VIM_DIR/$file"
        log "success" "Linked $VIM_DIR/$file"
    done

    log "info" "Copying local files..."
    cp "$VIM_CONFIG_DIR/local_plugins/snippets.vim" "$VIM_DIR/plugin/"
    cp "$VIM_CONFIG_DIR/local_plugins/c.vim" "$VIM_DIR/ftplugin/"
    log "success" "Copied local files."
}

create_vimrc() {
    log "info" "Creating ~/.vimrc..."
    cat >"$HOME/.vimrc" <<'EOL'
" This file is managed by setup_vim.sh
" It sources the configuration files from ~/.vim/
source ~/.vim/settings.vim
source ~/.vim/mappings.vim
source ~/.vim/plugins.vim
source ~/.vim/coc-config.vim
EOL
    log "success" "Created ~/.vimrc."
}

# --- Main Execution ----------------------------------------------------------

main() {
    log "info" "Starting Vim configuration setup..."

    verify_working_directory
    check_dependencies
    check_required_repo_files
    backup_existing_config
    create_vim_structure
    install_vim_plug
    link_and_copy_files
    create_vimrc

    log "success" "Setup complete!"
    log "info" "Start Vim and run :PlugInstall to install all plugins."
    log "info" "Afterward, run :CocInstall coc-pyright coc-sh coc-json coc-markdownlint"
}

main
