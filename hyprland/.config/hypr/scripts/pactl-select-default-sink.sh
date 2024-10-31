#!/usr/bin/env bash

MONITOR_MODEL="DELL U2723QE"

get_default_sink_name() {
	pactl --format=json get-default-sink
}

set_default_sink() {
	pactl set-default-sink $1
}

notify() {
	notify-send -u low -i "system-config-display" -h int:transient:1 -h string:x-canonical-private-synchronous:display-preset "$1" "$2"
}

declare -A sink_desc_to_name

default_sink_name=$(get_default_sink_name)

while read sink; do
	desc="$(echo "$sink" | jq -r '.description')"
	name="$(echo "$sink" | jq -r '.name')"

	if [ "$name" = "$default_sink_name" ]; then
		continue
	fi
	sink_desc_to_name["$desc"]="$name"
done < <(pactl --format=json list sinks | jq --compact-output '.[] | {name, description}') # avoid subshell, otherwise the associative array won't be updated

# echo "Key: ${!sink_desc_to_name[@]}"
# echo "Value: ${sink_desc_to_name[@]}"

selected=$(for key in "${!sink_desc_to_name[@]}"; do echo "$key"; done | anyrun --plugins libstdin.so --hide-plugin-info true)

if [ "$selected" = "" ]; then
	exit
fi

value="${sink_desc_to_name[$selected]}"

set_default_sink "$value"
