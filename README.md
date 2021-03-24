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
- assertIs value
- assertEmpty value
- assertIsFile filePath
- assertResult result expected (compare results)
- assertFile /path/result ./path/expected (compare files with diff)
- assertFileContent /path/result expectedContent

```bash
#verbose=true

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

    local tmpFile=$(fixtureTmpFilePath)
    ...
    rm "${tmpFile}"

    it test1
    result=$(...)
    assertResult "${result}" "expected"

    it test2
    ... > "/tmp/${current}"
    assertFile "/tmp/${current}" ./path/to/expected
    or
    assertFileContent "/tmp/${current}" "expected"

    ...
}

mySuite
report # that will display results
```
