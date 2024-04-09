#!/bin/bash

calendar() {
LOCK_FILE="$HOME/.cache/eww-calendar.lock"
EWW_BIN="eww"

run() {
    ${EWW_BIN} open calendar
}

# Open widgets
if [[ ! -f "$LOCK_FILE" ]]; then
    # ${EWW_BIN} close calendar
    touch "$LOCK_FILE"
    run && echo "ok good!"
else
    ${EWW_BIN} close calendar
    rm "$LOCK_FILE" && echo "closed"
fi
}


system() {
LOCK_FILE_MEM="$HOME/.cache/eww-system.lock"
EWW_BIN="eww"

run() {
    ${EWW_BIN} open system 
}

# Open widgets
if [[ ! -f "$LOCK_FILE_MEM" ]]; then
    ${EWW_BIN} close calendar music_win audio_ctl
    touch "$LOCK_FILE_MEM"
    run && echo "ok good!"
else
    ${EWW_BIN} close system 
    rm "$LOCK_FILE_MEM" && echo "closed"
fi
}


music() {
LOCK_FILE_SONG="$HOME/.cache/eww-song.lock"
EWW_BIN="eww"

run() {
    ${EWW_BIN} open player 
}

# Open widgets
if [[ ! -f "$LOCK_FILE_SONG" ]]; then
    # ${EWW_BIN} close player
    touch "$LOCK_FILE_SONG"
    run && echo "ok good!"
else
    ${EWW_BIN} close player
    rm "$LOCK_FILE_SONG" && echo "closed"
fi
}



audio() {
LOCK_FILE_AUDIO="$HOME/.cache/eww-audio.lock"
EWW_BIN="eww"

run() {
    ${EWW_BIN} open audio_ctl 
}

# Open widgets
if [[ ! -f "$LOCK_FILE_AUDIO" ]]; then
    ${EWW_BIN} close system calendar music
    touch "$LOCK_FILE_AUDIO"
    run && echo "ok good!"
else
    ${EWW_BIN} close audio_ctl
    rm "$LOCK_FILE_AUDIO" && echo "closed"
fi
}


if [ "$1" = "calendar" ]; then
calendar
elif [ "$1" = "system" ]; then
system
elif [ "$1" = "music" ]; then
music
elif [ "$1" = "audio" ]; then
audio
fi
