return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    event = "UIEnter",
    config = function()
      require("codecompanion").setup({
        display = {
          chat = {
            window = {
              number = true,
              numberwidth = 3,
              relativenumber = true,
              linebreak = true,
              breakindent = true
            }
          }
        },
        strategies = {
          chat = {
            adapter = "ollama",
            keymaps = {
              stop = {
                modes = { n = "<C-c>", i = "<C-c>" }
              },
              close = {
                modes = { n = "q" }
              }
            },
            slash_commands = {
              ["file"] = {
                callback = "strategies.chat.slash_commands.file",
                description = "Select a file using Telescope",
                opts = {
                  provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
                  contains_code = true,
                },
              },
            },
          },
          inline = {
            adapter = "ollama",
          },
        },
        adapters = {
          ollama = function()
            return require("codecompanion.adapters").extend("openai_compatible", {
              env = {
                url = "http://localhost:1234",     -- optional: default value is ollama url http://127.0.0.1:11434
                api_key = "OpenAI_API_KEY",        -- optional: if your endpoint is authenticated
                chat_url = "/v1/chat/completions", -- optional: default value, override if different
              },
            })
          end,
        },
      })
    end
  },
}
