---@diagnostic disable: duplicate-doc-field, duplicate-doc-alias
local M = {}

local function setup()
  --- @type string
  local cache_home

  if vim.bool_fn.has 'win32' then
    -- $TEMP is cleaned automatically by Windows.
    -- So use $LOCALAPPDATA\nvim-data for cache path.
    cache_home = vim.env['LOCALAPPDATA'] .. '/nvim-data'
  else
    if vim.env['XDG_CACHE_HOME'] then
      cache_home = vim.env['XDG_CACHE_HOME']
    else
      cache_home = vim.fs.normalize '~/.cache'
    end
  end

  vim.env['DEIN_BASE'] = cache_home .. '/dein'

  local dein_cache = vim.env['DEIN_BASE'] .. '/repos/github.com/Shougo/dein.vim'
  if not vim.o.runtimepath:match '/dein.vim' then
    if not vim.bool_fn.isdirectory(dein_cache) then
      os.execute(('git clone https://github.com/Shougo/dein.vim.git %s'):format(dein_cache))
    end
  end

  vim.opt.runtimepath:prepend(dein_cache)
end

local gid = vim.augroup.GetOrAdd '__vimrc_ftplugin__'

--- @param ft string
--- @param plugin function
--- @param id string
local function add_ftplugin(ft, plugin, id)
  vim.autocmd.create('FileType', {
    group = gid,
    pattern = ft,
    callback = function(context)
      local did_ftplugin = vim.b.did_user_ftplugin or {}

      -- ftpluginでbuffer localなautocmdとか
      -- 定義しようとしたときに何度も実行されると
      -- 困るのでdid_ftpluginを使う。
      -- 複数のプラグインが同じfiletypeに対して設定をする
      -- ことも考えたいのでdictionaryで持つ
      if not did_ftplugin[id] then
        plugin(context)

        -- vim.b.did_user_ftplugin[opts.name] = true
        -- ↑みたいに書いても動かなかった
        did_ftplugin[id] = true
        vim.b.did_user_ftplugin = did_ftplugin
      end
    end,
  })
end

--- @param opts dein.Plugin
local function add_plugin(opts)
  local dein = require 'dein'
  dein.add(opts.repo, opts)
end

---@class dein.Plugin
---@field public repo? string
---@field public build? string
---@field public depends? string[]|string
---@field public frozen? boolean
---@field public ftplugin? { [string]: fun(ctx: vim.AutocmdArgs):nil }
---@field public enabled? boolean|string abbr of dein-options-if
---@field public lazy? boolean
---@field public merged? boolean
---@field public merge_ftdetect? boolean
---@field public name? string
---@field public normalized_name? string
---@field public on_cmd? string[]|string
---@field public on_event? vim.AutocmdEvent[]|vim.AutocmdEvent
---@field public on_func? string[]|string
---@field public on_ft? string[]|string
---@field public on_if? string
---@field public on_lua? string[]|string
---@field public on_map? table|string[]|string
---@field public on_path? string[]|string
---@field public on_source? string[]|string
---@field public overwrite? boolean
---@field public path? string
---@field public rev? string
---@field public rtp? string
---@field public script_type? string
---@field public timeout? number
---@field public trusted? boolean
---@field public type? 'none'|'raw'|'git'
---@field public type__depth? number
---@field public hook_add? string|fun():nil
---@field public hook_deno_update? string|fun():nil
---@field public hook_post_source? string|fun():nil
---@field public hook_post_update? string|fun():nil
---@field public hook_source? string|fun():nil
---@field public plugin? dein.Plugins

---@alias dein.Plugins { [string]: dein.Plugin }

---@param configs dein.Plugins
---@param shared_opts? dein.Plugin
local function load_configs(configs, shared_opts)
  local dein = require 'dein'
  shared_opts = shared_opts or {}
  -- 明示的に指定しない限りはlazy loadにする
  if shared_opts.lazy == nil then
    shared_opts.lazy = true
  end

  --- @param repo string
  --- @param opts dein.Plugin
  for repo, opts in pairs(configs) do
    opts.repo = opts.repo or repo
    opts.name = opts.name or vim.fn.fnamemodify(opts.repo, [[:s?/$??:t:s?\c\.git\s*$??]])

    if opts.enabled ~= nil then
      opts['if'] = opts.enabled
      opts.enabled = nil
    end

    if opts.plugin ~= nil then
      load_configs(opts.plugin, { on_source = opts.name, lazy = true })
      opts.plugin = nil
    end

    -- shared_optsが渡されたらoptsにマージするが、optsで同名
    -- の項目を入力していたらそれを優先したい
    if shared_opts ~= nil then
      for opt_name, value in pairs(shared_opts) do
        if opts[opt_name] == nil then
          opts[opt_name] = value
        end
      end
    end

    if opts.hook_source == nil then
      opts.hook_source = function()
        if
          vim.fn.filereadable(
            vim.fn.stdpath 'config'
              .. ('/lua/rc/plugin-configurations/c-%s.lua'):format(opts.name:gsub('%.nvim', ''):gsub('%.vim', ''))
          ) == 1
        then
          require(('rc.plugin-configurations.c-%s'):format(opts.name:gsub('%.nvim', ''):gsub('%.vim', '')))
        end
      end
    end

    if opts['ftplugin'] ~= nil then
      --- @param ft string
      --- @param plugin function
      for ft, plugin in pairs(opts['ftplugin']) do
        add_ftplugin(ft, function(context)
          -- プラグインが読み込まれていないときは実行したくない
          if dein.is_sourced(opts.name) then
            plugin(context)
          end
        end, opts.name)
      end
      opts['ftplugin'] = nil
    end

    add_plugin(opts)
  end
end

function M.startup(configs)
  setup()

  local dein = require 'dein'

  -- if vim.fn['dein#load_state'](dein_cache) ~= 0 then

  dein.setup {
    lazy_rplugins = true,
    auto_remote_plugins = true,
    install_progress_type = 'floating',
    install_check_diff = true,
    enable_notification = true,
  }

  dein.begin(vim.env.DEIN_BASE)

  -- I don't use dein#save_state()
  -- vim.g['dein#auto_recache'] = vim.fn.has('win32') == 0

  load_configs(configs)
  dein.end_()

  -- Function objects cannot be expressed by string,
  -- so dein.vim cannot cache them.
  -- I want to write dein-options-hook_* by lua functions.
  -- So I don't use `dein#save_state()`
  --
  --  vim.fn['dein#save_state']()
  -- end

  if dein.check_install() then
    dein.install()
  end

  vim.api.nvim_create_user_command('UpdatePlugins', 'call dein#update()', {})
end

return M
