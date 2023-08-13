#!/usr/bin/env bash


# * Install ddcutil:
#     sudo pacman -S ddcutil
# * Load i2c-dev module at boot:
#     echo 'i2c-dev' | sudo tee /etc/modules-load.d/i2c-dev.conf
# * Add user to i2c group (to have permission for using the /dev/i2c-* devices):
#     sudo gpasswd -a <username> i2c
# * Reboot.

MONITOR_MODEL="DELL U2723QE"

get_display_mode() {
	ddcutil --model "$MONITOR_MODEL" getvcp dc | grep -oP 'sl=0x\K\w+(?=\))'
}

set_display_mode() {
	local prev_mode="$(get_mode_name $1)"
	local mode="$(get_mode_name $2)"
	notify "Preset Modes:" "Changing preset from $prev_mode to $mode..."

	ddcutil --model "$MONITOR_MODEL" setvcp dc "$2"

	local display_mode=$(get_display_mode)
	notify "New Preset Modes:" "$(get_mode_name $display_mode)"

	echo "$display_mode"
}

get_monitor_name() {
	swaymsg -t get_outputs | jq -r '.[]|  select(.model=="'"$MONITOR_MODEL"'").name'
}

get_mode_name() {
	case "$1" in
		00)
			mode="Standard"
			;;
		03)
			mode="Movie"
			;;
		05)
			mode="Game"
			;;
		*)
			mode="Unknown"
			;;
	esac

	echo "$mode"
}


notify() {
	notify-send -u low -i "system-config-display" -h int:transient:1 -h string:x-canonical-private-synchronous:display-preset "$1" "$2"
}

prev_display_mode=""
display_mode=""

swaymsg -t subscribe -m '[ "window" ]' | while read line ; do 
	change="$(echo "$line" | jq -r '.change')" 
	if [ "$change" != "focus" ] && [ "$change" != "fullscreen_mode" ]; then
		continue
	fi

	monitor_name="$(get_monitor_name)"
	if [ "$monitor_name" = "" ]; then
		prev_display_mode=""
		display_mode=""
		continue
	fi

	if [ "$display_mode" = "" ]; then
		prev_display_mode="$(get_display_mode)"
		display_mode="$prev_display_mode"

		if [ "$display_mode" = "" ]; then
			notify "Preset Modes:" "Could not get preset modes. Exiting ..."
			exit 1;
		fi
	fi


	sway_tree="$(swaymsg -t get_tree)" 
	output="$(echo "$sway_tree" | jq -r '.nodes[] | select(.name=="'"$monitor_name"'")')"
	focused_window="$(echo "$output" | jq -r '.. | select(.type?) | select(.focused==true)')"
	fullscreen_mode="$(echo "$focused_window" | jq -r '.fullscreen_mode')"
	app_id="$(echo "$focused_window" | jq -r '.app_id')"

	if [ "$fullscreen_mode" = "1" ] && [ "$app_id" = "mpv" ]; then
		if [ "$display_mode" = "03" ]; then
			continue
		fi

		prev_display_mode="$display_mode"
		display_mode="$(set_display_mode "$prev_display_mode" "03")"
	elif [ "$display_mode" = "03" ]; then
		prev_display_mode="$display_mode"
		display_mode="$(set_display_mode "$prev_display_mode" "00")"
	fi
done
