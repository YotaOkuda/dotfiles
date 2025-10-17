local icons = require("icons")
local colors = require("colors")
local settings = require("settings")
local app_icons = require("helpers.icon_map")

--------------------------------------------------------------------------------
-- ワークスペース名を文字列の配列で定義（数字1〜9と大文字A〜Zのうち利用したい文字）
--------------------------------------------------------------------------------
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

local colors_spaces = {
	["1"] = colors.cmap_1,
	["2"] = colors.cmap_2,
	["3"] = colors.cmap_3,
	["4"] = colors.cmap_4,
	["5"] = colors.cmap_5,
	["6"] = colors.cmap_6,
	["7"] = colors.cmap_7,
	["8"] = colors.cmap_8,
	["9"] = colors.cmap_9,
	["A"] = colors.cmap_10,
	["B"] = colors.cmap_1,
	["C"] = colors.cmap_2,
	["D"] = colors.cmap_3,
	["E"] = colors.cmap_4,
	["F"] = colors.cmap_5,
	["G"] = colors.cmap_6,
	["I"] = colors.cmap_7,
	["M"] = colors.cmap_8,
	["N"] = colors.cmap_9,
	["O"] = colors.cmap_10,
	["P"] = colors.cmap_1,
	["Q"] = colors.cmap_2,
	["R"] = colors.cmap_3,
	["S"] = colors.cmap_4,
	["T"] = colors.cmap_5,
	["U"] = colors.cmap_6,
	["V"] = colors.cmap_7,
	["W"] = colors.cmap_8,
	["X"] = colors.cmap_9,
	["Y"] = colors.cmap_10,
	["Z"] = colors.cmap_1,
}

--------------------------------------------------------------------------------
-- 内部変数
--------------------------------------------------------------------------------
local focused_workspace_id = nil
local is_show_windows = true
-- workspaces["1"] = 対応する sbar.item オブジェクト
local workspaces = {}

--------------------------------------------------------------------------------
-- トグルボタン：ワークスペースラベル（ウィンドウアイコン）の表示・非表示を制御
--------------------------------------------------------------------------------
local toggle_windows = sbar.add("item", {
	icon = {
		string = icons.aerospace,
		padding_right = 8,
		padding_left = 6, -- サバイバルモードレイアウト用
	},
	label = {
		width = 0,
		y_offset = 0.5,
		padding_right = 15,
	},
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

toggle_windows:subscribe("aerospace_mode_change", function(env)
	local mode = env.MODE
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

--------------------------------------------------------------------------------
-- ワークスペースごとに開いているウィンドウのアイコンを更新する関数
--------------------------------------------------------------------------------
local function updateWindows(workspace_id)
	-- "aerospace list-windows --workspace <ID> --format '%{app-name}' --json"
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

				-- 空かつフォーカス外なら非表示にする
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

--------------------------------------------------------------------------------
-- ここからがメインループ：各ワークスペースアイテムを生成して購読登録
--------------------------------------------------------------------------------
for _, workspace_id in ipairs(workspace_list) do
	--------------------------------------------------------------------------
	-- ① sbar.add("item", "workspace.<ID>", {...})
	--    というふうに、名前を明示的につける
	--------------------------------------------------------------------------
	local item_name = "workspace." .. workspace_id
	local workspace = sbar.add("item", item_name, {
		icon = {
			font = { family = settings.font.numbers },
			string = workspace_id, -- "1" や "A" などの文字列
			padding_left = 5,
			padding_right = 0,
			color = colors_spaces[workspace_id],
			highlight_color = colors.black,
			y_offset = -1,
		},
		label = {
			padding_right = 8,
			color = colors_spaces[workspace_id], -- ★Workspaceごとの番号文字色
			highlight_color = colors.black,
			font = "sketchybar-app-font-bg:Regular:18.0",
			y_offset = -2,
		},
		padding_right = 0,
		padding_left = 0,
		background = {
			color = colors.transparent,
		},
	})

	-- workspaces["1"] = sbar.item オブジェクト
	workspaces[workspace_id] = workspace

	--------------------------------------------------------------------------
	-- ワークスペースが切り替わったとき
	--------------------------------------------------------------------------
	workspace:subscribe("aerospace_workspace_change", function(env)
		focused_workspace_id = env.FOCUSED_WORKSPACE -- 文字列のまま
		local is_focused = (focused_workspace_id == workspace_id)
		updateWindows(workspace_id)

		sbar.animate("tanh", 10, function()
			workspace:set({
				icon = { highlight = is_focused },
				label = { highlight = is_focused },
				background = {
					color = (is_focused and colors_spaces[workspace_id]) or colors.transparent,
					height = is_focused and 22 or 0,
					corner_radius = is_focused and 6 or 0,
					-- padding_right = is_focused and -15 or 0,
				},
			})
		end)
	end)

	--------------------------------------------------------------------------
	-- アクティブアプリが変わったときにもアイコンを更新
	--------------------------------------------------------------------------
	workspace:subscribe("front_app_switched", function(_env)
		updateWindows(workspace_id)
	end)

	--------------------------------------------------------------------------
	-- クリックでワークスペース切り替え
	--------------------------------------------------------------------------
	workspace:subscribe("mouse.clicked", function()
		sbar.exec("aerospace workspace " .. workspace_id)
	end)

	--------------------------------------------------------------------------
	-- マウスホバーでハイライト
	--------------------------------------------------------------------------
	workspace:subscribe("mouse.entered", function()
		sbar.animate("tanh", 10, function()
			workspace:set({
				icon = { highlight = true },
				label = { highlight = true },
				background = {
					color = colors_spaces[workspace_id],
					height = 22,
					corner_radius = 6,
				},
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
				background = {
					color = colors.transparent,
					border_width = 0,
				},
			})
		end)
	end)

	--------------------------------------------------------------------------
	-- 初期表示時に開いているウィンドウをチェックして描画／非描画を決定
	--------------------------------------------------------------------------
	updateWindows(workspace_id)
end

--------------------------------------------------------------------------------
-- “最初にフォーカス中だったワークスペース” だけ枠をハイライトしておく
--------------------------------------------------------------------------------
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

--------------------------------------------------------------------------------
-- トグルボタンをクリックするとワークスペースラベルを表示／非表示
--------------------------------------------------------------------------------
toggle_windows:subscribe("mouse.clicked", function()
	is_show_windows = not is_show_windows
	sbar.animate("tanh", 10, function()
		toggle_windows:set({
			label = {
				string = is_show_windows and icons.chevron.left or icons.chevron.right,
			},
		})
		for _, workspace_id in ipairs(workspace_list) do
			workspaces[workspace_id]:set({
				icon = { padding_right = is_show_windows and 8 or 15 },
				label = { width = is_show_windows and "dynamic" or 0 },
			})
		end
	end)
end)

--------------------------------------------------------------------------------
-- ★ここが新規追加部分★
-- 「workspace_list に対応するすべてのアイテム」を同じ一つの bracket で包み、
-- 背景をまとめて描画する
--------------------------------------------------------------------------------
local bracket_names = {}
for _, id in ipairs(workspace_list) do
	-- workspaces[id] は sbar.item オブジェクトなので .name で名前を取得できる
	table.insert(bracket_names, workspaces[id].name)
end

sbar.add("bracket", bracket_names, {
	background = {
		color = colors.background,
		border_color = colors.accent3,
		border_width = 2,
		corner_radius = 6,
		-- height を指定したい場合はここで行えます:
		-- height = 24,
	},
})
