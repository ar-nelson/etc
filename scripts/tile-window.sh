#!/bin/bash
set -euo pipefail

# Windows-style window tiling script.
# Depends on xdotool and wmctrl.
# Takes one argument: 'up', 'down', 'left', or 'right'.

WINDOW="$(xdotool getactivewindow)"
wmctrl -ir $WINDOW -b add,maximized_vert,maximized_horz
read -r X Y W H <<< $(xdotool getwindowgeometry $WINDOW | awk -F '[ ,x]+' 'NR > 1 { printf("%s %s ", $3, $4) }; NR == 3 { print "" }')

case $1 in
  left)
    wmctrl -ir $WINDOW -b remove,maximized_vert,maximized_horz
    xdotool windowmove $WINDOW $X $Y
    xdotool windowsize $WINDOW $(($W / 2)) $H
    wmctrl -ir $WINDOW -b add,maximized_vert
    ;;
  right)
    wmctrl -ir $WINDOW -b remove,maximized_vert,maximized_horz
    xdotool windowmove $WINDOW $((($W / 2) + $X)) $Y
    xdotool windowsize $WINDOW $(($W / 2)) $H
    wmctrl -ir $WINDOW -b add,maximized_vert
    ;;
  up)
    wmctrl -ir $WINDOW -b remove,maximized_vert,maximized_horz
    xdotool windowmove $WINDOW $X $Y
    xdotool windowsize $WINDOW $W $(($H / 2))
    wmctrl -ir $WINDOW -b add,maximized_horz
    ;;
  down)
    wmctrl -ir $WINDOW -b remove,maximized_vert,maximized_horz
    xdotool windowmove $WINDOW $X $((($H / 2) + $Y))
    xdotool windowsize $WINDOW $W $(($H / 2))
    wmctrl -ir $WINDOW -b add,maximized_horz
    ;;
esac
