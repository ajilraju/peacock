#!/bin/bash

# command usage option and args display.
function usage() {
    echo -e "watchdog.sh is a logging tool.\n"
    echo -e "Usage:\n"
    echo -e "\twatchdog.sh command [arguments]\n"
    echo -e "The command are:\n"
    echo -e "\tunit        Units running on system.\n
        process     Process ID uses for filtering.\n
        uid         User ID uses for filtering.\n
        path        Path location of the program.\n
        kernel      Display the kernel messages.\n
        prty        Message priority at verbose level.\n"
}

# command option selector to further process.
function opt_selector() {
    case "$1" in 
        "unit")
            #
            ;;
        "process")
            #
            ;;
        "uid")
            #
            ;;
        "path")
            #
            ;;
        "kernel")
            #
            ;;
        "prty")
            #
            ;;
        *)
            echo -e "Usage: $0 (unit|process|uid|path|kernel|prty)"
            ;;
esac
}

# initialize the environment for the program
function env_setup() {

    local base_dir="/tmp/peacock/"
    local unit_file="/tmp/peacock/unit-service.txt"

    if [ -d $base_dir ]; then
        
    else
        mkdir 
    fi
    
    if [ -e $unit_file ]; then
        
    else
        touch /tmp/peacock/unit-service.txt
    fi
    service --status-all | more | awk '{print $4}' >> /tmp/peacock/unit-service.txt
}

# environment setup func call
env_setup

# to check wether command with no arguments.
if [ -z "$1" ]; then
    usage
else 
    opt_selector $1
fi
