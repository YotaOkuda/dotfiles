local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.icon_map")
local icons = require("icons")

local front_app = sbar.add("item", "front_app", {
	display = "active",
	icon = {
		font = "sketchybar-app-font-bg:Regular:18.0",
		padding_right = 4,
		-- color = colors.tn_cyan,
	},
	background = {
		color = colors.tn_black3,
		border_color = colors.tn_cyan,
		border_width = 1,
	},
	updates = true,
})

-- front_app:subscribe("front_app_switched", function(env)
-- 	local icon = app_icons[env.INFO] or app_icons["Default"]
--
-- 	front_app:set({
-- 		label = {
-- 			string = icon,
-- 			-- font = "sketchybar-app-font-bg:Regular:18.0",
-- 		},
-- 	})
-- end)

front_app:subscribe("front_app_switched", function(env)
	local lookup = app_icons[env.INFO]
	local icon = ((lookup == nil) and app_icons["Default"] or lookup)
	front_app:set({
		icon = "" .. icon,
		label = { string = env.INFO },
	})
end)

front_app:subscribe("mouse.clicked", function(env)
	sbar.trigger("swap_menus_and_spaces")
end)
