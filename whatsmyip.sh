#!/bin/bash

alias whatismyip="whatsmyip" # used when in .bashrc

# Function to create rainbow @ line with colors pulsing from inside to outside
function rainbow_at_line () {
    # Rainbow colors (ANSI color codes): Red, Orange, Yellow, Green, Cyan, Blue, Magenta
    local colors=(196 208 226 46 51 21 201)
    local line=""
    local total_chars=28
    local center=$((total_chars / 2))
    
    # Build the line with colors pulsing from center outward
    for ((i=0; i<total_chars; i++)); do
        # Calculate distance from center
        local dist=$((i < center ? center - i - 1 : i - center))
        # Map distance to color index (cycle through rainbow)
        local color_idx=$((dist % ${#colors[@]}))
        local color=${colors[$color_idx]}
        # Add colored @ to line
        line+="\e[38;5;${color}m@"
    done
    line+="\e[0m"
    echo -e "$line"
}

function whatsmyip () {
    echo ""
    rainbow_at_line
    # Internal IP Lookup.
    if command -v ip &> /dev/null; then
        echo -n -e "\e[32mInternal IP: \e[0m"
        ip addr show eth0 | grep "inet " | awk '{print $2}' | cut -d/ -f1
    else
        echo -n "Internal IP: "
        ifconfig eth0 | grep "inet " | awk '{print $2}'
    fi

    # External IP Lookup
    echo -n -e "\e[32mExternal IP: \e[0m"
    curl -4 ifconfig.me
    echo ""
    rainbow_at_line

}

whatsmyip # remove if in .basrc
