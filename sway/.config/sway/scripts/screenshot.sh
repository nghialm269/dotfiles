#!/usr/bin/env bash

case "$1" in
	region)
		grim -g "$(slurp -d)" - | swappy -f -
		;;
	window)
		grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)" - | swappy -f -
		;;
	*)
		grim -o "$(swaymsg --type get_outputs --raw | jq --raw-output '.[] | select(.focused) | .name')" - | swappy -f -
		;;
esac

