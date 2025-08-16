local M = {}

function M.safe_require_alert(module_name)
    local mod = M.safe_require(module_name)
    if mod == nil then
        vim.notify("Module " .. module_name .. " not found", vim.log.levels.WARN)
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

return M