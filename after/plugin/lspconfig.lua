local popup = require('nikp.popup')
require'neodev'.setup()
local status, nvim_lsp = pcall(require, "lspconfig")
-- Initialize LSPSaga
require("lspsaga").init_lsp_saga();
-- Mappings. See `:help vim.diagnostic.*` for documentation on any of the below functions
local keymap = vim.keymap.set

-- local run_default = function() 
--   popup.output_command(":echo 'run command not set up for this file type'")
-- end
local opts = { noremap=true, silent=true }
keymap('n', '<space>e', vim.diagnostic.open_float, opts)
keymap('n', '[d', vim.diagnostic.goto_prev, opts)
keymap('n', ']d', vim.diagnostic.goto_next, opts)
keymap('n', '<space>q', vim.diagnostic.setloclist, opts)
keymap('n', '<leader>ru', function() 
  popup.output_command(":echo 'run command not set up for this file type'")
end, {noremap = true, silent = true, desc = "Default run command"})
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  keymap('n', 'gD', vim.lsp.buf.declaration, bufopts)
  keymap('n', 'gd', vim.lsp.buf.definition, bufopts)
  -- keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", { silent = true })
  keymap('n', 'K', vim.lsp.buf.hover, bufopts)
  -- keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true })
  keymap('n', 'gi', vim.lsp.buf.implementation, bufopts)
  -- Lsp finder find the symbol definition implement reference
  -- if there is no implement it will hide
  -- when you use action in finder like open vsplit then you can
  -- use <C-t> to jump back
  keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", { silent = true })
  keymap('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
  keymap('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
  keymap('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
  keymap('n', '<space>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, bufopts)
  keymap('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
  -- keymap('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  keymap({"n","v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", { silent = true })
  keymap('n', 'gr', vim.lsp.buf.references, bufopts)
  keymap('n', '<leader>fmt', function() vim.lsp.buf.format { async = true } end, bufopts)
  -- keymap('n', '<leader>rr', vim.lsp.buf.rename, bufopts)
  keymap("n", "<leader>rr", "<cmd>Lspsaga rename<CR>", { silent = true })
end

-- Common UI settings related to LSP

-- LSP Diagnostics Options Setup 
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})

vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- LSP setup per language
-- 
-- Common flags
local lsp_flags = {
  -- This is the default in Nvim 0.7+
  debounce_text_changes = 150,
}

-- set up completion capabilities using nvim_cmp with LSP source
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
-- C and Variants
nvim_lsp.clangd.setup({
  capabilities = capabilities
}) 
-- TYPESCRIPT
nvim_lsp.tsserver.setup{
    on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        if client.server_capabilities.documentFormattingProvider then
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = vim.api.nvim_create_augroup("Format", { clear = true }),
            buffer = bufnr,
            callback = function() vim.lsp.buf.formatting_seq_sync() end
          })
        end
        keymap('n', '<leader>rr', ':lua vim.lsp.buf.rename()<cr>')
        keymap('n', '<leader>fmt', ":Neoformat prettier<cr>")
    end,
    flags = lsp_flags,
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
    capabilities = capabilities
}

--SVELTE 
require'lspconfig'.svelte.setup{
  on_attach = on_attach,
  flags = lsp_flags,
}
vim.g.vim_svelte_plugin_use_typescript = 1

-- RUST
local rt = require('rust-tools')

rt.setup({
  server = {
    capabilities = capabilities,
    on_attach = function(client, bufnr)
      -- add keymaps for the rest of things
      on_attach(client, bufnr)
      -- Hover actions
      keymap("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      keymap("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
      -- easy run code
      keymap('n', '<leader>ru', function() 
        popup.output_command(':!cargo run')
      end )
      -- easy format
      keymap('n', '<leader>fmt', ":!cargo fmt<cr><cr><cr>")
      -- add semicolon easily
      keymap('n', '<leader>;', "$a;<esc>o")

    end,
  },
})

-- GOLANG
local util = require'lspconfig/util'
require'lspconfig'.gopls.setup {
  cmd = {'gopls', 'serve'},
  filetypes = {'go', 'gomod'},
  root_dir = util.root_pattern('go.work', 'go.mod', '.git'),
  server = {
    capabilities = capabilities,
    on_attach = on_attach
  }
}

-- LUA
require'lspconfig'.sumneko_lua.setup {
  cmd = {'/home/nikp/lua/bin/lua-language-server'},
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = {'vim'},
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false
      }
    },
  },
  server = {
    capabilities = capabilities,
    on_attach = on_attach
  }
}

--Set completeopt to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true}
vim.api.nvim_set_option('updatetime', 300) 

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error 
-- Show inlay_hints more frequently 
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- vim.diagnostic.config({
--   virtual_text = {
--     prefix = '●'
--   },
--   update_in_insert = true,
--   float = {
--     source = "always", -- Or "if_many"
--   },
-- })
