local M = {}

local nvim_config_lua_path = vim.fn.stdpath("config") .. "/" .. "lua"

--- Combines all plugin tables in a given package (directory)
--- Excludes those outlined in the init.lua or files starting with "_" or ".".
---@param package relative path in relation to nvim config/lua
---@return table with all the plugins + configs
function M.plugin_require(package)
    local plugins = {}
    for _, path in pairs(vim.split(vim.fn.glob(nvim_config_lua_path .. "/" .. package .. "/" .. "*.lua"), "\n")) do
        local relative_module_path = path:gsub(nvim_config_lua_path, ""):gsub("%.lua", "")
        local module_name = relative_module_path:gsub("(.*/)(.*)", "%2")
        if (module_name ~= "init" and module_name:sub(1, 1) ~= "_" and module_name:sub(1, 1) ~= ".") then
            table.insert(plugins, require(relative_module_path))
        end
    end
    return plugins
end

function M.directory_require(directory)
    for _, path in pairs(vim.split(vim.fn.glob(nvim_config_lua_path .. "/" .. directory .. "/" .. "*.lua"), "\n")) do
        local relative_module_path = path:gsub(nvim_config_lua_path, ""):gsub("%.lua", "")
        local module_name = relative_module_path:gsub("(.*/)(.*)", "%2")
        if (module_name ~= "init" and module_name:sub(1, 1) ~= "_" and module_name:sub(1, 1) ~= ".") then
            require(relative_module_path)
        end
    end
end

function M.tableToString(table)
    if type(table) == "table" then
        local s = "{ "
        for k, v in pairs(table) do
            if type(k) ~= "number" then k = '"' .. k .. '"' end
            s = s .. "[" .. k .. "] = " .. M.tableToString(v) .. ","
        end
        return s .. "} "
    else
        return tostring(table)
    end
end

return M
