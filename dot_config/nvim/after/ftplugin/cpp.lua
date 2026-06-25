-- Configure bindings for c/c++ source files
vim.keymap.set(
	"n",
	"<LocalLeader>ca",
	"<Cmd>LspClangdSwitchSourceHeader<CR>",
	{ buffer = true, desc = "C++: Switch source header" }
)
vim.keymap.set(
	"n",
	"<LocalLeader>cs",
	"<Cmd>LspClangdShowSymbolInfo<CR>",
	{ buffer = true, desc = "C++: Show symbol info" }
)
