local M = {}

M.get_lsp_num = function(lsp_name)
  local clients = vim.lsp.get_active_clients({ bufnr = 0 })

  local out = {}
  local out_length = 0

  for _, v in pairs(clients) do
    if (v.name == lsp_name) then
      out[0] = v
      out_length = out_length + 1
    end
  end

  if (out_length == 0) then
    return 0
  else
    return out[0].id
  end
end

M.start_server = function(lsp_name)
  vim.cmd(":LspStart " .. lsp_name)
end

M.stop_server = function(lsp_id)
  vim.cmd(":LspStop " .. lsp_id)
end

return M
