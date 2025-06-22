return {

  -- Disable modern explorers
  { "stevearc/oil.nvim", enabled = false },
  { "nvim-telescope/telescope-file-browser.nvim", enabled = false },
  { "echasnovski/mini.files", enabled = false },

  -- Only nvim-tree explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup {
        view = {
          width = 30,
          side = "left",
        },
        renderer = {
          icons = {
            show = {
              folder = true,
              file = true,
            },
          },
        },
        git = {
          enable = true,
        },
      }

      -- Keymap to toggle
      vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle File Tree" })

      -- Open nvim-tree when nvim is launched with a directory
      vim.api.nvim_create_autocmd("VimEnter", {
        callback = function()
          local arg = vim.fn.argv(0)
          if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
            require("nvim-tree.api").tree.open()
          end
        end,
      })
    end,
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  },

  -- Snacks.nvim (explorer disabled)
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      dashboard = { enabled = true },
      notifier = { enabled = true },
      terminal = { enabled = true },
      explorer = { enabled = false },
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

  -- Add the rest of your plugins below:
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
          i = { "j", "k" },
          v = { "j", "k" },
        },
      }
    end,
  },

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
            silent = true,
            view = "hover",
          },
          signature = {
            enabled = false,
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

  { "folke/lazy.nvim" },

  { "folke/tokyonight.nvim", lazy = false, priority = 1000 },
  { "catppuccin/nvim", name = "catppuccin", lazy = false, priority = 1000 },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
    config = function()
      require("telescope").setup { extensions = { fzf = { fuzzy = true } } }
      require("telescope").load_extension "fzf"
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
      require("nvim-treesitter.configs").setup(require "configs.treesitter")
    end,
  },
  { "nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter" },

  {
    "williamboman/mason.nvim",
    config = true,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = true,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = true,
  },

  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
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

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      require "configs.conform"
    end,
  },

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
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
    end,
  },

  { "lewis6991/gitsigns.nvim", event = "BufReadPre", config = true },
  { "MagicDuck/grug-far.nvim", config = true },
  { "folke/flash.nvim", event = "VeryLazy", opts = {} },
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons", config = true },
  { "nvim-lualine/lualine.nvim", config = true },
  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = true,
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    config = true,
  },
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
  { "SmiteshP/nvim-navic", dependencies = "neovim/nvim-lspconfig", lazy = true, config = true },
  {
    "utilyre/barbecue.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
    config = true,
  },
  { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
  { import = "nvchad.blink.lazyspec" },

  -- Treesitter lang packs
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
