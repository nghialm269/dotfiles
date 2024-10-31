swayidle -w \
    timeout 300 'loginctl lock-session' \
    timeout 320 'hyprctl dispatch dpms off' \
    resume 'hyprctl dispatch dpms on' \
    timeout 20 'if pgrep swaylock; then hyprctl "dispatch dpms off"; fi' \
    resume 'if pgrep swaylock; then hyprctl "dispatch dpms on"; fi' \
    before-sleep 'loginctl lock-session' \
    lock 'swaylock --daemonize --ignore-empty-password --show-failed-attempts --color 000000'
