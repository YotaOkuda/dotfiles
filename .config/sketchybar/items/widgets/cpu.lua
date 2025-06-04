local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Execute the event provider binary which provides the event "cpu_update" for
-- the cpu load data, which is fired every 2.0 seconds.
sbar.exec("killall cpu_load >/dev/null; $CONFIG_DIR/helpers/event_providers/cpu_load/bin/cpu_load cpu_update 2.0")

local cpu = sbar.add("item", {
	position = "right",
	icon = {
		string = icons.cpu,
		color = colors.fg,
		-- align = "center",
		padding_left = 6,
		padding_right = 8,
	},
	label = {
		string = "??%",
		font = {
			family = settings.font.numbers,
		},
		color = colors.tn_red,
		width = 0,
	},
	background = {
		color = colors.tn_black3,
		border_color = colors.tn_red,
		border_width = 1,
	},
})

cpu:subscribe("cpu_update", function(env)
	-- Also available: env.user_load, env.sys_load
	local load = tonumber(env.total_load)

	local color = colors.fg
	if load > 30 then
		if load < 60 then
			color = colors.tn_yellow
		elseif load < 80 then
			color = colors.tn_orange
		else
			color = colors.tn_red
		end
	end

	cpu:set({
		icon = {
			color = color,
		},
		label = env.total_load .. "%",
	})
end)

cpu:subscribe("mouse.clicked", function(env)
	sbar.exec("open -a 'Activity Monitor'")
end)

cpu:subscribe("mouse.entered", function(env)
	sbar.animate("tanh", 30, function()
		cpu:set({
			label = { width = "dynamic" },
		})
	end)
end)

cpu:subscribe("mouse.exited", function(env)
	sbar.animate("tanh", 30, function()
		cpu:set({
			label = { width = 0 },
		})
	end)
end)
