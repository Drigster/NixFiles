#!/bin/bash
CURRENT_LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')
if [ "$CURRENT_LAYOUT" = "ru" ]; then
    setxkbmap -layout "us,de" -option "grp:alt_shift_toggle"
else
    setxkbmap -layout ru
fi
