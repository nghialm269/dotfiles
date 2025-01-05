#!/usr/bin/env bash

case "$1" in
	toggle-mute)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
		;;
	change-volume)
		wpctl set-volume @DEFAULT_AUDIO_SINK@ $2
		;;
	*)
		;;
esac

volume_info=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
mute="$(echo "$volume_info" | grep -o 'MUTED')"
vol="$(echo "$volume_info" | awk '{printf "%s\n", $2*100}')"

node_name="$(wpctl inspect @DEFAULT_AUDIO_SINK@ | grep -oP 'node.nick = "\K.+(?=")')"

app_name="volume"

icon_muted="audio-volume-muted"
icon_low="audio-volume-low"
icon_medium="audio-volume-medium"
icon_high="audio-volume-high"

case "$mute" in
    MUTED)
        title="Muted"
        icon="$icon_muted"
        ;;
    *)
        title="Volume"
        if [ $vol -le 33 ]; then
            icon="$icon_low"
        elif [ $vol -le 66 ]; then
            icon="$icon_medium"
        else
            icon="$icon_high"
        fi
        ;;
esac


# use hint int:value:<val> to show progress in mako
notify-send -u low -i "$icon" -a "$app_name" -h int:value:$vol -h int:transient:1 -h string:x-canonical-private-synchronous:volume "$node_name" "$title: $vol%"
