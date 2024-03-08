local function window()
  return vim.api.nvim_win_get_number(0)
end

return {
  {
    "folke/tokyonight.nvim",
    dependencies = {
      "nvim-lualine/lualine.nvim",
      "kyazdani42/nvim-web-devicons",
      "xiyaowong/transparent.nvim",
    },
    lazy = false,
    priority = 1000,
    config = function()
      local os_theme = vim.env.OS_THEME

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
      vim.cmd("colorscheme " .. theme)

      local function fg(name)
        return function()
          ---@type {foreground?:number}?
          local hl = vim.api.nvim_get_hl_by_name(name, true)
          return hl and hl.foreground and { fg = string.format("#%06x", hl.foreground) }
        end
      end
      vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
      vim.api.nvim_set_hl(0, "DiagnosticUnnecessary", { fg = "NONE", bg = "NONE", underline = true })

      local lualine_lsp = function()
        local buf_clients = vim.lsp.get_clients({ bufnr = 0 })
        local buf_client_names = {}

        for _, client in pairs(buf_clients) do
          table.insert(buf_client_names, client.name)
        end

        local base = table.concat(buf_client_names, ",")
        return base
      end

      require("lualine").setup({
        options = {
          theme = 'auto',
        },
        sections = {
          lualine_c = {
            -- function()
            --   return vim.fn.expand("%:.")
            -- end
          },
          lualine_y = {
            "location"
          },
          lualine_z = {
            lualine_lsp,
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
        show_dirname = false,
        symbols = {
          separator = "",
        },
        theme = "tokyonight",
      })
    end,
  },
  {
    "b0o/incline.nvim",
    event = "UIEnter",
    config = function()
      local helpers = require 'incline.helpers'
      local devicons = require 'nvim-web-devicons'
      require('incline').setup {
        window = {
          padding = 0,
          margin = { horizontal = 0 },
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':.')
          if filename == '' then
            filename = '[No Name]'
          end
          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { ' ', ft_icon, ' ', guibg = ft_color, guifg = helpers.contrast_color(ft_color) } or '',
            ' ',
            { filename, gui = modified and 'bold,italic' or 'bold' },
            ' ',
            guibg = '#44406e',
          }
        end,
      }
    end
  }
}
