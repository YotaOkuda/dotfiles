local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.app_icons")

-- ワークスペース名を文字列の配列で定義（数字1〜9と小文字a〜zのうち利用したい文字）
local workspace_list = {
	"1",
	"2",
	"3",
	"4",
	"5",
	"6",
	"7",
	"8",
	"9",
	"A",
	"B",
	"C",
	"D",
	"E",
	"F",
	"G",
	"I",
	"M",
	"N",
	"O",
	"P",
	"Q",
	"R",
	"S",
	"T",
	"U",
	"V",
	"W",
	"X",
	"Y",
	"Z",
}

local focused_workspace_id = nil
local is_show_windows = true
local workspaces = {}

-- トグルボタン：ワークスペースラベル（ウィンドウアイコン）の表示・非表示を制御
local toggle_windows = sbar.add("item", {
	icon = {
		string = icons.aerospace,
		padding_right = 8,
		padding_left = 6, -- サバイバルモードレイアウト用
	},
	label = { width = 0, y_offset = 0.5, padding_right = 15 },
	background = {
		color = colors.with_alpha(colors.bg, 0),
		border_color = colors.fg_highlight,
	},
	padding_right = 0,
})

toggle_windows:subscribe("mouse.entered", function()
	sbar.animate("tanh", 10, function()
		toggle_windows:set({
			label = {
				string = is_show_windows and icons.chevron.left or icons.chevron.right,
				width = "dynamic",
			},
			background = {
				color = colors.with_alpha(colors.bg, 1),
				border_width = 2,
			},
		})
	end)
end)

toggle_windows:subscribe("mouse.exited", function()
	sbar.animate("tanh", 10, function()
		toggle_windows:set({
			label = { width = 0 },
			background = {
				color = colors.with_alpha(colors.bg, 0),
				border_width = 0,
			},
		})
	end)
end)

toggle_windows:subscribe("aerospace_mode_change", function(ENV)
	local mode = ENV.MODE
	sbar.animate("tanh", 10, function()
		if mode ~= "main" then
			toggle_windows:set({
				background = {
					border_color = colors.white,
					border_width = 2,
				},
			})
		else
			toggle_windows:set({
				icon = {
					color = colors.fg,
				},
				background = {
					color = colors.with_alpha(colors.bg, 0),
					border_color = colors.fg_highlight,
					border_width = 0,
				},
			})
		end
	end)
end)

-- ワークスペースごとに開いているウィンドウのアイコンを更新する関数
local function updateWindows(workspace_id)
	local get_windows =
			string.format("aerospace list-windows --workspace %s --format '%%{app-name}' --json", workspace_id)
	sbar.exec(get_windows, function(open_windows)
		local icon_line = ""
		local no_app = true

		for _, open_window in ipairs(open_windows) do
			no_app = false
			local app = open_window["app-name"]
			local lookup = app_icons[app]
			local icon = (lookup == nil) and app_icons["Default"] or lookup
			icon_line = icon_line .. " " .. icon
		end

		sbar.animate("tanh", 10, function()
			if no_app then
				if workspace_id == focused_workspace_id then
					-- フォーカス中でアプリがない場合はプレースホルダーを表示
					icon_line = "—"
					workspaces[workspace_id]:set({
						icon = { drawing = true },
						label = { drawing = true, string = icon_line },
						background = { drawing = true },
						padding_right = 1,
						padding_left = 2,
					})
					return
				end

				-- 空かつフォーカス外なら非表示
				workspaces[workspace_id]:set({
					icon = { drawing = false },
					label = { drawing = false },
					background = { drawing = false },
					padding_right = 0,
					padding_left = 0,
				})
				return
			end

			-- アプリがある場合はアイコンを表示
			workspaces[workspace_id]:set({
				icon = { drawing = true },
				label = { drawing = true, string = icon_line },
				background = { drawing = true },
				padding_right = 1,
				padding_left = 2,
			})
		end)
	end)
end

-- ワークスペース一覧をループしてアイテムを生成
for _, workspace_id in ipairs(workspace_list) do
	local workspace = sbar.add("item", {
		icon = {
			font = { family = settings.font.numbers },
			string = workspace_id, -- "1", "a" など文字列のまま表示
			padding_left = 5,
			padding_right = 8,
		},
		label = {
			padding_right = 20,
			color = colors.fg_secondary,
			highlight_color = colors.fg,
			font = "sketchybar-app-font:Regular:16.0",
			y_offset = -1,
		},
		padding_right = 1,
		padding_left = 2,
		background = {
			border_color = colors.fg_highlight,
		},
	})

	workspaces[workspace_id] = workspace

	-- ワークスペースが切り替わったとき
	workspace:subscribe("aerospace_workspace_change", function(env)
		focused_workspace_id = env.FOCUSED_WORKSPACE
		local is_focused = (focused_workspace_id == workspace_id)
		updateWindows(workspace_id)

		sbar.animate("tanh", 10, function()
			workspace:set({
				icon = { highlight = is_focused },
				label = { highlight = is_focused },
				background = {
					border_width = is_focused and 2 or 0,
				},
			})
		end)
	end)

	-- アクティブアプリが変わったときにもアイコンを更新
	workspace:subscribe("front_app_switched", function(env)
		updateWindows(workspace_id)
	end)

	-- クリックでワークスペース切り替え
	workspace:subscribe("mouse.clicked", function()
		sbar.exec("aerospace workspace " .. workspace_id)
	end)

	-- マウスホバーで強調表示
	workspace:subscribe("mouse.entered", function()
		sbar.animate("tanh", 10, function()
			workspace:set({
				icon = { highlight = true },
				label = { highlight = true },
				background = { border_width = 2 },
			})
		end)
	end)
	workspace:subscribe("mouse.exited", function()
		if workspace_id == focused_workspace_id then
			return
		end
		sbar.animate("tanh", 10, function()
			workspace:set({
				icon = { highlight = false },
				label = { highlight = false },
				background = { border_width = 0 },
			})
		end)
	end)

	-- 初期表示時に中身をチェックして表示／非表示を設定
	updateWindows(workspace_id)
end

-- 最初のフォーカス中ワークスペースを取得して枠をハイライト
sbar.exec("aerospace list-workspaces --focused", function(focused_workspace)
	focused_workspace_id = focused_workspace -- 文字列で返ってくる
	if workspaces[focused_workspace_id] then
		workspaces[focused_workspace_id]:set({
			icon = { highlight = true },
			label = { highlight = true },
			background = { border_width = 3 },
		})
	end
end)

-- トグルボタンをクリックするとワークスペースラベルを表示／非表示
toggle_windows:subscribe("mouse.clicked", function()
	is_show_windows = not is_show_windows
	sbar.animate("tanh", 10, function()
		toggle_windows:set({
			label = {
				string = is_show_windows and icons.chevron.left or icons.chevron.right,
			},
		})
		for _, workspace in ipairs(workspace_list) do
			workspaces[workspace]:set({
				icon = { padding_right = is_show_windows and 8 or 15 },
				label = { width = is_show_windows and "dynamic" or 0 },
			})
		end
	end)
end)
