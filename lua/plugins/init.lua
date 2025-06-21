return {
  -- mini map

  {
    "wfxr/minimap.vim",
    build = "cargo install --locked code-minimap",
    cmd = { "Minimap", "MinimapToggle", "MinimapRefresh", "MinimapClose" },
    init = function()
      vim.g.minimap_width = 10
      vim.g.minimap_auto_start = 1
      vim.g.minimap_auto_start_win_enter = 1
      vim.g.minimap_highlight_range = 1
      vim.g.minimap_git_colors = 1
    end,
  },

  vim.api.nvim_create_autocmd("BufEnter", {
    pattern = "*",
    command = "silent! Minimap",
  }),
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        plugins = {
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        window = {
          border = "rounded",
        },
        layout = {
          spacing = 6,
          align = "center",
        },
        triggers_blacklist = {
          -- prevent conflicts with native bindings
          i = { "j", "k" },
          v = { "j", "k" },
        },
      }
    end,
  },
  --noice.nvim using here
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      require("noice").setup {
        lsp = {
          hover = {
            enabled = true,
            silent = true, -- prevents focus stealing
            view = "hover", -- optional: uses normal hover popup
          },
          signature = {
            enabled = false, -- turn off function signature popups while typing
          },
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          bottom_search = true,
          command_palette = true,
          long_message_to_split = true,
          lsp_doc_border = true,
        },
      }
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
    end,
  },
  -- Plugin manager
  { "folke/lazy.nvim" },

  -- Colorschemes
  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },

  -- Dashboard, Terminal, Notifications

  {
    "folke/snacks.nvim",
    priority = 1000, -- load early for dashboard UI
    lazy = false, -- load immediately on start
    opts = {
      dashboard = { enabled = true },
      notifier = { enabled = true },
      terminal = { enabled = true },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      bigfile = { enabled = true },
      scope = { enabled = true },
    },
  },

  -- Keybinding popup
  { "folke/which-key.nvim", config = true },

  -- Fuzzy Finder + fzf
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      require("telescope").setup { extensions = { fzf = { fuzzy = true } } }
      require("telescope").load_extension "fzf"
    end,
  },

  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup(require "configs.treesitter")
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },

  -- LSP + Mason
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      require "configs.cmp"
    end,
  },

  -- Formatting
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

  -- Linting

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
        python = { "flake8" },
        lua = { "luacheck" },
        -- add more as needed
      }

      -- Run lint on save
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  -- File Explorer
  -- {
  --   "nvim-tree/nvim-tree.lua",
  --   dependencies = "nvim-tree/nvim-web-devicons",
  --   cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  --   config = function()
  --     require("nvim-tree").setup {
  --       on_attach = function(bufnr)
  --         local api = require "nvim-tree.api"
  --         local opts = { buffer = bufnr, noremap = true, silent = true }
  --         vim.keymap.set("n", "<C-h>", api.node.navigate.parent, opts)
  --         vim.keymap.set("n", "<C-l>", api.node.open.edit, opts)
  --         vim.keymap.set("n", "<C-j>", api.node.navigate.sibling.next, opts)
  --         vim.keymap.set("n", "<C-k>", api.node.navigate.sibling.prev, opts)
  --       end,
  --     }
  --   end,
  -- },

  -- Git Integration
  { "lewis6991/gitsigns.nvim", event = "BufReadPre", config = true },

  -- Search & Replace
  { "MagicDuck/grug-far.nvim", config = true },
  { "folke/flash.nvim", event = "VeryLazy", opts = {} },

  -- Diagnostics UI
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons", config = true },

  -- Statusline
  { "nvim-lualine/lualine.nvim", config = true },

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional for icons
    config = function()
      require("lualine").setup {
        options = {
          theme = "auto", -- auto picks your colorscheme
          section_separators = "", -- clean separators
          component_separators = "",
          globalstatus = true, -- one statusline for all windows (Neovim 0.7+)
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { "filename", "lsp_progress" },
          lualine_x = { "encoding", "fileformat", "filetype" },
          lualine_y = { "progress" },
          lualine_z = { "location" },
        },
      }
    end,
  },

  -- Commenting & Text Objects
  { "echasnovski/mini.comment", event = "VeryLazy", config = true },
  { "echasnovski/mini.ai", event = "VeryLazy", config = true },

  -- Smooth Cursor + Smooth Scrolling
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smoothcursor").setup {
        fancy = {
          enable = true,
          head = { cursor = "", texthl = "SmoothCursor" },
          body = {
            { cursor = "•", texthl = "SmoothCursorRed" },
            { cursor = "•", texthl = "SmoothCursorOrange" },
            { cursor = "·", texthl = "SmoothCursorYellow" },
          },
          tail = { cursor = "·", texthl = "SmoothCursorBlue" },
        },
        enable_cursor_flashing = false,
      }
    end,
  },
  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup { easing_function = "cubic" }
    end,
  },

  -- Breadcrumbs
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig", lazy = true, config = true },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
    config = true,
  },

  -- Tailwind CSS color preview
  { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },

  -- AI Autocomplete (free)
  -- {
  --   "Exafunction/codeium.vim",
  --   event = "InsertEnter",
  --   config = function()
  --     vim.g.codeium_disable_bindings = 1
  --     vim.keymap.set("i", "<C-CR>", function()
  --       return vim.fn["codeium#Accept"]()
  --     end, { expr = true })
  --   end,
  -- },
  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
      },
    },
  },
}
