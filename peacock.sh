#!/bin/bash

# command usage option and args display.
function usage() {
    echo -e "watchdog.sh is a logging tool.\n"
    echo -e "Usage:\n"
    echo -e "\twatchdog.sh command [arguments]\n"
    echo -e "The command are:\n"
    echo -e "\tunit        Units running on system.\n
        pid         Process ID uses for filtering.\n
        uid         User ID uses for filtering.\n
        path        Path location of the program.\n
        kernel      Display the kernel messages.\n
        prty        Message priority at verbose level.\n"
}

# command option selector to further process.
function opt_selector() {

    # to store the second argument associated with first args.
    second_arg=$2

    case "$1" in 
        "unit")
            unit_display $second_arg
            ;;
        "pid")
            pid_display $second_arg
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

# initialize the environment for the program.
function env_setup() {

    base_dir="/tmp/peacock/"
    unit_file="/tmp/peacock/unit-service.txt"

    if [ -d $base_dir ]; then
        echo "nothing to do."
    else
        mkdir $base_dir
        #echo $base_dir    
    fi
    
    if [ -e $unit_file ]; then
        echo "nothing to do."
    else
        touch $unit_file
    fi
    service --status-all | more | awk '{print $4}' >> $unit_file
}

# to handle the unit based systemd logs.
function unit_display() {
    # to store local command and service extension.
    local base_cmd="journalctl -u "
    local service=".service"

    # read each command and check against them.
    while read -r line
    do
        echo $line
        if [ "$1" = "$line" ]; then
            # run as a command eg: journalctl -u ssh.service.
            command $base_cmd$1$service
            exit 0
        else 
            echo "Couldn't find $1 service."
        fi
    done < $unit_file
}
# to handle the pid based systemd logs.
function pid_display() {
    local base_cmd="journalctl _PID="
    command $base_cmd$1
    exit 0

}
# environment setup func call.
env_setup

# to check wether command with no arguments.
if [ -z "$1" ]; then
    usage
else 
    opt_selector $1 $2
fi
