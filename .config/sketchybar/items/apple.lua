local colors = require("colors")
local icons = require("icons")
local settings = require("settings")

-- Padding item required because of bracket
-- sbar.add("item", { width = 5 })
sbar.add("item", {
	position = "left",
	width = settings.group_paddings,
	background = { drawing = false },
})

local apple = sbar.add("item", {
	icon = {
		font = { size = 16.0 },
		string = icons.apple,
		padding_right = 8,
		padding_left = 8,
		color = colors.tn_green,
	},
	label = { drawing = false },
	background = {
		-- drawing = false,
		color = colors.tn_black3,
		border_color = colors.tn_green,
		border_width = 1,
	},
	padding_left = 1,
	padding_right = 1,
	click_script = "$CONFIG_DIR/helpers/menus/bin/menus -s 0",
})

-- Double border for apple using a single item bracket
sbar.add("bracket", { apple.name }, {
	background = {
		drawing = false,
		color = colors.transparent,
		height = 30,
		border_color = colors.grey,
	},
})

-- Padding item required because of bracket
-- sbar.add("item", { width = 7 })
