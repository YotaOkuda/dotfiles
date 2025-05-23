local settings = require("settings")
local colors = require("colors")

-- Padding item required because of bracket
sbar.add("item", { position = "right", width = settings.group_paddings })

local cal = sbar.add("item", {
	icon = {
		font = {
			style = settings.font.style_map["Black"],
			size = 12.0,
		},
		padding_left = 10,
		padding_right = 2,
	},
	-- label = {
	-- 	width = 40,
	-- 	align = "right",
	-- 	font = { family = settings.font.numbers },
	-- 	padding_left = -10,
	-- },
	position = "right",
	update_freq = 30,
})

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({ icon = os.date("%b. %d %a.  %H:%M") })
	-- cal:set({ icon = os.date("%b. %d %a."), label = os.date("%H:%M") })  # date is label version
end)
