# libash

lib tools for bash scripts

## modules

### test.sh

unit test tools

all on... callbacks are optional

${currentSuite}: current suite name
${current}: current test name

fixtures functions:
- fixtureTmpFilePath

assert functions:
- assertResult result expected (compare results)
- assertFile /path/result /path/expected (compare file with diff)

```bash
onBeforeSuite () {
  # suite name in $1
}

onAfterSuite () {
  # suite name in $1
}

onBeforeIt () {
  # test name in $1
}

onAfterIt () {
  # test name in $1
  rm "/tmp/$1" 2> /dev/null
}

. libash/lib.sh

mySuite () {
    suite "mysuite"

    it test1
    result=$(...)
    cmpResult "${result}" "expected"

    it test2
    ... > "/tmp/${current}"
    cmpFile "/tmp/${current}" path/to/expected

    local tmpFile=$(fixtureTmpFilePath)
    ...
    rm "${tmpFile}"
}

mySuite
report # that will display results
```
