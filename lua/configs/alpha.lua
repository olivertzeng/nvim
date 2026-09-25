local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	" ▗▄▖ ▗▄▖    █                      ▗▄▄▄▖               	 ",
	" █▀█ ▝▜▌    ▀                      ▝▀█▀▘                    ",
	"▐▌ ▐▌ ▐▌   ██  ▐▙ ▟▌ ▟█▙  █▟█▌       █  ▐███▌ ▟█▙ ▐▙██▖ ▟█▟▌",
	"▐▌ ▐▌ ▐▌    █   █ █ ▐▙▄▟▌ █▘         █    ▗▛ ▐▙▄▟▌▐▛ ▐▌▐▛ ▜▌",
	"▐▌ ▐▌ ▐▌    █   ▜▄▛ ▐▛▀▀▘ █          █   ▗▛  ▐▛▀▀▘▐▌ ▐▌▐▌ ▐▌",
	" █▄█  ▐▙▄ ▗▄█▄▖ ▐█▌ ▝█▄▄▌ █          █  ▗█▄▄▖▝█▄▄▌▐▌ ▐▌▝█▄█▌",
	" ▝▀▘   ▀▀ ▝▀▀▀▘  ▀   ▝▀▀  ▀          ▀  ▝▀▀▀▘ ▝▀▀ ▝▘ ▝▘ ▞▀▐▌",
	"                                                        ▜█▛▘",
}

dashboard.section.buttons.val = {
	dashboard.button("n", "  > 新檔案", "<CMD>ene <CR>"),
	dashboard.button("t", "  > 於 git repo 中尋找檔案", "<CMD>Telescope git_files <CR>"),
	dashboard.button("r", "  > 最近存取", "<CMD>Telescope oldfiles<CR>"),
	dashboard.button("l", "🗘  > 開啟上次存取的檔案", "<CMD>SessionManager load_last_session<CR>"),
}

local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

require("alpha").setup(dashboard.opts)
