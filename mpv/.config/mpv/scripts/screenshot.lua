local utils = require 'mp.utils'

local f = "/tmp/mpv.png"
function screenshot_xclip()
	mp.commandv("osd-msg", "screenshot-to-file", f, "subtitles")

	local command = string.format("xclip -selection clipboard -f -target image/png -i %q > /dev/null 2>&1", f)
	utils.subprocess({ args = {'sh', '-c', command}})
	utils.subprocess_detached({ args = {'rm', '-f', f}})
end

mp.add_key_binding("S", "screenshot-xclip", screenshot_xclip);
