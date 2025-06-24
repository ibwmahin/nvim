return {
  -- "sphamba/smear-cursor.nvim",
  -- event = "VeryLazy", -- Load on startup
  -- opts = {
  --   animation_duration = 100, -- Duration in ms for smooth animation
  --   easing_function = "easeOutQuad", -- Easing for VS Code-like fluidity
  --   cursor_shape = "ver25", -- Thin vertical bar for insert mode
  --   highlight = {
  --     fg = "#FFD700", -- Cursor color (gold, adjust to your theme)
  --   },
  --   enabled = true, -- Explicitly enable the plugin
  -- },
  {
    "sphamba/smear-cursor.nvim",
    event = "VeryLazy",
    cond = vim.g.neovide == nil,
    opts = {
      hide_target_hack = true,
      cursor_color = "none",
    },
    specs = {
      -- disable mini.animate cursor
      {
        "echasnovski/mini.animate",
        optional = true,
        opts = {
          cursor = { enable = false },
        },
      },
    },
  },
}
