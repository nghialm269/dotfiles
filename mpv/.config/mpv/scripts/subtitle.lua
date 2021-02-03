local utils = require 'mp.utils'

function subtitle_xclip()
	local command = string.format('echo -n %q | xclip -selection clipboard -f  > /dev/null 2>&1', mp.get_property("sub-text"))
	utils.subprocess_detached({ args = {'sh', '-c', command}})
end

mp.add_key_binding("s", "subtitle-xclip", subtitle_xclip);
