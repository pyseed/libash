#!/bin/bash

#
# LIBASH - test.sh
# unit test tools
#

currentSuite=""
current=""
totalCount=0
successCount=0
failCount=0
lastResult=""
lastExpected=""

# log a success
_logSuccess () {
    echo -e "\e[32mOK\e[0m ${currentSuite}.${current}"
    ((successCount=successCount+1))
}

# log a fail
_logFail () {
    echo -e "\e[31mKO\e[0m ${currentSuite}.${current}"
    ((failCount=failCount+1))
}


# report
report () {
    echo ""
    echo "--"

    # no fails: success in gree
    [ ${failCount} != 0 ] && echo -e "success: ${successCount}" || echo -e "\e[32msuccess\e[0m: ${successCount}"
    # any fail: fails in red
    [ ${failCount} != 0 ] && echo -e "\e[31mfails\e[0m: ${failCount}"
    echo -e "total: ${totalCount}"

    echo ""
}

# suite
# suite name
suite () {
    # end of previous suite
    suiteEnd

    echo ""
    echo ""
    currentSuite="$*"
    declare -F onBeforeSuite &> /dev/null && onBeforeSuite "${currentSuite}"
}

suiteEnd () {
    # end previous test
    itEnd

    [ -n "${currentSuite}" ] && declare -F onAfterSuite &> /dev/null && onAfterSuite "${currentSuite}"
}

# a test is beginning
# will set current test name in "${current}"
# beginTest testName
it () {
    # end previous test
    itEnd

    current="$1"
    declare -F onBeforeIt &> /dev/null && onBeforeIt "${current}"
    ((totalCount=totalCount+1))
    echo ""
}

# a test has finished
# endTest
itEnd () {
    [ "${verbose}" = "true" ] && [ -n "${lastResult}" ] && (echo "${lastResult}"; echo "->"; echo "${lastExpected}")
    [ -n "${current}" ] && declare -F onAfterIt &> /dev/null && onAfterIt  "${current}"

    current=""
    lastResult=""
    lastExpected=""
}


# get timestamp
fixtureTimestamp () {
    local ts=$(date +%Y-%m-%d_%H-%M-%S)
    echo "${ts}"
}


# get temporary file
fixtureTmpFilePath () {
    local ts=$(fixtureTimestamp)
    echo "/tmp/libash_test_${ts}.tmp"
}


# assertIs value
assertIs () {   
    [ -n "$1" ] && _logSuccess || _logFail
}

# assertIsEmpty value
assertIsEmpty () {   
    [ -z "$1" ] && _logSuccess || _logFail
}

# assertIsFile filePath
assertIsFile () {
    [ -f "$1" ] && _logSuccess || _logFail
}

# assertIsFile filePath
assertIsNotFile () {
    [ ! -f "$1" ] && _logSuccess || _logFail
}


# assertResult result expected
assertResult () {
    local result="$1"
    local expected="$2"

    [ "${result}" = "${expected}" ] && _logSuccess || _logFail

    lastResult="${result}"
    lastExpected="${expected}"
}

# assertFile resultPath expectedPath
assertFile () {
    local resultPath="$1"
    local expectedPath="$2"

    if diff -u "${resultPath}" "${expectedPath}"; then
        _logSuccess
    else
        _logFail
    fi

    lastResult=$(cat "${resultPath}" 2> /dev/null)
    lastExpected=$(cat "${expectedPath}" 2> /dev/null)
}

# assertFileContent resultPath expectedContent
assertFileContent () {
    local resultPath="$1"
    local expectedContent="$2"
    local tmpFile=$(fixtureTmpFilePath)

    echo -n "${expectedContent}" > "${tmpFile}"
    assertFile "${resultPath}" "${tmpFile}"
    rm "${tmpFile}"
}

export -f report
export -f suite
export -f it
export -f itEnd

export -f fixtureTimestamp
export -f fixtureTmpFilePath

export -f assertIs
export -f assertIsEmpty
export -f assertIsFile
export -f assertIsNotFile
export -f assertResult
export -f assertFile
export -f assertFileContent
