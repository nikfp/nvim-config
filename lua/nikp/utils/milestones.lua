local M = {}

local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local themes = require("telescope.themes")
local conf = require("telescope.config").values
local actions = require("telescope.actions")
local previewers = require("telescope.previewers")
local action_state = require("telescope.actions.state")
local entry_display = require("telescope.pickers.entry_display")

local function current_repo()
  local out = vim.fn.systemlist("gh repo view --json nameWithOwner -q .nameWithOwner 2>/dev/null ")
  if vim.v.shell_error ~= 0 or not out[1] or out[1] == "" then
    vim.notify("Could not determine Github repo from current directory", vim.log.levels.ERROR)
    return nil
  end
  return out[1]
end

local function fetch_milestones(repo)
  local cmd = string.format(
    [[gh api repos/%s/milestones --paginate --jq '.[] | {title: .title, number: .number, state: .state, description: .description, open_issues: .open_issues, closed_issues: .closed_issues}']],
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

local function open_issue(issue)
  vim.cmd(("Octo issue edit %d"):format(issue.number))
end

local function open_issue_picker(repo, milestone)
  local cmd = ("gh issue list --repo %s --milestone %d --json number,title,body,comments"):format(repo, milestone.number)
  local output = vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("gh issue list failed", vim.log.levels.ERROR)
    return
  end

  local ok, decoded_issues = pcall(vim.json.decode, output)
  if not ok then
    vim.notify("Failed to parse issue JSON", vim.log.levels.ERROR)
    return
  end

  local function issue_previewer()
    return previewers.new_buffer_previewer({
      title = "Issue Details",
      define_preview = function(self, entry, _)
        local issue = entry.value
        local lines = {
          ("#%s %s"):format(issue.number, issue.title),
          "",
          ("Comments: %d"):format(vim.tbl_count(issue.comments or {})),
          "",
        }

        if issue.body and #issue.body > 0 then
          table.insert(lines, "")
          table.insert(lines, "Description:")
          table.insert(lines, issue.body)
          table.insert(lines, "")
        end
        if issue.comments and #issue.comments > 0 then
          table.insert(lines, "Comments")
          table.insert(lines, "--------")

          for i, comment in ipairs(issue.comments) do
            local body = comment.body or comment.bodyText or vim.inspect(comment)
            table.insert(lines, ("[%d] %s"):format(i, comment.author and comment.author.login or "unknown"))
            table.insert(lines, body)
            table.insert(lines, "")
          end
        else
          table.insert(lines, "No comments")
        end

        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
        vim.bo[self.state.bufnr].filetype = "markdown"
      end,
    })
  end

  local function issues_picker(issues)
    pickers.new({}, {
      prompt_title = "GitHub Issues",
      finder = finders.new_table({
        results = issues,
        entry_maker = function(issue)
          return {
            value = issue,
            ordinal = ("%s %s"):format(issue.number, issue.title),
            display = ("#%-4s %s"):format(issue.number, issue.title),
          }
        end,
      }),
      sorter = conf.generic_sorter({}),
      previewer = issue_previewer(),
      attach_mappings = function(prompt_bufnr, map)
        local function select_issue()
          local selection = action_state.get_selected_entry()
          actions.close(prompt_bufnr)
          open_issue(selection.value)
        end

        map("i", "<CR>", select_issue)
        map("n", "<CR>", select_issue)
        return true
      end,
    }):find()
  end

  issues_picker(decoded_issues)
end

function M.pick_milestone_issues()
  local repo = current_repo()
  if not repo then
    return
  end

  local function percent_complete(open_count, closed_count)
    local total = open_count + closed_count
    if total == 0 then
      return 0
    end
    return (closed_count / total) * 100
  end

  local milestones = fetch_milestones(repo)
  if vim.tbl_isempty(milestones) then
    vim.notify("No milestones found for repo: " .. repo, vim.log.levels.INFO)
    return
  end

  local title_width = 0
  local percent_width = 0


  for _, milestone in ipairs(milestones) do
    local percent = percent_complete(milestone.open_issues, milestone.closed_issues)
    local percent_string = string.format("%.1f%%", percent)

    title_width = math.max(title_width, #milestone.title)
    percent_width = math.max(percent_width, #percent_string + 2) -- for [xx.x%]
  end

  local displayer = entry_display.create({
    seperator = " ",
    items = {
      { width = title_width, },
      { width = percent_width },
      { remaining = true }
    }
  })


  pickers.new(themes.get_dropdown({
    prompt_title = ("Milestones: %s"):format(repo),
    finder = finders.new_table({
      results = milestones,
      entry_maker = function(m)
        local percent = percent_complete(m.open_issues, m.closed_issues)
        local percent_string = string.format("%.1f%%", percent)

        return {
          value = m,
          ordinal = ("%s %s %s %s"):format(m.title, m.number, m.state, m.description),
          display = function(entry)
            return displayer({
              entry.value.title,
              percent_string,
              entry.value.description
            })
          end,
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
  })):find()
end

return M
