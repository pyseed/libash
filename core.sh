#!/bin/bash

#
# LIBASH - core.sh
# unit test tools
#

# check arg
# checkArg name var
checkArg () {
    if [ -z "$2" ]; then
      echo "argument missing: $1"
      exit 1
   fi
}
