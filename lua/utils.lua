local M = {}

local nvim_config_lua_path = vim.fn.stdpath("config") .. "/" .. "lua"

--- Combines all plugin tables in a given package (directory)
--- Excludes those outlined in the init.lua or files starting with '_' or '.'.
---@param package relative path in relation to nvim config/lua
---@return table with all the plugins + configs
function M.plugin_require(package)
    local plugins = {}
    for _, path in pairs(vim.split(vim.fn.glob(nvim_config_lua_path .. "/" .. package .. "/" .. "*.lua"), "\n")) do
        relative_module_path = path:gsub(nvim_config_lua_path , ""):gsub("%.lua", "")
        module_name = relative_module_path:gsub("(.*/)(.*)", "%2")
        if (module_name ~= "init" and module_name:sub(1, 1) ~= "_" and module_name:sub(1, 1) ~= ".") then
            table.insert(plugins,require(relative_module_path))
        end
    end
    return plugins
end

return M
