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
icon_low="audio-volume-low"
icon_medium="audio-volume-medium"
icon_high="audio-volume-high"

case "$mute" in
    yes)
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
notify-send -u low -i "$icon" -a "$app_name" -h int:value:$vol -h int:transient:1 -h string:x-canonical-private-synchronous:volume "$title: $vol%"
