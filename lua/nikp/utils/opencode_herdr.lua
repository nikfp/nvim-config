-- Reports opencode.nvim-driven sessions to Herdr so the SwiftBar menu bar
-- and herdr sound effects work for the Neovim opencode client, matching the
-- herdr TUI integration (~/.config/opencode/plugins/herdr-agent-state.js).
--
-- Requires Neovim to run inside a Herdr pane (HERDR_PANE_ID is inherited).
-- States map: working/blocked/idle -> herdr agent lifecycle; herdr plays
-- [ui.sound] sounds on the done/blocked transitions.
local M = {}

local AGENT_LABEL = 'opencode.nvim'
local SOURCE = 'nvim'

local seq = 0
local reported_root = nil
local ever_reported = false

local function session_id(event)
  local props = event and event.properties
  if type(props) == 'table' and type(props.sessionID) == 'string' then
    return props.sessionID
  end
  return nil
end

local function report(state, session_id)
  local pane_id = vim.env.HERDR_PANE_ID
  local socket = vim.env.HERDR_SOCKET_PATH
  if not pane_id or not socket then
    return
  end
  seq = seq + 1
  ever_reported = true
  local args = {
    'herdr', 'pane', 'report-agent', pane_id,
    '--source', SOURCE,
    '--agent', AGENT_LABEL,
    '--state', state,
    '--seq', tostring(seq),
  }
  if session_id then
    reported_root = session_id
    table.insert(args, '--agent-session-id')
    table.insert(args, session_id)
  end
  vim.system(args, { text = true }, function() end)
end

local function sessions_autocmd(patterns, state)
  return {
    pattern = patterns,
    callback = function(args)
      local event = args.data and args.data.event
      report(state, session_id(event))
    end,
  }
end

function M.setup()
  if not vim.env.HERDR_PANE_ID or not vim.env.HERDR_SOCKET_PATH then
    return
  end

  local group = vim.api.nvim_create_augroup('nikp_opencode_herdr', { clear = true })

  -- Agent picked up work: turn started, retrying, or answered a
  -- permission/question and is continuing.
  local working = sessions_autocmd({
    'OpencodeEvent:session.execution.started',
    'OpencodeEvent:session.retry.scheduled',
    'OpencodeEvent:permission.replied',
    'OpencodeEvent:form.replied',
    'OpencodeEvent:form.cancelled',
    'OpencodeEvent:question.replied',
    'OpencodeEvent:question.rejected',
  }, 'working')
  vim.api.nvim_create_autocmd('User', vim.tbl_extend('force', working, { group = group }))

  -- Waiting on the user: approval prompt or question dialog.
  local blocked = sessions_autocmd({
    'OpencodeEvent:permission.asked',
    'OpencodeEvent:form.created',
    'OpencodeEvent:question.asked',
  }, 'blocked')
  vim.api.nvim_create_autocmd('User', vim.tbl_extend('force', blocked, { group = group }))

  -- Turn finished (or the session went idle for any reason).
  local idle = sessions_autocmd({
    'OpencodeEvent:session.idle',
    'OpencodeEvent:session.execution.succeeded',
    'OpencodeEvent:session.execution.failed',
    'OpencodeEvent:session.execution.interrupted',
  }, 'idle')
  vim.api.nvim_create_autocmd('User', vim.tbl_extend('force', idle, { group = group }))

  -- Give the pane back when Neovim exits so the agent row disappears.
  vim.api.nvim_create_autocmd('VimLeavePre', {
    group = group,
    callback = function()
      if not ever_reported then
        return
      end
      local pane_id = vim.env.HERDR_PANE_ID
      if not pane_id then
        return
      end
      seq = seq + 1
      vim.system({
        'herdr', 'pane', 'release-agent', pane_id,
        '--source', SOURCE,
        '--agent', AGENT_LABEL,
        '--seq', tostring(seq),
      }, { text = true }, function() end)
    end,
  })
end

return M
