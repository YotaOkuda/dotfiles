local icons = require("icons")
local colors = require("colors")
local settings = require("settings")

-- media.lua の冒頭あたりに、デバッグ用関数を用意しておく
local function debug_log(msg)
	local path = os.getenv("HOME") .. "/media_debug.log"
	local f = io.open(path, "a") -- 追記モードで開く
	if f then
		f:write(msg .. "\n")
		f:close()
	end
end

debug_log("media.lua loaded")

local whitelist = { ["Spotify"] = true, ["Spotify.app"] = true }

-- media_icon設定
local media_icon = sbar.add("item", {
	position = "right",
	icon = {
		string = icons.music,
		color = colors.fg,
	},
	label = {
		width = 0,
		color = colors.fg,
	},
	background = {
		color = colors.with_alpha(colors.bg, 0.0),
		border_color = colors.with_alpha(colors.border, 0.0),
		border_width = 2,
		image = {
			drawing = false,
			scale = 0.85,
		},
	},
	drawing = true,
	updates = true,
	popup = {
		align = "center",
		horizontal = true,
	},
})

-- media_info設定
local media_info = sbar.add("item", {
	position = "right",
	drawing = true,
	icon = { drawing = false },
	label = {
		font = { size = 12 },
		color = colors.with_alpha(colors.fg, 1),
		-- color = colors.white,
		width = 0,
		max_chars = 15, -- Adjust the max characters to fit both artist and title
		padding_left = 10,
		padding_right = 10,
	},
	background = {
		color = colors.with_alpha(colors.bg, 0.0),
		border_color = colors.with_alpha(colors.border, 0.0),
	},
})

-- ボタン関連
local back_icon = sbar.add("item", {
	position = "popup." .. media_icon.name, -- Use media_icon for positioning
	icon = { string = icons.media.back, font = { size = 12.0 } },
	label = { drawing = false },
	click_script = "nowplaying-cli previous",
})
local pause_icon = sbar.add("item", {
	position = "popup." .. media_icon.name,
	icon = { string = icons.media.play_pause, font = { size = 12.0 } },
	label = { drawing = false },
	click_script = "nowplaying-cli togglePlayPause",
})
local forward_icon = sbar.add("item", {
	position = "popup." .. media_icon.name,
	icon = { string = icons.media.forward, font = { size = 12.0 } },
	label = { drawing = false },
	click_script = "nowplaying-cli next",
})

local interrupt = 0
local function animate_detail(detail)
	if not detail then
		interrupt = interrupt - 1
	end
	if interrupt > 0 and not detail then
		return
	end

	sbar.animate("tanh", 30, function()
		media_info:set({ label = { width = detail and "dynamic" or 0 } })
	end)
end

-- メディアチェンジイベント
media_icon:subscribe("media_change", function(env)
	debug_log("media_change")
	-- まずデバッグ用にファイルへ書き込む
	debug_log(
		"RECEIVED media_change: app="
		.. tostring(env.INFO.app)
		.. " state="
		.. tostring(env.INFO.state)
		.. " artist="
		.. tostring(env.INFO.artist)
		.. " title="
		.. tostring(env.INFO.title)
	)

	if whitelist[env.INFO.app] then
		local drawing = (env.INFO.state == "playing")
		local artist_title = env.INFO.artist .. " - " .. env.INFO.title -- Concatenate artist and title
		media_info:set({
			drawing = drawing,
			label = {
				string = artist_title, -- 文字列をネストして渡す
				width = drawing and "dynamic" or 0,
			},
		})
		-- media_info:set({ drawing = drawing, label = artist_title })
		media_icon:set({ drawing = drawing })

		if drawing then
			animate_detail(true)
			interrupt = interrupt + 1
			sbar.delay(5, animate_detail)
		else
			media_icon:set({ popup = { drawing = false } })
		end
	end
end)

-- media_iconにマウスホバーすると曲名表示
media_icon:subscribe("mouse.entered", function(env)
	debug_log("mouse entered")
	interrupt = interrupt + 1
	animate_detail(true)
	sbar.animate("tanh", 10, function()
		media_icon:set({
			icon = {
				color = {
					alpha = 0,
				},
			},
			background = {
				color = { alpha = 0.0 },
				border_color = { alpha = 0.0 },
				image = {
					drawing = true,
					string = "media.artwork",
					scale = 0.85,
				},
			},
		})
		media_info:set({
			label = {
				color = { alpha = 1 },
			},
			background = {
				-- color = { alpha = 1 },
				color = colors.with_alpha(colors.bg, 0.8),
				border_color = { alpha = 1 },
			},
		})
	end)
end)

media_icon:subscribe("mouse.exited", function(env)
	debug_log("mouse exited")
	animate_detail(false)
	sbar.animate("tanh", 30, function()
		media_icon:set({
			icon = {
				color = colors.fg,
			},
			background = {
				image = {
					drawing = false,
				},
				color = { alpha = 0.0 },
				border_color = { alpha = 0.0 },
			},
		})
		media_info:set({
			label = {
				color = colors.fg,
			},
			background = {
				color = { alpha = 0 },
				border_color = { alpha = 0 },
			},
		})
	end)
end)

-- マウス関連
media_icon:subscribe("mouse.clicked", function(env)
	media_icon:set({ popup = { drawing = "toggle" } })
end)

media_info:subscribe("mouse.exited.global", function(env)
	media_icon:set({ popup = { drawing = false } })
end)

back_icon:subscribe("mouse.entered", function()
	back_icon:set({ icon = { highlight = true } })
end)
pause_icon:subscribe("mouse.entered", function()
	pause_icon:set({ icon = { highlight = true } })
end)
forward_icon:subscribe("mouse.entered", function()
	forward_icon:set({ icon = { highlight = true } })
end)

back_icon:subscribe("mouse.exited", function()
	back_icon:set({ icon = { highlight = false } })
end)
pause_icon:subscribe("mouse.exited", function()
	pause_icon:set({ icon = { highlight = false } })
end)
forward_icon:subscribe("mouse.exited", function()
	forward_icon:set({ icon = { highlight = false } })
end)
