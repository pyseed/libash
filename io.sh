#!/bin/bash

#
# LIBASH - io.sh
# unit test tools
#

# mark a pause
# pause will not be applyied if NONINTERACTIVE=true
pause () {
    [ "${NONINTERACTIVE}" != 'false' ] && read -p "[PAUSE] CTRL-C TO CANCEL or press a key to CONTINUE"
}

# display error in red
# error ...args
error () {
    echo -e "\e[31mERROR\e[0m $*"
}

# display fatal error in red then exit
# fatal ...args
fatal () {
    echo -e "\e[31mFATAL\e[0m $*"
    echo "aborted"
    exit 1
}

# display warning in orange
# warning ...args
warning () {
    echo -e "\e[33mWARNING\e[0m $*"
}

# highlight success in green
# success ...args
success () {
    echo -e "\e[32mERROR\e[0m $*"
}

# get timestamp (second precision)
humanTimestamp () {
    local ts=$(date +%Y-%m-%d_%H-%M-%S)
    echo "${ts}"
}

# get timestamp unique
timestamp () {
    local ts=$(date +%s%N)
    echo "${ts}"
}

# get temporary file path
tmpFilePath () {
    local ts=$(timestamp)
    echo "/tmp/libash_test_${ts}.tmp"
}
