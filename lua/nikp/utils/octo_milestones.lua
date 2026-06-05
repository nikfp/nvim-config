local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")

local function current_repo()
  local out = vim.fn.systemlist("gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null ")
  if vim.v.shell_error ~= 0 or not out[1] or out[1] == "" then
    vim.notify("Could not determine Github repo from current directory", vim.log.levels.ERROR)
    return nil
  end
  return out[1]
end

local function gh_json(cmd)
  local output = vim.fn.system(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify(output, vim.log.levels.ERROR)
    return nil
  end

  local ok, decoded = pcall(vim.json.decode, output)

  if not ok then
    vim.notify("Failed to decode GH API response", vim.log.levels.ERROR)
    return nil
  end

  return decoded
end

local function fetch_milestones(repo)
  local cmd = string.format(
    [[gh api repos/%s/milestones --paginate --jq '.[] | {title: .title, number: .number, state: .state}']],
    repo
  )

  local lines = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 then
    vim.notify(table.concat(lines, "\n"), vim.log.levels.ERROR)
    return {}
  end

  local items = {}
  for _, line in ipairs(lines) do
    local ok, item = pcall(vim.json.decode, line)
    if ok and item then
      table.insert(items, item)
    end
  end
  return items
end

local function fetch_issues(repo, milestone_number)
  local cmd = string.format(
    [[gh api repos/%s/issues --paginate -f milestone=%d -f state=open]],
    repo,
    milestone_number
  )

  local data = gh_json(cmd)
  if not data then
    return {}
  end

  local issues = {}
  for _, item in ipairs(data) do
    if not item.pull_request then
      table.insert(issues, {
        number = item.number,
        title = item.title,
        state = item.state,
        url = item.html_url,
      })
    end
  end

  return issues
end

local function open_issue_picker(repo, milestone)
  local issues = fetch_issues(repo, milestone.number)
  if vim.tbl_isempty(issues) then
    vim.notify(("No open issues for milestone: %s"):format(milestone.title), vim.log.levels.INFO)
    return
  end

  pickers.new({}, {
    prompt_title = ("Issues in milestone: %s"):format(milestone.title),
    finder = finders.new_table({
      results = issues,
      entry_maker = function(issue)
        return {
          value = issue,
          ordinal = ("%s %s"):format(issue.number, issue.title),
          display = ("#%d  %s"):format(issue.number, issue.title),
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local function open_issue()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.cmd(("Octo issue edit %s %d"):format(repo, selection.value.number))
      end

      map("i", "<CR>", open_issue)
      map("n", "<CR>", open_issue)
      return true
    end,
  }):find()
end

function M.pick_milestone_issues()
  local repo = current_repo()
  if not repo then
    return
  end

  local milestones = fetch_milestones(repo)
  if vim.tbl_isempty(milestones) then
    vim.notify("No milestones found for repo: " .. repo, vim.log.levels.INFO)
    return
  end

  pickers.new({}, {
    prompt_title = ("Milestones: %s"):format(repo),
    finder = finders.new_table({
      results = milestones,
      entry_maker = function(m)
        return {
          value = m,
          ordinal = ("%s %s %s"):format(m.title, m.number, m.state),
          display = ("#%d  %s  [%s]"):format(m.number, m.title, m.state),
        }
      end,
    }),
    sorter = conf.generic_sorter({}),
    attach_mappings = function(prompt_bufnr, map)
      local function select_milestone()
        local selection = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        open_issue_picker(repo, selection.value)
      end

      map("i", "<CR>", select_milestone)
      map("n", "<CR>", select_milestone)
      return true
    end,
  }):find()
end

return M
