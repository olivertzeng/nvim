-- ============================================================================
-- File: lua/configs/luasnip.lua
-- Description: LuaSnip core setup.
-- Note: Keybindings are now entirely handled by blink.cmp
-- ============================================================================

local ls = require("luasnip")

ls.setup({
	-- Enable auto expansion
	enable_autosnippets = true,
	-- Visual snippets triggered using <c-x>
	store_selection_keys = "<c-x>",
})

-- Load VSCode-like snippets (like friendly-snippets)
require("luasnip.loaders.from_vscode").lazy_load()
