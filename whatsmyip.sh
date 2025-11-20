#!/bin/bash

alias whatismyip="whatsmyip" # used when in .bashrc
function whatsmyip () {
    echo -e "\n\e[33m@@@@@@@@@@@@@@@@@@@@@@@@@@@@\e[0m"
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
    echo -e "\n\e[33m@@@@@@@@@@@@@@@@@@@@@@@@@@@@\e[0m"
    
}

whatsmyip # REMOVE IF USING IN .BASHRC
