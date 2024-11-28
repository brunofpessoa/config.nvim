local M = {}

local git_dir = nil
local git_branch = "master"

function M.setup(config)
    if config.git_dir then
        git_dir = vim.fn.expand(config.git_dir)
        if vim.fn.isdirectory(git_dir .. "/.git") == 1 then
        else
            vim.notify("Invalid Git directory: " .. git_dir, vim.log.levels.ERROR)
            git_dir = nil
        end
    else
        vim.notify("Git directory not provided in setup.", vim.log.levels.ERROR)
    end

    if config.git_branch and #config.git_branch > 0 then
        git_branch = config.git_branch
    end

    vim.api.nvim_create_user_command("AddCommitPush", function()
        M.auto_commit_vault()
    end, { desc = "Automatically add, commit, and push changes to the Git repository" })
end

-- Função para executar comandos silenciosamente
local function run_cmd(cmd)
    local result = vim.fn.system(cmd)
    local success = vim.v.shell_error == 0
    if not success then
        vim.notify("Command failed: " .. cmd .. "\n" .. result, vim.log.levels.ERROR)
    end
    return success, result
end

function M.auto_commit_vault()
    if not git_dir then
        vim.notify("Git directory is not set. Please check your setup.", vim.log.levels.ERROR)
        return
    end

    -- Verifica se há mudanças a serem commitadas
    local status_cmd = string.format("cd %s && git status --porcelain", git_dir)
    local _, status_output = run_cmd(status_cmd)
    if status_output == "" then
        vim.notify("No changes to commit.", vim.log.levels.WARN)
        return
    end

    local time = os.date("%Y-%m-%d %H:%M:%S")
    local add_cmd = string.format("cd %s && git add .", git_dir)
    local commit_cmd = string.format('cd %s && git commit -m "%s"', git_dir, time)
    local push_cmd = string.format("cd %s && git push origin %s", git_dir, git_branch)

    local success, _ = run_cmd(add_cmd)
    if not success then return end

    success, _ = run_cmd(commit_cmd)
    if not success then
        vim.notify("No new commits created.", vim.log.levels.WARN)
        return
    end

    success, _ = run_cmd(push_cmd)
    if not success then return end

    vim.notify("Changes added, committed, and pushed successfully!", vim.log.levels.INFO)
end

return M
