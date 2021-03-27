# libash

lib tools for bash scripts

## modules

### test.sh

lite unit test tools

```
wget -O libash_test.sh https://raw.githubusercontent.com/pyseed/libash/master/test.sh
```

all on... callbacks are optional

variables:
- currentSuite: current suite name
- current: current test name
- lastResult: result used in last assert
- lastExpected: expected valule from last assert

fixtures functions:
- fixtureHumanTimestamp (second only precision, not suitable for temporary file names)
- fixtureTimestamp (unique)
- fixtureTmpFilePath (use fixtureTimestamp)

assert functions:
- assertIs value
- assertEmpty value
- assertIsFile filePath
- assertIsNotFile filePath
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

# add test/libash_test.sh in .gitignore
wget -O libash_test.sh https://raw.githubusercontent.com/pyseed/libash/master/test.sh
. ./libash_test.sh

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

### core.sh

core helpers

```
wget -O libash_core.sh https://raw.githubusercontent.com/pyseed/libash/master/core.sh
```

- checkArg name var (check function arg, name is display as info to identify arg) (will exit if arg is missing)

### io.sh

io helpers

```
wget -O libash_io.sh https://raw.githubusercontent.com/pyseed/libash/master/io.sh
```

- pause (will not be applyied if NONINTERACTIVE=true)
- error ...args
- fatal ...args
- warning ...args
- success ...args
- humanTimestamp (second precision, do not use for unique temporay file)
- timestamp (unique, use for temporay file)
- tmpFilePath (get a unique temporary file name)
