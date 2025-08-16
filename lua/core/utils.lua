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

return M