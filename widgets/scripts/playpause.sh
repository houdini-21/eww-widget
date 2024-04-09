#!/bin/bash
status=`playerctl status --player spotify`

if [ "$status" = "Playing" ]; then
    #echo "widgets/icons/pause.png"
    echo ''
elif [ "$status" = "Paused" ]; then
    #echo "widgets/icons/play.png"
    echo ''
fi