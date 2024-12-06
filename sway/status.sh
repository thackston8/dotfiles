#!/bin/bash

# Function to output status
output_status() {
    date_formatted=$(date "+%a %m/%d %I:%M %P")
    echo "$date_formatted"
}

# Initialize last minute
last_minute=$(date "+%M")

# **Output status immediately**
output_status

# Main loop
while true; do
    # Check if the minute has changed to update the clock
    current_minute=$(date "+%M")
    if [ "$current_minute" != "$last_minute" ]; then
        last_minute=$current_minute
        output_status
    fi
    sleep 1
done

