#!/usr/bin/env bash


notify() {
	notify-send -u low -i "yazi" -h int:transient:1 -h string:x-canonical-private-synchronous:open-with-yazi "Yazi" "$1"
}

# https://stackoverflow.com/a/14203146
POSITIONAL_ARGS=()
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            echo "Usage: $0 [OPTIONS] [FILE_PATH]"
            echo "Options:"
            echo "  -c, --class     CLASS      Class of the terminal client (default: ghostty.filemanager)"
            echo "      --client-id CLIENT_ID  Yazi client id (default: 0)"
            echo "  -h, --help                 Show this help message and exit"
            echo "  FILE_PATH                  Filepath to reveal in yazi"
            echo
            echo "Example: ./open-with-yazi.sh --class ghostty.filemanager --client-id 0 ~/Downloads"
            exit 0;
            ;;
        -c|--class)
            CLASS="$2"
            shift 2 # past argument & value
            ;;
        --client-id)
            case $2 in
                ''|*[!0-9]*) 
                    echo "CLIENT_ID must be a number"
                    exit 1;
                    ;;
            esac
            CLIENT_ID="$2"
            shift 2 # past argument & value
            ;;
        -*|--*)
            echo "Unknown option $1"
            exit 1
            ;;
        *)
            POSITIONAL_ARGS+=("$1") # save positional arg
            shift # past argument
            ;;
    esac
done
set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters



FILE_PATH=${1#file://}
# notify "$1"
# echo "${1} | ${FILE_PATH}" >> ~/open-with-yazi.log

CLASS="${CLASS:-ghostty.filemanager}"
CLIENT_ID="${CLIENT_ID:-0}"

get_client_address_by_class() {
    hyprctl -j clients | jq -r '.[] | select(.class == "'"$1"'") | .address'
}

address="$(get_client_address_by_class "$CLASS")"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
${SCRIPT_DIR}/scratchpad.sh --class "${CLASS}" -- '[float;size 750 425;center]' uwsm app -u "${class}.scope" -- ghostty "--class=${CLASS}" -e yazi --client-id "$CLIENT_ID"

if [ "$FILE_PATH" = "" ]; then
    exit 0;
fi

if [ "$address" != "" ]; then
    ya emit-to "$CLIENT_ID" tab_create
else
    sleep 0.5 # wait for yazi to initialize
fi

if [ -d "$FILE_PATH" ]; then
    ya emit-to "$CLIENT_ID" cd "$FILE_PATH"
    notify "Opened directory $FILE_PATH!"
elif [ -f "$FILE_PATH" ]; then
    ya emit-to "$CLIENT_ID" reveal "$FILE_PATH"
    notify "Reveal file $FILE_PATH!"
else
    notify "$FILE_PATH is not a file or directory."
    exit 1;
fi

