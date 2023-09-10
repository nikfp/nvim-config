local function window()
  return vim.api.nvim_win_get_number(0)
end

return {
  {
    "folke/tokyonight.nvim",
    -- "savq/melange-nvim",
    dependencies = {
      "nvim-lualine/lualine.nvim",
      "kyazdani42/nvim-web-devicons",
      "xiyaowong/transparent.nvim",
    },
    lazy = false,
    priority = 1000,
    config = function()
      -- local theme = "melange"
      --
      local os_theme = vim.env.OS_THEME

      print(os_theme)
      local theme = ""
      if os_theme == "Light" then
        require("tokyonight").setup({
          transparent = true,
        })
        theme = "tokyonight-day"
      else

        require("tokyonight").setup({
          transparent = true,
        })
        theme = "tokyonight-moon"
      end
      vim.opt.termguicolors = true
      -- vim.cmd.colorscheme "melange"
      vim.cmd("colorscheme " .. theme)

      -- <<< NORD THEME >>>
      -- vim.g.nord_borders = true
      -- vim.g.nord_disable_background = true
      -- require("nord").set()

      -- <<< Transparent background in Telescope >>>
      -- vim.api.nvim_set_hl(0, "TelescopeNormal", { fg = "#c0caf5" })

      -- Make NVIM transparent
      -- require("transparent").setup()

      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end

      require("lualine").setup({
        options = {
          theme = 'auto',
        },
        sections = {
          lualine_y = {
            "progress",
            "location"
          },
          lualine_z = {
            "lualine_lsp",
          }
        },
        inactive_sections = {
          lualine_b = {
            {
              window,
              color = fg("Constant"),
            }
          },
        },
      })
    end,
  },
  {
    "utilyre/barbecue.nvim",
    event = "BufAdd",
    dependencies = {
      "SmiteshP/nvim-navic",
    },
    config = function()
      require("barbecue").setup({
        symbols = {
          separator = "",
        },
        theme = "tokyonight",
      })
    end,
  },
}
