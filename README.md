# Ultimate Vim Configuration

This repository contains a highly tuned, deeply modularized, and performant personal Vim configuration designed for polyglot development in Bash, Ruby, C, C++, Rust, Nim, Python, Go, and Lua. 

It has been optimized for sub-millisecond lazy loading, native architectural integrations, and a zero-redundancy philosophy.

## 🚀 Key Features

- **Blazing Fast Startup:** Heavy plugins (`NERDTree`, `Tagbar`, `Undotree`, `markdown-preview`) are strictly lazy-loaded `on-demand` or `on-filetype`, keeping the initial application launch instantaneous.
- **De-spaghettified Architecture:** Configuration is cleanly separated into strictly-categorized files (`plugins.vim`, `settings.vim`, `mappings.vim`, and `coc-config.vim`).
- **Language Server Protocol (LSP):** Full `coc.nvim` integration providing VSCode-like intelligence, native async git signs (`coc-git`), and automated formatting on save.
- **AI Assisted:** Native, ghost-text AI completion integration via `codeium.vim`.
- **Smart Execution:** Context-aware compilation. You can press `<leader>r` in any supported language and Vim will automatically compile and/or execute the file natively in a subshell.
- **Idempotent Setup:** An intelligent `setup_vim.sh` script that safely symlinks configurations and preserves your installed plugins across updates.

---

## 🛠️ Included Plugins (Managed via `vim-plug`)

- **UI & Theme:** `tokyonight-vim`, `lightline.vim`, `vim-startify`, `ryanoasis/vim-devicons`
- **Navigation:** `scrooloose/nerdtree`, `junegunn/fzf`, `fzf.vim`, `majutsushi/tagbar`
- **Intelligence:** `neoclide/coc.nvim` *(LSP)*, `Exafunction/codeium.vim` *(AI)*
- **Git:** `tpope/vim-fugitive`, `coc-git` *(Async Signs)*
- **Editing:** `tpope/vim-commentary`, `tpope/vim-surround`, `Raimondi/delimitMate`
- **Markdown & Notes:** `vimwiki/vimwiki`, `iamcco/markdown-preview.nvim`
- **Language Support:** `rust.vim`, `nim.vim`, `vim-shfmt`, `c-syntax.vim`

---

## ⚙️ Installation

### 1. Prerequisites
- **Vim 8+** (with python3 support)
- **Node.js & npm** (Required for the `coc.nvim` Language Server)
- **Git**

### 2. Clone & Link
Clone this repository and run the setup script. It will safely back up your old `~/.vim` directory and symlink these files into place.
```bash
git clone https://github.com/nisidabay/vim_config.git
cd vim_config
./setup_vim.sh
```

### 3. Install Plugins
Open Vim and run the `vim-plug` installation command:
```vim
:PlugInstall
```

### 4. Install Language Servers
Finally, install your required CoC extensions. This covers Git signs, Python, Bash, JSON, and Markdown linting:
```vim
:CocInstall coc-git coc-pyright coc-sh coc-json coc-markdownlint
```
*(Note: Rust, C++, Nim, and Ruby are configured natively through system binaries in `coc-settings.json`).*

---

## ⌨️ Highlighted Mappings

- `<leader>` is mapped to `<Space>`

### Smart Execution
- `<leader>r` -> Automatically compiles/runs the current file based on its extension (C, C++, Rust, Nim, Python, Go, Ruby, Bash, Lua).

### Navigation
- `<leader>nt` -> Toggle NERDTree *(lazy loaded)*
- `<leader>ut` -> Toggle Undotree *(lazy loaded)*
- `<leader>ff` -> Find Files (FZF)
- `<leader>rg` -> Ripgrep (FZF)
- `<leader>b` -> List buffers and switch
- `gp` / `gP` -> Navigate LSP diagnostics (CoC)
- `gd` / `gr` -> Go to definition / Find references (CoC)

### Code Manipulation
- `K` -> Show documentation in a floating window (CoC)
- `<leader>rn` -> Rename symbol across project (CoC)
- `<leader>qf` -> Auto-fix current linting error (CoC)
- `gc` -> Auto-comment/uncomment selection (Commentary)

---

## 📁 Configuration Structure

- **`settings.vim`**: Core mechanics, clipboard integrations, window behaviors, and rendering rules.
- **`mappings.vim`**: Universal keyboard shortcuts, smart-run commands, FZF bindings, and Codeium hooks.
- **`plugins.vim`**: Plugin definitions, lazy-loading rules, and specific plugin configuration blocks.
- **`coc-config.vim`**: Autocompletion UI, diagnostic navigation, code actions, and floating window behaviors.
- **`coc-settings.json`**: Language server binary bindings and automated format-on-save declarations.
