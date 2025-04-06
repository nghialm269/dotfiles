#!/usr/bin/env bash


get_active_workspace_name() {
    hyprctl -j activeworkspace | jq -r '.name'
}

get_client_address_by_class() {
    hyprctl -j clients | jq -r '.[] | select(.class == "'"$1"'") | .address'
}

get_client_workspace_name() {
    hyprctl -j clients | jq -r '.[] | select(.address == "'"$1"'") | .workspace.name'
}

get_client_focus_history_id() {
    hyprctl -j clients | jq -r '.[] | select(.address == "'"$1"'") | .focusHistoryID'
}

notify() {
    notify-send -u low -i "accessories-notes" "Scratchpad" "$1"
}

if ! [ -x "$(command -v socat)" ]; then
  echo 'Error: socat is not installed.' >&2
  notify 'Error: socat is not installed.'
  exit 1
fi

# https://stackoverflow.com/a/14203146
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "Usage: $0 [OPTIONS] -- [COMMAND]"
            echo "Options:"
            echo "  -c, --class CLASS  Class of the scratchpad client (required)"
            echo "  -h, --help         Show this help message and exit"
            echo "  --                 Separate OPTIONS from the COMMAND to run"
            echo "  COMMAND            Command to start the scratchpad using hyprctl dispatch exec (support rules)"
            echo
            echo "Example: ./scratchpad.sh --class tscratch -- '[float;size 50% 50%;center]' wezterm start --class tscratch"
            exit 0;
            ;;
        -c|--class)
            CLASS="$2"
            shift 2 # past argument & value
            ;;
        --)
	    shift # past --
            CMD="$@"
            shift $#
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
    esac
done

if [ "$CLASS" = "" ]; then
    echo "-c/--class is required."
    exit 1
fi


(
flock -x -n 200 || exit 1

client_addr="$(get_client_address_by_class "$CLASS")"
if [ "$client_addr" = "" ]; then
    coproc SOCAT { socat -t0 -T10 -u UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock -; }
    notify "Launching $CLASS..."
    hyprctl dispatch -- exec "$CMD"
    while read -t 5 -r line; do
        event="${line%%>>*}"
        data="${line#"$event">>}"
        PFS=$IFS
        IFS=','
        # shellcheck disable=SC2086 # splitting is intended
        set -- $data
        IFS=$PFS

        case $event in
            openwindow) 
                WINDOWADDRESS="$1"
                WORKSPACENAME="$2"
                WINDOWCLASS="$3"
                WINDOWTITLE="$4"
                if [ "$WINDOWCLASS" = "$CLASS" ]; then
                    break
                fi
                ;;
        esac
    done <&${SOCAT[0]}
    kill "$SOCAT_PID"
    wait "$SOCAT_PID"
    notify "$CLASS opened!"
else
    client_current_workspace=$(get_client_workspace_name "$client_addr")
    active_workspace=$(get_active_workspace_name)
    focus_id=$(get_client_focus_history_id "$client_addr")

    commands=()
    if [ "$client_current_workspace" != "$active_workspace" ]; then
        commands+=("dispatch movetoworkspacesilent name:$active_workspace,address:$client_addr")
    elif [ "$focus_id" = "0" ]; then
        commands+=("dispatch movetoworkspacesilent special:$CLASS,address:$client_addr")
    fi

    if [ "$focus_id" != "0" ]; then
        commands+=("dispatch focuswindow address:$client_addr")
        commands+=("dispatch alterzorder top,address:$client_addr")
    fi

    command=$(IFS=";" ; echo "${commands[*]}")
    notify "Command: ${command}"


    hyprctl --batch "$command"
fi

) 200>/tmp/.scratchpad.$CLASS.lock
