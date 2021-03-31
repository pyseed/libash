#!/bin/bash

#
# LIBASH - core.sh
# unit test tools
#

# check arg
# checkArg name var
checkArg () {
    if [ -z "$2" ]; then
      echo ""
      echo -e "\e[argument missing: $1\e[0m"
      exit 1
   fi
}

# check environment variable
# checkEnv name var
checkEnv () {
    if [ -z "$2" ]; then
      echo -e "\e[environment variable is not set: $1\e[0m"
      exit 1
   fi
}
