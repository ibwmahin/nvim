-- cleaned plugins table for NvChad (replace your plugins/init.lua with this)
-- Removes LazyVim-specific references, deduplicates plugins, guards optional features,
-- and fixes events / configs so this loads cleanly in NvChad.

return {

  -- new plugins
  "nvim-lua/plenary.nvim",
  { "nvim-tree/nvim-web-devicons", lazy = true },

  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },

  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  "nvchad/volt", -- optional, needed for theme switcher
  -- or just use Telescope themes
  -- Bufferline (tabs / buffers)

  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "BufReadPre",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      pcall(function()
        require("bufferline").setup {
          options = {
            numbers = "none",
            indicator = { icon = "▎", style = "icon" },
            buffer_close_icon = "",
            modified_icon = "●",
            show_buffer_close_icons = false,
            show_close_icon = false,
            separator_style = "thin",
            always_show_bufferline = true,
          },
        }
      end)
    end,
  },

  -- Better UI for vim.ui input/select
  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
    config = function()
      pcall(function()
        require("dressing").setup()
      end)
    end,
  },

  --------------------------------------
  -- TODO / SMALL UTILITIES
  --------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
    },

    cmd = "Neotree",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer" },
      { "<leader>o", "<cmd>Neotree focus<cr>", desc = "Focus Explorer" },
    },
    config = function()
      require("neo-tree").setup {
        close_if_last_window = true,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,

        actions = {
          open_file = {
            quit_on_open = true,
          },
        },

        window = {
          position = "right",
          width = 25, -- adjust (25-32 recommended)
          mappings = {
            ["<cr>"] = "open",
            ["<tab>"] = "open",
            ["o"] = "open",
            ["l"] = "open",
            ["h"] = "close_node",
            ["<space>"] = "toggle_node",
            ["<bs>"] = "navigate_up",
            ["g?"] = "show_help",
          },
        },

        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = true,
            hide_by_name = { "node_modules", ".git" },
          },

          window = {
            mappings = {
              ["<cr>"] = "open",
              ["<tab>"] = "open",
              ["l"] = "open",
              ["h"] = "close_node",
            },
          },
        },

        default_component_configs = {
          indent = {
            with_markers = true,
            highlight = "NeoTreeIndentMarker",
            with_expanders = true,
          },
          git_status = {
            symbols = {
              added = "",
              modified = "",
              deleted = "",
              renamed = "",
              untracked = "★",
              ignored = "◌",
              unstaged = "✗",
              staged = "✓",
              conflict = "",
            },
          },
        },
      }
    end,
  },

  --------------------------------------
  -- Indent guides (ibl) — valid v3+ config (no old keys)
  --------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    event = "BufReadPost",
    opts = function()
      return {
        indent = {
          char = "│",
          tab_char = "│",
        },
        -- disable ibl's scope feature so mini.indentscope can handle animated scope
        scope = { enabled = false },
        -- exclude filetypes/buffers
        exclude = {
          filetypes = { "help", "terminal", "neo-tree", "NvimTree", "alpha", "dashboard" },
          buftypes = { "terminal", "nofile" },
        },
        whitespace = {
          highlight = { "Whitespace" },
          remove_blankline_trail = false,
        },
      }
    end,
  },

  --------------------------------------
  -- Animated indent scope (mini.indentscope) with dynamic theme-matching highlight
  --------------------------------------
  {
    "echasnovski/mini.indentscope",
    version = "*",
    event = "BufReadPost",
    config = function()
      local mis = require "mini.indentscope"

      mis.setup {
        draw = {
          delay = 5,
          animation = mis.gen_animation.cubic { easing = "out", duration = 120, unit = "step" },
        },
        symbol = "│",
        options = { try_as_border = true, shadow_blend = 10 },
      }

      -- helper: set MiniIndentScope highlight to match a colorscheme color (falls back to a default)
      local function update_mini_hl()
        local fallback = "#7AA2F7"
        local fg = nil

        -- Try to derive a color from several common highlight groups (Comment, CursorLine, Normal)
        local probes = { "Comment", "CursorLineNr", "CursorLine", "Normal" }
        for _, g in ipairs(probes) do
          local ok, tbl = pcall(vim.api.nvim_get_hl_by_name, g, true)
          if ok and type(tbl) == "table" and tbl.foreground then
            fg = string.format("#%06x", tbl.foreground)
            break
          end
        end

        if not fg then
          fg = fallback
        end

        -- apply highlights
        pcall(vim.api.nvim_set_hl, 0, "MiniIndentScope", { fg = fg, bg = "NONE", bold = false })
        pcall(vim.api.nvim_set_hl, 0, "MiniIndentScopePrefix", { fg = fg, bg = "NONE" })
        pcall(vim.api.nvim_set_hl, 0, "MiniIndentScopeSuffix", { fg = fg, bg = "NONE" })
        pcall(vim.api.nvim_set_hl, 0, "MiniIndentScopeStarting", { fg = fg, bg = "NONE", bold = true })
      end

      -- set initially
      update_mini_hl()

      -- update when colorscheme changes
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "*",
        callback = function()
          update_mini_hl()
        end,
      })
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufReadPost",
    opts = {},
    keys = {
      {
        "]t",
        function()
          require("todo-comments").jump_next()
        end,
        desc = "Next Todo Comment",
      },
      {
        "[t",
        function()
          require("todo-comments").jump_prev()
        end,
        desc = "Previous Todo Comment",
      },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>st", "<cmd>TodoTelescope<cr>", desc = "Todo (Telescope)" },
      { "<leader>sT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme (Telescope)" },
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "LazyVim", words = { "LazyVim" } },
        { path = "snacks.nvim", words = { "Snacks" } },
        { path = "lazy.nvim", words = { "LazyVim" } },
      },
    },
  },

  {
    "MagicDuck/grug-far.nvim",
    cmd = "GrugFar",
    opts = { headerMaxWidth = 80 },
    keys = {
      {
        "<leader>sr",
        function()
          local ok, grug = pcall(require, "grug-far")
          if not ok then
            vim.notify("grug-far not installed", vim.log.levels.WARN)
            return
          end
          local ext = vim.bo.buftype == "" and vim.fn.expand "%:e"
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= "" and "*." .. ext or nil,
            },
          }
        end,
        mode = { "n", "v" },
        desc = "Search and Replace",
      },
    },
  },

  --------------------------------------
  -- MINI plugins (ai, pairs, comment)
  --------------------------------------

  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require "mini.ai"
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter {
            a = { "@block.outer", "@conditional.outer", "@loop.outer" },
            i = { "@block.inner", "@conditional.inner", "@loop.inner" },
          },
          f = ai.gen_spec.treesitter { a = "@function.outer", i = "@function.inner" },
          c = ai.gen_spec.treesitter { a = "@class.outer", i = "@class.inner" },
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
          d = { "%f[%d]%d+" },
          e = {
            { "%u[%l%d]+%f[^%l%d]", "%f[%S][%l%d]+%f[^%l%d]", "%f[%P][%l%d]+%f[^%l%d]", "^[%l%d]+%f[^%l%d]" },
            "^().*()$",
          },
          u = ai.gen_spec.function_call(),
          U = ai.gen_spec.function_call { name_pattern = "[%w_]" },
        },
      }
    end,
    config = function(_, opts)
      require("mini.ai").setup(opts)

      pcall(function()
        local wk = require "which-key"
        wk.add({
          { "<leader>", group = "Leader" },
        }, { mode = "n" })
      end)
    end,
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = {
      modes = { insert = true, command = true, terminal = false },
      skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
      skip_ts = { "string" },
      skip_unbalanced = true,
      markdown = true,
    },
    config = function(_, opts)
      require("mini.pairs").setup(opts)
    end,
  },

  {
    "echasnovski/mini.comment",
    event = "VeryLazy",
    version = "*",
    config = function()
      require("mini.comment").setup()
    end,
  },

  --------------------------------------
  -- SMOOTH SCROLL
  --------------------------------------

  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    config = function()
      local ok, neoscroll = pcall(require, "neoscroll")
      if not ok then
        vim.notify("neoscroll not available", vim.log.levels.WARN)
        return
      end

      neoscroll.setup { mappings = {} }

      local keymap = {
        ["<C-u>"] = function()
          neoscroll.ctrl_u { duration = 250 }
        end,
        ["<C-d>"] = function()
          neoscroll.ctrl_d { duration = 250 }
        end,
        ["<C-b>"] = function()
          neoscroll.ctrl_b { duration = 450 }
        end,
        ["<C-f>"] = function()
          neoscroll.ctrl_f { duration = 450 }
        end,
        ["<C-y>"] = function()
          neoscroll.scroll(-0.10, { move_cursor = false, duration = 100 })
        end,
        ["<C-e>"] = function()
          neoscroll.scroll(0.10, { move_cursor = false, duration = 100 })
        end,
        ["zt"] = function()
          neoscroll.zt { half_win_duration = 250 }
        end,
        ["zz"] = function()
          neoscroll.zz { half_win_duration = 250 }
        end,
        ["zb"] = function()
          neoscroll.zb { half_win_duration = 250 }
        end,
      }

      local modes = { "n", "v", "x" }
      for key, fn in pairs(keymap) do
        vim.keymap.set(modes, key, fn, { noremap = true, silent = true })
      end
    end,
  },

  --------------------------------------
  -- React / snippets / frontend helpers
  --------------------------------------
  {
    "xabikos/vscode-react",
    ft = { "javascript", "typescript" },
  },

  --------------------------------------
  -- COMPLETION (nvim-cmp) and snippets
  --------------------------------------
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "onsails/lspkind-nvim",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local ok_cmp, cmp = pcall(require, "cmp")
      if not ok_cmp then
        return
      end
      local ok_lspkind, lspkind = pcall(require, "lspkind")
      local ok_luasnip, luasnip = pcall(require, "luasnip")
      if ok_luasnip then
        require("luasnip.loaders.from_vscode").lazy_load()
      end

      cmp.setup {
        snippet = {
          expand = function(args)
            if ok_luasnip then
              luasnip.lsp_expand(args.body)
            end
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif ok_luasnip and luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif ok_luasnip and luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<CR>"] = cmp.mapping.confirm { select = true },
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-]>"] = cmp.mapping(function()
            if vim.fn.exists "*codeium#Accept" == 1 and vim.fn["codeium#Accept"]() ~= "" then
              vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<C-r>=codeium#Accept()<CR>", true, true, true), "n")
            end
          end),
        },
        formatting = {
          format = (ok_lspkind and lspkind.cmp_format { mode = "symbol_text", maxwidth = 50, ellipsis_char = "..." })
            or nil,
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

  { "L3MON4D3/LuaSnip" },
  { "rafamadriz/friendly-snippets" },
  { "saadparwaiz1/cmp_luasnip" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "onsails/lspkind-nvim" },

  {
    "roobert/tailwindcss-colorizer-cmp.nvim",
    config = function()
      pcall(function()
        require("tailwindcss-colorizer-cmp").setup { color_square_width = 2 }
      end)
    end,
  },

  --------------------------------------
  -- LSP & FORMATTING
  --------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      pcall(function()
        require "configs.lspconfig"
      end)
    end,
  },

  { "williamboman/mason.nvim", config = true },
  { "williamboman/mason-lspconfig.nvim", config = true },
  { "jose-elias-alvarez/typescript.nvim" },

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
      pcall(function()
        require("conform").setup(require "configs.conform")
      end)
    end,
  },

  -- null-ls (guarded require so missing config file doesn't error)
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = "BufReadPre",
    config = function()
      pcall(function()
        require "configs.none-ls"
      end)
    end,
  },

  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      pcall(function()
        require("lint").linters_by_ft = {
          javascript = { "eslint" },
          typescript = { "eslint" },
        }
        vim.api.nvim_create_autocmd("BufWritePost", {
          callback = function()
            require("lint").try_lint()
          end,
        })
      end)
    end,
  },

  --------------------------------------
  -- SYNTAX & HIGHLIGHTING
  --------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      pcall(function()
        require "configs.treesitter"
      end)
    end,
  },
  { "nvim-treesitter/nvim-treesitter-context", config = true },
  { "nvim-treesitter/nvim-treesitter-textobjects" },

  {
    "windwp/nvim-ts-autotag",
    event = "InsertEnter",
    config = function()
      pcall(function()
        require("nvim-ts-autotag").setup()
      end)
    end,
  },

  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      pcall(function()
        require("nvim-highlight-colors").setup {
          render = "background",
          enable_named_colors = true,
          enable_tailwind = true,
        }
      end)
    end,
  },

  --------------------------------------
  -- UI / UX
  --------------------------------------
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
    config = function()
      pcall(function()
        require("noice").setup { lsp = { signature = { enabled = false } } }
      end)
    end,
  },

  {
    "rcarriga/nvim-notify",
    config = function()
      pcall(function()
        require("notify").setup { background_colour = "#000000", stages = "fade_in_slide_out", timeout = 1000 }
        vim.notify = require "notify"
      end)
    end,
  },

  { "folke/which-key.nvim", event = "VeryLazy", config = true },

  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.4",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      pcall(function()
        require("telescope").setup()
      end)
    end,
  },

  {
    "gen740/SmoothCursor.nvim",
    config = function()
      pcall(function()
        require("smoothcursor").setup()
      end)
    end,
  },

  -- {
  --   "goolord/alpha-nvim",
  --   event = "VimEnter",
  --   config = function()
  --     pcall(function()
  --       require("alpha").setup(require("alpha.themes.dashboard").config)
  --     end)
  --   end,
  -- },

  { "folke/tokyonight.nvim", lazy = true },
  { "catppuccin/nvim", name = "catppuccin", lazy = true },

  --------------------------------------
  -- GIT & DEVTOOLS
  --------------------------------------
  { "lewis6991/gitsigns.nvim", event = "BufReadPre", config = true },
  { "tpope/vim-fugitive", cmd = "G" },
  {
    "vuki656/package-info.nvim",
    ft = "json",
    dependencies = "MunifTanjim/nui.nvim",
    config = function()
      pcall(function()
        require("package-info").setup()
      end)
    end,
  },

  --------------------------------------
  -- MISC UTILS
  --------------------------------------
  { "echasnovski/mini.icons", event = "VeryLazy" },
  { "folke/persistence.nvim", event = "BufReadPre", config = true },
  { "JoosepAlviste/nvim-ts-context-commentstring", lazy = true },

  {
    "j-hui/fidget.nvim",
    tag = "legacy",
    event = "VeryLazy",
    config = function()
      pcall(function()
        require("fidget").setup {}
      end)
    end,
  },
}
