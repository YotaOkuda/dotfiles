local is_dark_mode = require("is_dark_mode") == "dark"
-- local bit = require("bit")

local colors = {}
local with_alpha = function(color, alpha)
	if alpha > 1.0 or alpha < 0.0 then
		return color
	end
	return (color & 0x00ffffff) | (math.floor(alpha * 255.0) << 24)
	-- local base = bit.band(color, 0x00ffffff)
	-- local a = bit.lshift(math.floor(alpha * 255.0), 24)
	-- return bit.bor(base, a)
end
colors.with_alpha = with_alpha

local theme = {
	-- Base16 Default Dark Theme
	dark = 0xff181818,
	dark_grey = 0xff282828,
	grey = 0xff383838,
	light_grey = 0xff585858,
	dark_silver = 0xffb8b8b8,
	silver = 0xffd8d8d8,
	light_silver = 0xffe8e8e8,
	light = 0xfff8f8f8,
	red = 0xffab4642,
	orange = 0xffdc9656,
	yellow = 0xfff7ca88,
	green = 0xffa1b56c,
	cyan = 0xff86c1b9,
	blue = 0xff7cafc2,
	magenta = 0xffba8baf,
	brown = 0xffa16946,

	-- Special colors
	transparent = 0x00000000,
	black = 0xff000000,
	white = 0xffffffff,
	github_blue = 0xff4170ae,

	background = 0xff24283b,

	-- Tokyo Night
	tn_red = 0xfff7768e,
	tn_orange = 0xffff9e64,
	tn_yellow = 0xffe0af68,
	tn_green = 0xff9ece6a,
	tn_light_green = 0xff73daca,
	tn_white_green = 0xffb4f9f8,
	tn_cyan = 0xff2ac3de,
	tn_skyblue = 0xff7dcfff,
	tn_blue = 0xff7aa2f7,
	tn_magenta = 0xffbb9af7,
	tn_white1 = 0xffc0caf5,
	tn_white2 = 0xffa9b1d6,
	tn_white3 = 0xff9aa6ce,
	tn_black1 = 0xff565f89,
	tn_black2 = 0xff414868,
	tn_black3 = 0xff24283b,
	tn_black4 = 0xff1a1b26,

	tn_dark_red = 0xff8c4351,
	tn_brown = 0xff965027,
	tn_dark_yellow = 0xff8f5e15,
	tn_olive = 0xff634f30,
	tn_dark_green = 0xff385f0d,
	tn_teal = 0xff33635c,
	tn_aqua = 0xff006c86,
	tn_navy = 0xff0f4b6e,
	tn_deep_blue = 0xff2959aa,
	tn_purple = 0xff5a3e8e,
	tn_dark_gray = 0xff343b58,
	tn_gray = 0xff40434f,

	cmap_1 = 0xfff7768e,
	cmap_2 = 0xffff4d27,
	cmap_3 = 0xffff8e4a,
	cmap_4 = 0xfff0c36c,
	cmap_5 = 0xffc2e98b,
	cmap_6 = 0xff94fca8,
	cmap_7 = 0xff66fbc1,
	cmap_8 = 0xff38e6d7,
	cmap_9 = 0xff0abfe8,
	cmap_10 = 0xff2388f4,

	accent1 = 0xff00ffff,
	accent2 = 0xff0DB9D7,
	accent3 = 0xc0ff00f2,
	accent4 = 0xff0080ff,

	soft_red = 0xff8c4351,
	soft_white = 0xffeee8d5,
}

for k, v in pairs(theme) do
	colors[k] = v
end

if is_dark_mode then
	colors.fg = theme.silver
	colors.fg_highlight = theme.blue
	colors.fg_secondary = theme.silver
	colors.bg = theme.black
	colors.border = theme.dark
	colors.active = theme.white
else
	colors.fg = theme.dark
	colors.fg_highlight = theme.github_blue
	colors.fg_secondary = theme.light_grey
	colors.bg = theme.light
	colors.border = theme.silver
	colors.active = theme.white
end

return colors
