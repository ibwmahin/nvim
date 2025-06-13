return {
  --markdown-preview
  {
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },

  -- javascript debuggin
  {
    "mxsdev/nvim-dap-vscode-js",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      require("dap-vscode-js").setup {
        debugger_path = vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter",
        adapters = { "pwa-node", "pwa-chrome", "pwa-msedge" },
      }
    end,
  },
  -- luabetter auto complition

  {
    "vuki656/package-info.nvim",
    dependencies = "MunifTanjim/nui.nvim",
    ft = "json",
    config = function()
      require("package-info").setup()
    end,
  },
  -- sstatu line & tabline
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup {
        options = { theme = "auto", section_separators = "", component_separators = "" },
      }
    end,
  },

  -- SmoothCursor configus gose form here
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = function()
      require("smoothcursor").setup {
        type = "default", -- You can also try "exp" or "matrix"
        fancy = {
          enable = true,
          head = { cursor = "➤", hl = "SmoothCursor" },
          body = {
            { cursor = "•", hl = "SmoothCursorRed" },
            { cursor = "•", hl = "SmoothCursorOrange" },
            { cursor = ".", hl = "SmoothCursorYellow" },
          },
          tail = { cursor = ".", hl = "SmoothCursorAqua" },
        },
      }
      -- DO NOT call .enable(), it's not needed anymore
    end,
  },

  -- Tailwind CSS Colorizer for cmp
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },

  -- Fuzzy Finder Telescope
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  -- Formatter
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- LSP and Mason
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
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
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind-nvim",
    },
    config = function()
      require "configs.cmp"
    end,
  },

  -- Auto pairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Auto tag close (nvim-ts-autotag) - configured separately below
  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      require("nvim-ts-autotag").setup {
        filetypes = {
          "html",
          "javascriptreact",
          "typescriptreact",
          "vue",
          "svelte",
          "tsx",
          "jsx",
          "xml",
          "php",
          "markdown",
        },
      }
    end,
  },

  -- Treesitter without autotag here
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "lua",
        "vim",
        "html",
        "css",
        "javascript",
        "typescript",
        "json",
      },
      highlight = {
        enable = true,
      },
      -- autotag removed here because handled by nvim-ts-autotag plugin
    },
  },

  -- Sidebar file explorer
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup {}
    end,
  },
}
