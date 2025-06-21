return {

  {
    "nvim-lualine/lualine.nvim",
    config = function()
      local function clock()
        return " " .. os.date "%I:%M:%S %p"
      end

      require("lualine").setup {
        options = {
          theme = "auto",
          section_separators = "",
          component_separators = "",
        },
        sections = {
          lualine_c = { "filename", "lsp_progress" },
          lualine_x = { clock, "encoding", "fileformat", "filetype" },
        },
      }

      -- Refresh lualine every second to update the clock
      vim.fn.timer_start(1000, function()
        require("lualine").refresh()
      end, { ["repeat"] = -1 })
    end,
  },
}
