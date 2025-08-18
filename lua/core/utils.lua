local M = {}

local nvim_config_lua_path = vim.fn.stdpath("config") .. "/" .. "lua"

function M.safe_require_alert(module_name, log_level)
    local mod = M.safe_require(module_name)
    if mod == nil then
        vim.notify("Module " .. module_name .. " not found", log_level or vim.log.levels.WARN)
    end
    return mod
end

function M.safe_require(module_name)
    local ok, mod = pcall(require, module_name)
    if not ok then
        return nil
    end
    return mod
end

function M.apply_ft(ft, plugins)
    if type(plugins[1]) == "table" then
        for k, v in pairs(plugins) do
            M.apply_ft(ft, v)
        end
    else
        if plugins.ft ~= nil then
            if type(plugins.ft) == "string" then
                plugins.ft = { plugins.ft, ft }
            else
                table.insert(plugins.ft, ft)
            end
        else
            plugins.ft = { ft }
        end
    end
    return plugins
end

function M.map(mode, keys, command, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.keymap.set(mode, keys, command, options)
end

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

return M
