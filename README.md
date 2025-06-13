
# My Custom NvChad Neovim Setup

> A sleek, fast, and minimal Neovim configuration based on NvChad, tailored for full-stack development with smooth UI and productivity-enhancing plugins.

---

## Features

- Based on [NvChad](https://nvchad.com/docs/quickstart/install) — powerful, modular, and easy to customize
- Auto-completion and snippets powered by `nvim-cmp` and `LuaSnip`
- Smooth scrolling and animated cursor effects for a modern editing experience
- Beautiful and informative statusline (without `feline.nvim`)
- File explorer with `NvimTree`
- Telescope fuzzy finder for quick file and text search
- Syntax highlighting and code parsing with `nvim-treesitter`
- Enhanced LSP integration with Mason and `nvim-lspconfig`
- User-friendly key mappings for resizing splits, toggling file tree, and more
- Clean, minimal, and distraction-free UI

---

## Installation

### Prerequisites

- Neovim (v11 or later recommended)
- Git installed

### Setup

1. Clone NvChad as your base config if you haven't already:

```bash
git clone https://github.com/NvChad/NvChad ~/.config/nvim --depth 1


2. Remove the existing feline.nvim plugin if present (already done in this setup)
3. Copy or clone this custom configuration on top of NvChad’s config directory:

# Assuming you have this config in a repo or zipped file
# Copy the contents to ~/.config/nvim/lua/custom/

4. Open Neovim and run:
    :PackerSync
or if using Lazy.nvim:
    :Lazy sync
5. Restart Neovim and enjoy the setup!






Key Mappings

| Shortcut           | Description                        |
| ------------------ | ---------------------------------- |
| `<C-M-h/j/k/l>`    | Resize splits (left/down/up/right) |
| `<C-n>`            | Toggle NvimTree file explorer      |
| `<leader>ff`       | Find files using Telescope         |
| `<leader>fg`       | Live grep using Telescope          |
| `jk` (insert mode) | Quick escape to normal mode        |
| `;`                | Enter command mode                 |


Plugins Included
-----------------
1.  NvChad core — The modular Neovim config framework
2.  nvim-cmp — Autocompletion engine with buffer, path, LSP sources
3.  LuaSnip — Snippet engine with friendly-snippets collection
4.  nvim-treesitter — Syntax parsing and highlighting
5.  nvim-lspconfig & Mason — LSP server management and config
6.  NvimTree — File explorer sidebar
7.  Telescope — Fuzzy finder and picker
8.  SmoothCursor.nvim — Smooth animated cursor effect
9.  Neoscroll.nvim — Smooth scrolling animations
10. nvim-notify & noice.nvim — Modern notification and command UI
11. indent-blankline.nvim — Shows indentation guides

Why This Setup?
This config strikes a balance between performance, usability, and aesthetics — ideal for developers who want a modern, distraction-free environment with powerful features without the bulk of heavy IDEs.



Contributing
Any One can use it clone it totally for free but PLEASE DON'T FORK OT TRY TO CONTRIBUTING ON THIS AS IM NOT READY FOR IT . NEVER MIND PLEASE


NOTE;
Thanks for your time ;
--------------Abdulla Al Mahin ❤️
