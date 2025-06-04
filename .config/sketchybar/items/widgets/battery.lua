local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- Padding item required because of bracket
-- sbar.add("item", { position = "right", width = settings.group_paddings })

local battery = sbar.add("item", "widgets.battery", {
	position = "right",
	icon = { string = icons.cpu },
	label = {
		font = {
			family = settings.font.numbers,
		},
		color = colors.tn_yellow,
		width = "dynamic",
		-- width = 0, -- popup
	},
	background = {
		color = colors.tn_black3,
		border_color = colors.tn_yellow,
		border_width = 1,
	},
	padding_left = 0,
	padding_right = 0,
	update_freq = 180,
})

local remaining_time = sbar.add("item", {
	position = "popup." .. battery.name,
	icon = {
		string = "Time remaining:",
		width = 100,
		align = "left",
	},
	label = {
		string = "??:??h",
		width = 100,
		align = "right",
	},
})

battery:subscribe({ "routine", "power_source_change", "system_woke" }, function()
	sbar.exec("pmset -g batt", function(batt_info)
		local icon = "!"
		local label = "?"

		local found, _, charge = batt_info:find("(%d+)%%")
		if found then
			charge = tonumber(charge)
			label = charge .. "%"
		end

		local color = colors.tn_yellow
		local charging, _, _ = batt_info:find("AC Power")

		if charging then
			icon = icons.battery.charging

			if found and charge == 100 then
				color = colors.tn_green
			end
		else
			if found and charge >= 80 then
				icon = icons.battery._100
			elseif found and charge >= 60 then
				icon = icons.battery._75
			elseif found and charge >= 40 then
				icon = icons.battery._50
			elseif found and charge >= 20 then
				icon = icons.battery._25
				color = colors.tn_orange
			else
				icon = icons.battery._0
				color = colors.tn_red
			end
		end

		local lead = ""
		if found and charge < 10 then
			lead = "0"
		end

		battery:set({
			icon = {
				string = icon,
				color = color,
			},
			label = { string = lead .. label },
		})
	end)
end)

battery:subscribe("mouse.clicked", function(env)
	local drawing = battery:query().popup.drawing
	battery:set({ popup = { drawing = "toggle" } })

	if drawing == "off" then
		sbar.exec("pmset -g batt", function(batt_info)
			local found, _, remaining = batt_info:find(" (%d+:%d+) remaining")
			local label = found and remaining .. "h" or "No estimate"
			remaining_time:set({ label = label })
		end)
	end
end)

-- battery:subscribe("mouse.entered", function(env)
-- 	sbar.animate("tanh", 30, function()
-- 		battery:set({
-- 			label = { width = "dynamic" },
-- 		})
-- 	end)
-- end)
--
-- battery:subscribe("mouse.exited", function(env)
-- 	sbar.animate("tanh", 30, function()
-- 		battery:set({
-- 			label = { width = 0 },
-- 		})
-- 	end)
-- end)
