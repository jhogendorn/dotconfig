local hyper = {"ctrl", "alt", "cmd"}

hs.loadSpoon("MiroWindowsManager")

hs.window.animationDuration = 0.3
spoon.MiroWindowsManager:bindHotkeys({
  up = {hyper, "up"},
  right = {hyper, "right"},
  down = {hyper, "down"},
  left = {hyper, "left"},
  fullscreen = {hyper, "f"}
})

-- center focused x and y
hs.hotkey.bind(hyper, 'c', function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

	local x = f

	x.x = ((max.w - f.w) / 2) + max.x
	x.y = ((max.h - f.h) / 2) + max.y
	win:setFrame(x)
end)

-- center focused y
hs.hotkey.bind(hyper, 'x', function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

	local x = f

	x.y = ((max.h - f.h) / 2) + max.y
	win:setFrame(x)
end)

-- center focused x
hs.hotkey.bind(hyper, 'v', function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

	local x = f

	x.x = ((max.w - f.w) / 2) + max.x
	win:setFrame(x)
end)

-- maximize vertically
hs.hotkey.bind(hyper, '[', function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

	local x = f

	x.y = max.y
	x.h = max.h
	win:setFrame(x)
end)

-- maximize horizontally
hs.hotkey.bind(hyper, ']', function()
	local win = hs.window.focusedWindow()
	local f = win:frame()
	local max = win:screen():frame()

	local x = f

	x.x = max.x
	x.w = max.w
	win:setFrame(x)
end)
