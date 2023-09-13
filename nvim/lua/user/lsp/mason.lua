local servers = {
	-- "sumneko_lua",
    "lua_ls",
    -- "clangd",
    "texlab",
    "asm_lsp",
    "bashls",
    -- "arduino",
    -- "arduino-language-server",
    -- "arduino-language-server",
    -- "ltex",
	-- "cssls",
	-- "html",
	-- "tsserver",
	"pyright",
	-- "bashls",
	"jsonls",
	-- "yamlls",
}

local settings = {
	ui = {
		border = "none",
		icons = {
			package_installed = "◍",
			package_pending = "◍",
			package_uninstalled = "◍",
		},
	},
	log_level = vim.log.levels.INFO,
	max_concurrent_installers = 4,
}

require("mason").setup(settings)
require("mason-lspconfig").setup({
	ensure_installed = servers,
	automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	server = vim.split(server, "@")[1]

	local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. server)
	if require_ok then
		opts = vim.tbl_deep_extend("force", conf_opts, opts)
	end

	lspconfig[server].setup(opts)
end


opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
    filetype = { "arduino" },
    cmd ={
        -- '/usr/bin/arduino-language-server',
        'arduino-language-server',
        '-cli', '~/bin/arduino-cli',
        '-cli-config', '~/.arduino15/arduino-cli.yaml',
        '-clangd', '/usr/bin/clangd',
        -- '-fqbn', 'esp32:esp32:esp32',
        '-fqbn', 'arduino:avr:nano',
    },
}


local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. "arduino_language_server")
if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
end

-- lspconfig["arduino_language_server"].setup(opts)


-- lspconfig["arduino_language_server"].setup{
 --    -- require'lspconfig'.arduino_language_server.setup{
 --        -- cmd = {"arduino-language-server"},
 --        cmd ={
 --            'arduino-language-server',
 --            -- '-cli-config', '~/.arduino15/arduino-cli.yaml',
 --            '-cli', '~/bin/arduino-cli',
 --            -- '-clangd', '/usr/bin/clangd',
 --            -- '-fqbn', 'esp32:esp32:esp32',
 --            -- '-fqbn', 'arduino:avr:nano',
 --        },
 --        filetype = { "arduino" },
 --    }







opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
    filetype = {"arduino", "ino", "c", "cpp", "objc", "objcpp", "cuda", "proto" },
    cmd = { "/usr/bin/clangd" },
}


local require_ok, conf_opts = pcall(require, "user.lsp.settings." .. "clangd")
if require_ok then
    opts = vim.tbl_deep_extend("force", conf_opts, opts)
end

lspconfig["clangd"].setup(opts)
