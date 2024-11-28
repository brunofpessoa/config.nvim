local M = {}

local prayers = {
    "Jesus, manso e humilde de coração, fazei meu coração semelhante ao Vosso.",
    "Jesus, eu confio em Vós!",
    "Jesus, eu vos amo, salvai as almas.",
    "Jesus, sede a minha salvação.",
    "Jesus, manso e humilde de coração, fazei meu coração semelhante ao Vosso.",
    "Jesus, meu Deus, eu vos amo sobre todas as coisas.",
    "Jesus, meu Senhor e meu Deus!",
    "Jesus, eu confio em Vós!",
    "Jesus, filho de Davi, tende misericórdia de mim!",
    "Jesus, manso e humilde de coração, fazei meu coração semelhante ao Vosso.",
    "Jesus, meu refúgio e minha fortaleza.",
    "Santa Maria, Mãe de Deus, rogai por nós pecadores.",
    "Santa Maria, rogai por nós!",
    "Ó Maria, concebida sem pecado, rogai por nós que recorremos a Vós.",
    "Maria, Mãe da graça, Mãe de misericórdia, protegei-nos de todo mal e dai-nos a paz.",
    "Maria, refúgio dos pecadores, rogai por nós!",
    "Maria, Rainha dos Apóstolos, rogai por nós!",
    "Maria, Rainha dos Mártires, rogai por nós!",
    "Maria, Mãe puríssima, rogai por nós!",
    "Maria, consoladora dos aflitos, rogai por nós!",
    "Maria, Estrela da manhã, rogai por nós!",
    "São José, rogai por nós!",
    "São José, protetor da Santa Igreja, rogai por nós!",
    "Glorioso São José, modelo de trabalhadores, protegei-nos!",
    "São José, homem justo, rogai por nós!",
    "São José, exemplo de vida familiar, rogai por nós!",
    "São José, guardião das virgens, rogai por nós!",
    "São José, amparo dos agonizantes, rogai por nós!",
    "São José, esperança dos doentes, rogai por nós!",
    "São José, patrono dos pobres, rogai por nós!",
    "São José, terror dos demônios, rogai por nós!"
}

local configs = {
    interval = 30 * 60, --update interval in seconds
    notify = true,
    notify_icon = "󰳶",
    notify_title = "Oração",
    start_char = "󰳶 ",
    end_char = " 󰳶",
    prayers = prayers,
    show_in_lualine = true,
}

math.randomseed(os.time())

local function get_random_prayer()
    local idx = math.random(#configs.prayers)
    return configs.start_char .. configs.prayers[idx] .. configs.end_char
end

local prayer = get_random_prayer()

function M.get_prayer() return prayer end

function M.update_prayer()
    prayer = get_random_prayer()
    if configs.notify then
        local notify = require("notify")
        if notify then
            notify(prayer, "info", { title = configs.notify_title, icon = configs.notify_icon })
        end
    end
end

local function timer_prayer()
    local timer = vim.loop.new_timer()
    local ms = configs.interval * 1000
    timer:start(ms, ms, function()
        M.update_prayer()
    end)
    return timer
end

function M.setup(opts)
    vim.api.nvim_create_user_command("PrayerUpdate", M.update_prayer, { desc = "Update Prayer" })

    configs = vim.tbl_deep_extend("force", configs, opts or {})

    if M.timer then
        M.timer:stop()
        M.timer:close()
    end
    M.timer = timer_prayer()

    vim.api.nvim_create_autocmd("VimLeavePre", {
        callback = function()
            if M.timer then
                M.timer:stop()
                M.timer:close()
            end
        end
    })

    if configs.show_in_lualine then
        require("lualine").setup({
            sections = {
                lualine_c = { { M.get_prayer } } }
        })
    end
end

return M
