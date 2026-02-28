local colors = require("colors")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = 35,
	-- color = colors.black,
	color = colors.transparent,
	padding_right = 2,
	padding_left = 2,
})
