local dotenv = ('%s/.env'):format(vim.fn.stdpath 'config')
if not vim.bool_fn.filereadable(dotenv) then
  return
end

-- .envはVAR=VALの形式で記載されていると仮定する
for _, line in ipairs(vim.fn.readfile(dotenv)) do
  local eq_index = line:find '='
  vim.env[line:sub(1, eq_index - 1)] = line:sub(eq_index + 1)
end
