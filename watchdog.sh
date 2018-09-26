#!/bin/bash

# command usage option and args display.
function usage() {
    echo -e "watchdog.sh is a logging tool.\n"
    echo -e "Usage:\n"
    echo -e "\twatchdog.sh command [arguments]\n"
    echo -e "The command are:\n"
    echo -e "\tunit        Units running on system.\n
        process     Process ID uses for filtering.\n
        UID         User ID uses for filtering.\n
        path        Path location of the program.\n
        kernel      Display the kernel messages.\n
        priority    Message priority at verbose level.\n"
}

# to check wether command with no arguments.
if [ -z "$1" ]; then
    usage
fi