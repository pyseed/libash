#!/bin/bash

#
# LIBASH - io.sh
# unit test tools
#

_colors=(
    [black]="$(echo -e '\e[30m')"
    [red]="$(echo -e '\e[31m')"
    [green]="$(echo -e '\e[32m')"
    [yellow]="$(echo -e '\e[33m')"
    [blue]="$(echo -e '\e[34m')"
    [purple]="$(echo -e '\e[35m')"
    [cyan]="$(echo -e '\e[36m')"
    [light_gray]="$(echo -e '\e[37m')"
    [gray]="$(echo -e '\e[90m')"
    [light_red]="$(echo -e '\e[91m')"
    [light_green]="$(echo -e '\e[92m')"
    [light_yellow]="$(echo -e '\e[93m')"
    [light_blue]="$(echo -e '\e[94m')"
    [light_purple]="$(echo -e '\e[95m')"
    [light_cyan]="$(echo -e '\e[96m')"
    [white]="$(echo -e '\e[97m')"
    [reset]="$(echo -e '\e[0m')"
)

declare -g _logPrefix=""

logSetPrefix() {
    _logPrefix="$*"
}

log () {
    echo "${_logPrefix}${*}"
}

# mark a pause
# pause will not be applyied if NONINTERACTIVE=true
pause () {
    [ "${NONINTERACTIVE}" != 'true' ] && read -p "${_logPrefix}[PAUSE] CTRL-C TO CANCEL or press a key to CONTINUE" || true
}

# display error in red
# error ...args
error () {
    echo "${_colors[red]}${_logPrefix}[ERROR] ${*}${__colors[reset]}"
}

# display fatal error in red then exit
# fatal ...args
fatal () {
    echo "${_colors[red]}${_logPrefix}[FATAL] ${*}${__colors[reset]}"
    echo "aborted"
    exit 1
}

# display warning in orange
# warning ...args
warning () {
    echo "${_colors[yellow]}${_logPrefix}[WARNING] ${*}${__colors[reset]}"
}

# highlight success in green
# success ...args
success () {
    echo "${_colors[green]}${_logPrefix}[SUCCESS] ${*}${__colors[reset]}"
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

# sync directories
# syncDir src target
# src and target without trailing /
# requires rsync
syncDir () {
   local src="$1"
   local target="$2"

   echo "sync in progress... ${src} -> ${target}"
   mkdir -p "${target}"
   rsync "${src}/" "${target}/" --delete -avzP
}
