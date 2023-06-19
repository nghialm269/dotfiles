#!/usr/bin/env bash

case "$1" in
	toggle-mute)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		;;
	change-volume)
		pactl set-sink-volume @DEFAULT_SINK@ $2%
		;;
	*)
		;;
esac

app_name="volume"
mute="$(pactl get-sink-mute @DEFAULT_SINK@ | grep -hPo 'Mute: \K\w+')"
vol="$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\K\d+(?=%)' | head -n 1)"

icon_muted="audio-volume-muted"
icon_normal="audio-volume-high"

case "$mute" in
    yes)
        title="Muted"
        icon="$icon_muted"
        ;;
    *)
        title="Volume"
        icon="$icon_normal"
        ;;
esac


# use hint int:value:<val> to show progress in mako
notify-send -u low -i "$icon" -a "$app_name" -h int:value:$vol -h int:transient:1 -h string:x-canonical-private-synchronous:volume "$title: $vol%"
