#!/bin/bash

# Function to output status
output_status() {
    song=$(mpc current)
    if [ -z "$song" ]; then
        song="Not Playing"
    fi
    date_formatted=$(date "+%a %m/%d %I:%M %P")
    echo "$song | $date_formatted"
}

# Initialize last minute
last_minute=$(date "+%M")

# Start mpc idleloop as a coprocess
coproc mpc_idle { mpc idleloop player; }

# **Output status immediately**
output_status

# Main loop
while true; do
    # Check for mpc events with a timeout of 1 second
    if read -t 1 -u ${mpc_idle[0]} mpc_event; then
        # mpc event occurred (song changed)
        output_status
    fi

    # Check if the minute has changed to update the clock
    current_minute=$(date "+%M")
    if [ "$current_minute" != "$last_minute" ]; then
        last_minute=$current_minute
        output_status
    fi
done

