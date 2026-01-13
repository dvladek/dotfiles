local M = {}

function M.project_root()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if git_root and git_root ~= '' and vim.v.shell_error == 0 then
    return git_root
  end
  return vim.fn.getcwd()
end

-- TODO(dvladek): Check the details of the code later on.
local function find_terminal_buf()
  -- Prefer a visible terminal
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local buf = vim.api.nvim_win_get_buf(win)
    if vim.bo[buf].buftype == 'terminal' then
      return buf, win
    end
  end

  -- Otherwise, any terminal buffer (even if hidden)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == 'terminal' then
      return buf, nil
    end
  end

  return nil, nil
end

local function open_terminal_right()
  vim.cmd('botright vsplit')
  vim.cmd('vertical resize 80')
  vim.cmd('terminal')
  local buf = vim.api.nvim_get_current_buf()
  local win = vim.api.nvim_get_current_win()
  return buf, win
end

local function terminal_job_id(buf)
  local job
  vim.api.nvim_buf_call(buf, function()
    job = vim.b.terminal_job_id
  end)
  return job
end

local function send_to_terminal(buf, cwd, cmd)
  local job = terminal_job_id(buf)
  if not job then
    vim.notify('Terminal buffer has no job_id (not a live terminal?)', vim.log.levels.ERROR)
    return
  end

  vim.fn.chansend(
    job,
    'cd ' .. vim.fn.fnameescape(cwd)
    .. ' && ' .. cmd .. '\n')
end

function M.run(mode)
  mode = mode or 'dev'

  local root = M.project_root()
  local script = root .. '/build.sh'
  if vim.fn.filereadable(script) == 0 then
    vim.notify('No build.sh found at: ' .. script, vim.log.levels.WARN)
    return
  end

  -- Save current window
  local origin_win = vim.api.nvim_get_current_win()

  vim.cmd('write')

  -- TODO(dvladek): Check this part of the code later
  local buf, win = find_terminal_buf()
  if not buf then
    buf, win = open_terminal_right()
  else
    -- If we found a terminal buffer but it's not visible, show it on the right
    if not win then
      vim.cmd('botright vsplit')
      vim.cmd('vertical resize 80')
      vim.cmd('buffer ' .. buf)
      win = vim.api.nvim_get_current_win()
    else
      -- It is visible: focus it
      vim.api.nvim_set_current_win(win)
    end
  end

  -- vim.cmd('botright vsplit')
  -- vim.cmd('vertical resize 80')
  -- vim.cmd('terminal')

  -- local chan = vim.bo.channel
  -- vim.fn.chansend(
  --  chan,
  --  'cd ' .. vim.fn.fnameescape(root)
  --    .. ' && chmod +x ./build.sh && ./build.sh ' .. mode .. '\n'
  -- )

  send_to_terminal(buf, root, 'chmod +x ./build.sh && ./build.sh ' .. mode)

  if vim.api.nvim_win_is_valid(origin_win) then
    vim.api.nvim_set_current_win(origin_win)
  else
    vim.cmd('startinsert')
  end
end

return M
