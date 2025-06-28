return {

  -- Git Integration
  { "lewis6991/gitsigns.nvim", event = "BufReadPre", config = true },

  -- Search & Replace
  { "MagicDuck/grug-far.nvim", config = true },
  { "folke/flash.nvim", event = "VeryLazy", opts = {} },

  -- Diagnostics UI
  { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons", config = true },

  --linting gose from here
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        javascript = { "eslint" },
        typescript = { "eslint" },
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

  -- which key nvim  gose from here
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

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    config = function()
      require("mini.comment").setup {
        options = {
          custom_commentstring = function()
            return require("ts_context_commentstring.internal").calculate_commentstring() or vim.bo.commentstring
          end,
        },
      }
    end,
  },
  -- { "echasnovski/mini.comment", event = "VeryLazy", config = true },
  { "echasnovski/mini.ai", event = "VeryLazy", config = true },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

  -- Autocompletion

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
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
      local cmp = require "cmp"
      local luasnip = require "luasnip"
      local lspkind = require "lspkind"

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<Tab>"] = cmp.mapping.confirm { select = true },
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
        },
        formatting = {
          format = lspkind.cmp_format {
            mode = "symbol_text",
            maxwidth = 50,
            ellipsis_char = "...",
          },
        },
        sources = cmp.config.sources {
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
      }
    end,
  },
  -- Dashboard, Terminal, Notifications

  {
    "folke/snacks.nvim",
    priority = 1000, -- load early for dashboard UI
    lazy = false, -- load immediately on start
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

  -- navic is for the breadcumbs
  {
    "SmiteshP/nvim-navic",
    lazy = true,
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("nvim-navic").setup {
        highlight = true,
        separator = " > ",
        depth_limit = 5,
        -- theme = auto,
        depth_limit_indicator = "..",
      }
    end,
  },
  -- utilyre/barbecue.nvim pluting adding here

  {
    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
      "neovim/nvim-lspconfig",
      "SmiteshP/nvim-navic", -- Context provider
      "nvim-tree/nvim-web-devicons", -- Optional icon support
    },
    event = "VeryLazy",
    config = function()
      require("barbecue").setup {
        attach_navic = true,
      }
    end,
  },
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
      timeout = 1000,
      background_colour = "#1e1e2e",
    },
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require "notify"
    end,
  },
  --noice nvim lua file gose form here
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
  -- notification
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require "notify"
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
      -- Define a single yellow shade for the cursor
      vim.api.nvim_set_hl(0, "SmoothCursorYellow", { fg = "#FFD700" }) -- Golden yellow

      require("smoothcursor").setup {
        cursor = "", -- Keep the cool arrow shape as default cursor
        texthl = "SmoothCursorYellow",
        fancy = {
          enable = true,
          head = { cursor = "▐", texthl = "SmoothCursorYellow" },
          body = {
            { cursor = "▆", texthl = "SmoothCursorYellow" },
            { cursor = "▇", texthl = "SmoothCursorYellow" },
            { cursor = "▉", texthl = "SmoothCursorYellow" },
            { cursor = "▊", texthl = "SmoothCursorYellow" },
            { cursor = "▌", texthl = "SmoothCursorYellow" },
          },
          tail = { cursor = "·", texthl = "SmoothCursorYellow" },
        },
        interval = 50,
        timeout = 800,
        priority = 10,
        enable_cursor_animation = true,
        enable_cursor_flashing = false, -- disable flash, keep smooth only
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
  -- Tailwind CSS Colorizer for cmp
  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      require("tailwindcss-colorizer-cmp").setup {
        color_square_width = 2,
      }
    end,
  },
  { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
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
      -- ADD THIS:

      context_commentstring = {
        enable = true,
        enable_autocmd = false,
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
