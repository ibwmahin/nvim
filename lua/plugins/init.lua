return {
  -- new plugins setup gose form here

  {
    "karb94/neoscroll.nvim",
    event = "WinScrolled",
    config = function()
      require("neoscroll").setup {
        -- All defaults, see docs for options
        easing_function = "cubic",
      }
    end,
  },
  -- better popup error for the neovim like webstrom

  {
    "rcarriga/nvim-notify",
    lazy = true,
    opts = {
      stages = "fade_in_slide_out",
      timeout = 2000,
      background_colour = "#1e1e2e",
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require "notify"
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

  -- indent code
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = {
      indent = { char = "│" },
      scope = { enabled = true },
      exclude = {
        filetypes = { "help", "dashboard", "lazy", "NvimTree" },
        buftypes = { "terminal" },
      },
    },
  },
   -- new plugins setup ends here

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
        type = "default", -- try "exp" or "matrix" if you want
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
        -- optionally, you can add:
        disabled_filetypes = { "NvimTree", "TelescopePrompt" },
      }
      -- DO NOT call require("smoothcursor").enable() here
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
