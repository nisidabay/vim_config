# Ultimate Vim Configuration

This repository contains a personal Vim configuration for polyglot development. Vim is the backup editor — Neovim is the daily driver. Vim's keybindings are aligned to match Neovim's where possible.

## 🚀 Key Features

- **Language Server Protocol (LSP):** Full `coc.nvim` integration.
- **AI Assisted:** `codeium.vim` for ghost-text AI completion.
- **Git-aware:** `vim-signify` for inline `+`/`-`/`~` gutter signs.
- **Smart Execution:** `<leader>r<letter>` per-language run commands.
- **Telescope-style search:** `<leader>s*` prefix for all FZF pickers.
- **clang-format:** Linux kernel (Torvalds) C style via `.clang-format`.
- **Idempotent Setup:** `setup_vim.sh` symlinks everything into place.

## 🛠️ Plugins (vim-plug)

- **UI:** `tokyonight-vim`, `lightline.vim`, `vim-startify`, `vim-devicons`
- **Navigation:** `nerdtree`, `fzf` + `fzf.vim`, `tagbar`
- **LSP:** `coc.nvim`, `coc-snippets`, `vim-snippets`
- **AI:** `codeium.vim`
- **Git:** `vim-fugitive`, `vim-signify`
- **Editing:** `vim-commentary`, `vim-surround`, `vim-repeat`, `delimitMate`
- **Notes:** `vimwiki`, `vim-table-mode`, `calendar-vim`
- **Languages:** `rust.vim`, `nim.vim`

## ⚙️ Installation

```bash
git clone https://github.com/nisidabay/vim_config.git
cd vim_config
./setup_vim.sh
```

Then inside Vim:
```vim
:PlugInstall
:CocInstall coc-pyright coc-sh coc-json coc-markdownlint
```

## ⌨️ Key Mappings

`<leader>` is mapped to `<Space>`.

### Search (Telescope-style `<leader>s*`)
| Key | Action |
|-----|--------|
| `<leader>sf` | Find files (FZF) |
| `<leader>sb` | Find buffers (FZF) |
| `<leader>sg` | Ripgrep (FZF) |
| `<leader>so` | Command history (FZF) |
| `<leader>sk` / `<leader>fM` | Show all mappings (FZF) |
| `<leader>sm` | Marks (FZF) |
| `<leader>st` | Tags (FZF) |
| `<leader>sT` | Buffer tags (FZF) |
| `<leader>sG` | Git files (FZF) |
| `<leader>sK` | Man pages (FZF) |

### LSP (coc.nvim)
| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Go to references |
| `K` | Show documentation |
| `gD` | Go to declaration |
| `<Space>D` | Type definition |
| `<leader>f` | Format buffer |
| `gp` / `gP` | Previous / next diagnostic |
| `<leader>rn` | Rename symbol |

### Run per Language
| Key | Language |
|-----|----------|
| `<leader>rp` | Python |
| `<leader>rc` | Ruby |
| `<leader>rr` | Rust |
| `<leader>rl` | Lua |
| `<leader>rz` | Zig |
| `<leader>rN` | Nim |
| `<leader>rB` | Bash |
| `<leader>cc` | Compile C |
| `<leader>cv` | Compile C + Valgrind |
| `<leader>on` | Nim release build |

### Format per Language
| Key | Action |
|-----|--------|
| `<leader>pf` | autopep8 (Python) |
| `<leader>is` | isort (Python) |
| `<leader>bf` | shfmt (Bash) |
| `<leader>fg` | gofmt (Go) |
| `<leader>lf` | stylua (Lua) |
| `<leader>rf` | rubocop (Ruby) |

### General
| Key | Action |
|-----|--------|
| `jk` / `kj` | Exit insert mode |
| `<leader>nh` | Clear search highlights |
| `<leader>x` | Make file executable |
| `<leader>t` | Open terminal |
| `<leader>dd` | Delete to black hole register |
| `<leader>dG` | Delete to end (black hole) |
| `<leader>nt` | Toggle NERDTree |
| `<leader>ut` | Toggle undotree |
| `nr` | Toggle relative numbers |
| `ls` / `le` | Toggle Spanish / English spell check |
| `<C-v>` | Paste from system clipboard |

### Vimwiki
| Key | Action |
|-----|--------|
| `<leader>ww` | Open wiki index |
| `<leader>di` | Diary index |
| `<leader>kal` | Calendar |
| `<leader>rR` | Rename file |

## 📁 Configuration Structure

- **`settings.vim`**: Core mechanics, clipboard, rendering.
- **`mappings.vim`**: All keyboard shortcuts (312 lines).
- **`plugins.vim`**: Plugin declarations, FZF mappings, Startify.
- **`coc-config.vim`**: LSP autocompletion, navigation, code actions.
- **`coc-settings.json`**: Language server binaries and format-on-save.
- **`local_plugins/c.vim`**: C-specific settings (Linux kernel style).
- **`.clang-format`**: Torvalds C style (8-char tabs, 100 cols).
