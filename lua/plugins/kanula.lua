return {
    'mistweaverco/kulala.nvim',
    keys = {
        { "<leader>k",  "",                                              desc = "+Kanula (HTTP client)" },
        { "<leader>kr", ":lua require('kulala').run()<CR>",              desc = "Run" },
        { "<leader>ka", ":lua require('kulala').run_all()<CR>",          desc = "Run All" },
        { "<leader>ke", ":lua require('kulala').set_selected_env()<CR>", desc = "Select Env" },
        { "<leader>kv", ":lua require('kulala').toggle_view()<CR>", desc = "Toggle View (Header/Body)" },
        { "<leader>kn", ":lua require('kulala').jump_next()<CR>", desc = "Go to Next Request" },
        { "<leader>kp", ":lua require('kulala').jump_prev()()<CR>", desc = "Go to Previous Request" },
        { "<leader>kc", ":lua require('kulala').clear_cached_files()<CR>", desc = "Clear Cached Files" },
    },
    opts = {}
}

--[[ https://kulala.mwco.app/docs/usage/
# COMO USAR

## ENV VARIABLES
- crie o arquivo `http-client.env.json` no root do arquivo .http e defina os ambiente e suas variáveis: { "dev": { vars... }, "testing": { vars...} }
- o env padrão é "dev"
- A variável será acessada assim: {{VARIAVEL}}

## REQUEST EXEMPLE

# @name REQUEST_ONE
POST {{API_URL}} HTTP/1.1
Content-Type: application/json
Authorization: Bearer {{API_KEY}}

{
  "name": "John"
}

## Passando variáveis de um request para outro
{{REQUEST_ONE.response.headers['Content-Type']}}
{{REQUEST_ONE.response.headers.Date}}
{{REQUEST_ONE.response.body.$.json.username}}

## VARIÁVEIS
- Variaveis podem ser criadas assim: `@username=fulano` e acessadas com a sintaxe `{{username}}`
- Você pode receber um prompt para preencher uma variável definindo-a assim: `# @prompt username`

--]]
