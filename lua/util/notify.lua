local M = {}

function M.Notify_something(title, content, type)
    local notify = require("notify")
    if notify then
        notify(content, type or "info", { title = title })
    end
end

return M
