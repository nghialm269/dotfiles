#!/usr/bin/env bash

case "$1" in
	region)
		grim -g "$(slurp -d -c '#b4befeff')" - | satty --filename - --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
		;;
	window)
		active_workspace_id=$(hyprctl -j monitors | jq -r '.[] | select(.focused) | .activeWorkspace.id')
		
		
		grim -g "$(hyprctl -j clients | jq -r '.[] | select(.workspace.id == '$active_workspace_id') | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"' | slurp -c '#b4befeff')" - | satty --filename - --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png

		;;
	monitor)
		grim -g "$(slurp -o -r -c '#b4befeff')" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
		;;
	*) # focused monitor
		grim -o "$(hyprctl -j monitors | jq --raw-output '.[] | select(.focused) | .name')" - | satty --filename - --fullscreen --output-filename ~/Pictures/Screenshots/satty-$(date '+%Y%m%d-%H:%M:%S').png
esac

