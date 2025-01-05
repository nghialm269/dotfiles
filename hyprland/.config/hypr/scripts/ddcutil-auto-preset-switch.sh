#!/usr/bin/env bash



# * Install ddcutil:
#     sudo pacman -S ddcutil
# * Load i2c-dev module at boot:
#     echo 'i2c-dev' | sudo tee /etc/modules-load.d/i2c-dev.conf
# * Add user to i2c group (to have permission for using the /dev/i2c-* devices):
#     sudo gpasswd -a <username> i2c
# * Reboot.

# kill self
for pid in $(pgrep -f ${BASH_SOURCE[0]}); do
    if [ $pid != $$ ]; then
        kill $pid
    fi 
done

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

get_monitor_id() {
	hyprctl -j monitors | jq -r '.[] | select(.model=="'"$MONITOR_MODEL"'").id'
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

get_preferred_mode_for_class() {
	case "$1" in
		mpv)
			mode="03"
			;;
		gamescope|steam_app_*)
			mode="05"
			;;
		*)
			mode="00"
			;;
	esac

	echo "$mode"
}


notify() {
	notify-send -u low -i "computer" -h int:transient:1 -h string:x-canonical-private-synchronous:display-preset "$1" "$2"
}

prev_display_mode=""
display_mode=""

socat -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
	event="${line%%>>*}"

	if [ "$event" != "activewindowv2" ] && [ "$event" != "fullscreen" ]; then
		continue
	fi

	monitor_id="$(get_monitor_id)"
	if [ "$monitor_id" = "" ]; then
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


	clients="$(hyprctl -j clients)" 
	monitor_clients="$(echo "$clients" | jq -r '[.[] | select(.monitor=='"$monitor_id"')]')"
	focused_client="$(echo "$monitor_clients" | jq -r '.[] | select(.focusHistoryID==0)')"
	fullscreen="$(echo "$focused_client" | jq -r '.fullscreen')"
	class="$(echo "$focused_client" | jq -r '.class')"

	if [ "$fullscreen" = "2" ]; then
		preferred_mode="$(get_preferred_mode_for_class "$class")"
	else
		preferred_mode="00"
	fi

	if [ "$preferred_mode" = "$display_mode" ]; then
		continue
	fi

	prev_display_mode="$display_mode"
	display_mode="$(set_display_mode "$prev_display_mode" "$preferred_mode")"
done
