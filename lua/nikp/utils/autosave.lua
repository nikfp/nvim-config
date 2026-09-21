local tracked_cache = {}

local function is_tracked(buf)
  if tracked_cache[buf] ~= nil then
    return tracked_cache[buf]
  end
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    tracked_cache[buf] = false
    return false
  end
  local dir = vim.fn.fnamemodify(name, ":h")
  vim.fn.system({ "git", "-C", dir, "ls-files", "--error-unmatch", name })
  local ok = vim.v.shell_error == 0
  tracked_cache[buf] = ok
  return ok
end

local denylist = {
  oil = true,
  NeogitStatus = true,
  NeogitCommitMessage = true,
  NeogitConsole = true,
  NeogitLogView = true,
  NeogitReflogView = true,
  NeogitRefsView = true,
  gitcommit = true,
  gitrebase = true,
  fugitive = true,
  DiffviewFiles = true,
  TelescopePrompt = true,
}

local function should_save(buf)
  if not vim.api.nvim_buf_is_valid(buf) then
    return false
  end
  if vim.fn.mode() ~= "n" then
    return false
  end
  if not vim.bo[buf].modified then
    return false
  end
  if not vim.bo[buf].modifiable or vim.bo[buf].readonly then
    return false
  end
  if vim.bo[buf].buftype ~= "" then
    return false
  end
  if denylist[vim.bo[buf].filetype] then
    return false
  end
  local name = vim.api.nvim_buf_get_name(buf)
  if name == "" then
    return false
  end
  return is_tracked(buf)
end

local group = vim.api.nvim_create_augroup("nikp-autosave", { clear = true })

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged", "FocusLost", "BufLeave", "WinLeave" }, {
  group = group,
  callback = function(args)
    if should_save(args.buf) then
      vim.cmd("silent! update")
    end
  end,
})

-- FocusLost may fire while still in Insert mode (terminal focus events);
-- retry on leaving insert so the pending change is not lost.
-- Uses a separate throwaway augroup so repeated focus losses don't
-- stack entries in nikp-autosave.
vim.api.nvim_create_autocmd("FocusLost", {
  group = group,
  callback = function(args)
    if vim.fn.mode() ~= "n" then
      vim.api.nvim_create_autocmd("InsertLeave", {
        once = true,
        buffer = args.buf,
        callback = function(inner)
          if should_save(inner.buf) then
            vim.cmd("silent! update")
          end
        end,
      })
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWipeout", "BufDelete" }, {
  group = group,
  callback = function(args)
    tracked_cache[args.buf] = nil
  end,
})
