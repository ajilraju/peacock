#!/bin/bash

# command usage option and args display.
function usage() {
    echo -e "peacock.sh is a logging tool.\n"
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
            uid_display $second_arg
            ;;
        "path")
            component_path $second_arg
            ;;
        "kernel")
            kernel_display 
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
    PE_file="/tmp/peacock/PE_*"

    target_file=(PE_unit PE_pid PE_uid PE_path PE_kernel)
    cd $base_dir

    for file in ${target_file[*]}
    do
     if [ -d $file ]; then

        echo "Initializing..."
    else

        mkdir $base_dir$file
    
    fi
    done
   
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
    local PE_target="/tmp/peacock/PE_unit/PE_UNIT"
    # read each command and check against them.
    while read -r line
    do
        if [ "$1" = "$line" ]; then
            # run as a command eg: journalctl -u ssh.service.
            command $base_cmd$1$service
            command $base_cmd$1$service >> $PE_target
            exit 0
        else 
           clear screen
            #echo "Couldn't find $1 service." 2> /dev/null
        fi
    done < $unit_file
}

# to handle the pid based systemd logs.
function pid_display() {
    local base_cmd="journalctl _PID="
    local PE_target="/tmp/peacock/PE_pid/PE_PID"

    command $base_cmd$1
    command $base_cmd$1 >> $PE_target
    exit 0

}

# to handle the uid based systemd logs.
function uid_display() {
    local base_cmd="journalctl _UID="
    local PE_target="/tmp/peacock/PE_uid/PE_UID"

    command $base_cmd$1
    command $base_cmd$1 >> $PE_target
    exit 0
}

# to display the kernel related logs.
function kernel_display() {
    local base_cmd="journalctl -k"
    local PE_target="/tmp/peacock/PE_kernel/PE_KERNEL"

    command $base_cmd$1
    command $base_cmd$1 >> $PE_target
    exit 0
}

# to handle component path log check
function component_path() {
    local base_cmd="journalctl "
    local PE_target="/tmp/peacock/PE_path/PE_PATH"

    command $base_cmd$1
    command $base_cmd$1 >> $PE_target
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
