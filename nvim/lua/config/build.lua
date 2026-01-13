local M = {}

function M.project_root()
  local git_root = vim.fn.systemlist('git rev-parse --show-toplevel')[1]
  if git_root and git_root ~= '' and vim.v.shell_error == 0 then
    return git_root
  end
  return vim.fn.getcwd()
end

function M.run(mode)
  mode = mode or 'dev'

  local root = M.project_root()
  local script = root .. '/build.sh'
  if vim.fn.filereadable(script) == 0 then
    vim.notify('No build.sh found at: ' .. script, vim.log.levels.WARN)
    return
  end

  vim.cmd('write')

  vim.cmd('botright vsplit')
  vim.cmd('vertical resize 80')
  vim.cmd('terminal')

  local chan = vim.bo.channel
  vim.fn.chansend(
    chan,
    'cd ' .. vim.fn.fnameescape(root)
      .. ' && chmod +x ./build.sh && ./build.sh ' .. mode .. '\n'
  )
  
  vim.cmd('startinsert')
end

return M

