#!/bin/bash

# Function to check shuffle status and display icon
song=$(mpc current)
if [ -z "$song" ]; then
    song="Not Playing"
fi
date_formatted=$(date "+%m/%d %X")
#next_shift=$(cat ~/Documents/myschedule.ics | next_event)
# Print output
#echo "Next Shift: $next_shift | $song | $date_formatted"
echo "$song | $date_formatted"

