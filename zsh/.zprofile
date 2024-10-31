if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
	# exec ~/.config/sway/scripts/sway-run.sh
	# exec startx
	exec Hyprland
fi
