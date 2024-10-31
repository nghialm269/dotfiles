#!/usr/bin/env bash

MONITOR_MODEL="DELL U2723QE"

get_input_source() {
	ddcutil --model "$MONITOR_MODEL" getvcp 60 | grep -oP 'sl=\K\w+(?=\))'
}

set_input_source() {
	ddcutil --model "$MONITOR_MODEL" setvcp 60 $1
}

notify() {
	notify-send -u low -i "system-config-display" -h int:transient:1 -h string:x-canonical-private-synchronous:display-preset "$1" "$2"
}

declare -A input_source_to_value=( 
	["USB-C"]="0x1b"
	["DisplayPort"]="0x0f"
	["HDMI"]="0x11"
)

# echo "${input_source_to_value[@]}"
# echo "${!input_source_to_value[@]}"

selected=$(for input in "${!input_source_to_value[@]}"; do echo "$input"; done | anyrun --plugins libstdin.so --hide-plugin-info true)

if [ "$selected" = "" ]; then
	exit
fi

value="${input_source_to_value[$selected]}"
current="$(get_input_source)"

if [ "$value" = "$current" ]; then
	notify "Input Source" "Selected input source is the same as current input source."
	exit
fi

set_input_source "$value"

