# Vim Configuration

This repository contains a personal Vim configuration, managed through a
structured set of files and a setup script for easy installation.

## Features

-   **Structured Configuration:** Settings, mappings, and plugins are separated
    into different files for clarity and maintainability.
-   **Plugin Management:** Uses both `vim-plug` and `Vundle` for managing Vim
    plugins.
-   **Language Server Protocol (LSP):** Integrates `coc.nvim` for enhanced
    autocompletion, linting, and formatting.
-   **Custom Local Plugins:** Includes a set of local plugins for colorizing,
    snippets, and C filetype settings.
-   **Automated Setup:** A setup script (`setup_vim.sh`) automates the process
    of backing up existing configurations, creating necessary symlinks, and
    installing dependencies.

## Requirements

-   **Vim:** A working Vim installation is required. The setup script will
    detect existing installations.
-   **Git:** Required for cloning the repository and for `vim-plug`/`Vundle`.
-   **Node.js:** Required for `coc.nvim`. The setup script will attempt to
    install it if it's not found.
-   **curl:** Required for downloading `vim-plug` and Node.js.

## Installation

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/nisidabay/vim_config.git
    cd vim_config
    ```

2.  **Run the setup script:**
    The script will back up your existing Vim configuration (`~/.vim`,
    `~/.vimrc`) to a timestamped directory in your home folder (e.g.,
    `~/vim_backup_YYYYMMDD_HHMMSS`).

    ```bash
    ./setup_vim.sh
    ```

3.  **Install Plugins:**
    Open Vim and run the following commands to install the plugins defined in
    `plugins.vim`:
    ```vim
    :PlugInstall
    :PluginInstall
    ```

## Configuration Structure

The Vim configuration is organized into the following files:

-   `settings.vim`: General Vim settings.
-   `mappings.vim`: Custom key mappings.
-   `plugins.vim`: Plugin declarations for `vim-plug` and `Vundle`.
-   `coc-config.vim`: Configuration specific to `coc.nvim`.
-   `coc-settings.json`: JSON configuration for `coc.nvim` and its extensions.
-   `local_plugins/`: A directory for custom or manually-managed Vim plugins.
    -   `Colorizer.vim`: A plugin for colorizing text.
    -   `snippets.vim`: A collection of custom snippets.
    -   `c.vim`: Filetype-specific settings for C.
    -   `unicode.vim`: Utility for unicode characters.
    -   `yuyuko.vim`: Colorscheme.

## Development

The `vim_config_structure.sh` script is a one-time utility used to scaffold the
initial repository structure. It is not intended for regular use but provides
context on how the repository was initiated.
