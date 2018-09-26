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
            echo "Usage: $0 (unit|process|uid|path|kernel|prty)"
            ;;
esac
        
}
# to check wether command with no arguments.
if [ -z "$1" ]; then
    usage
else 
    opt_selector $1
fi