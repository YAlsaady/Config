local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
--
null_ls.setup({
	debug = false,
	sources = {
		formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.stylua,
		formatting.shfmt,
		-- formatting.clang_format, --astyle,
		-- diagnostics.clang_check, --astyle,
    -- diagnostics.flake8
	},
})
-- null_ls.setup({
--     sources = {
--         null_ls.builtins.formatting.stylua,
--         -- null_ls.builtins.diagnostics.eslint,
--         -- null_ls.builtins.completion.spell,
--     },
-- })
-- local sources = { null_ls.builtins.formatting.astyle }
-- require("null-ls").setup({
--   sources = {
--     require("null-ls").builtins.formatting.shfmt, -- shell script formatting
--     require("null-ls").builtins.formatting.astyle, -- C/C++ formatting
--   },
-- })