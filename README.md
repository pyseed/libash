# libash

lib tools for bash scripts

## modules

### test.sh

lite unit test tools

```
curl https://raw.githubusercontent.com/pyseed/libash/master/test.sh > test.sh
```

all on... callbacks are optional

variables:
- currentSuite: current suite name
- current: current test name
- lastResult: result used in last assert
- lastExpected: expected valule from last assert

fixtures functions:
- fixtureTmpFilePath

assert functions:
- assertResult result expected (compare results)
- assertFile /path/result ./path/expected (compare files with diff)
- assertFileContent /path/result expectedContent

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

. libash/test.sh

mySuite () {
    suite "mysuite"

    it test1
    result=$(...)
    cmpResult "${result}" "expected"

    it test2
    ... > "/tmp/${current}"
    cmpFile "/tmp/${current}" ./path/to/expected

    local tmpFile=$(fixtureTmpFilePath)
    ...
    rm "${tmpFile}"
}

mySuite
report # that will display results
```
