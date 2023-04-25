local M = {}

---@param plugin string
---@return boolean
function M.tap(plugin)
  return require('dein').is_available(plugin)
end

---@param plugin string
function M.source(plugin)
  require('dein').source(plugin)
end

---@param plugin string
---@return boolean
function M.is_sourced(plugin)
  return require('dein').is_sourced(plugin)
end

---@param plugin string
---@param hook function
function M.set_hook(plugin, hook)
  require('dein').set_hook(plugin, 'hook_post_source', hook)
end

---@param plugin string
---@param hook function
function M:extension(plugin, hook)
  if self.tap(plugin) then
    if self.is_sourced(plugin) then
      hook()
    else
      self.set_hook(plugin, hook)
    end
  end
end

return M
