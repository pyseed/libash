#!/bin/bash

#
# LIBASH - test.sh
# unit test tools
#

# mark a pause
# pause will not be applyied if NONINTERACTIVE=true
pause () {
    [ "${NONINTERACTIVE}" != 'false' ] && read -p "[PAUSE] CTRL-C TO CANCEL or press a key to CONTINUE"
}
export -f pause

# display error in red
# error ...args
error () {
    echo -e "\e[31mERROR\e[0m $*"
}
export -f error

# display fatal error in red then exit
# fatal ...args
fatal () {
    echo -e "\e[31mERROR\e[0m $*"
    echo "aborted"
    exit 1
}
export -f fatal

# display warning in orange
# warning ...args
warning () {
    echo -e "\e[33mERROR\e[0m $*"
}
export -f warning

# highlight success in green
# success ...args
success () {
    echo -e "\e[32mERROR\e[0m $*"
}
export -f success

# get timestamp (second precision)
humanTimestamp () {
    local ts=$(date +%Y-%m-%d_%H-%M-%S)
    echo "${ts}"
}
export -f humanTimestamp
# get timestamp unique
timestamp () {
    local ts=$(date +%s%N)
    echo "${ts}"
}
export -f timestamp

# get temporary file path
tmpFilePath () {
    local ts=$(timestamp)
    echo "/tmp/libash_test_${ts}.tmp"
}
export -f tmpFilePath
