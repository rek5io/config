#!/bin/bash

CHOICE=$(echo -e "exit\nreboot\nshutdown\nsuspend" | wofi --show dmenu --prompt "Power Menu" --style ~/.config/wofi/powermenu_style.css)

case "$CHOICE" in
exit)
    niri msg action quit
    ;;
reboot)
    systemctl reboot
    ;;
shutdown)
    systemctl poweroff
    ;;
suspend)
    systemctl suspend
    ;;
esac
