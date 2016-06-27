# have_files

A Spec's expectation for testing if two file trees are identical, written in the Crystal language.

[![Build Status](https://travis-ci.org/mosop/have_files.svg?branch=master)](https://travis-ci.org/mosop/have_files)

## Requirements

* Git (git diff) - is used for file comparison.

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  have_files:
    github: mosop/have_files
```

## Usage

```crystal
require "spec"
require "have_files/spec"

it "may work" do
  "/path/to/actual".should have_files "/path/to/expected"
end
```

You can also manually write out actual files:

```crystal
require "spec"
require "have_files/spec"

it "may work" do
  nil.should have_files("/path/to/expected") do |actual_dir|
    File.write actual_dir + "/test.txt", "Hello, world!\n"
  end
end
```

If test fails, have_files generates a diff message like:

```
Failures:

  1) may work
     Failure/Error: nil.should have_files("/path/to/expected") do |dir|

        diff/test.txt | 2 +-
        1 file changed, 1 insertion(+), 1 deletion(-)

       diff --git a/diff/test.txt b/diff/test.txt
       index 8ab686e..415b41d 100644
       --- a/diff/test.txt
       +++ b/diff/test.txt
       @@ -1 +1 @@
       -Hello, World!
       +Hello, Worlb!

     # ./spec/hello_spec.cr:8

Finished in 203.09 milliseconds
1 examples, 1 failures, 0 errors, 0 pending
```

## Preventing Namespace Pollution

To prevent pollution of top level namespace, you can directly create expectations.

```crystal
require "spec"
require "have_files/expectation"

it "may work" do
  "/path/to/actual".should HaveFiles::Expectation.new("/path/to/expected")
end
```

Or you can define the `have_files` method anywhere you like.

```crystal
require "spec"
require "have_files/dsl"

module Test
  extend HaveFiles::Dsl

  it "may work" do
    "/path/to/actual".should have_files "/path/to/expected"
  end
end

have_files "/path/to/expected" # => compile error
```

## API

### have_files

#### Parameters

* expected_dir : A path to your expected file tree. (required)
* base_dir : A base path of working directory. To compare file trees with `git diff`, have_files makes a working directory, that is temporary and uniquely named, under this path and copies all of target files into the working directory. (default: `/tmp`)
* cleanup : Determines whether working directory will be deleted after test ends. (default: `true`)
* &block : A handler for preparing actual file tree. It is called with a working directory's path.

#### Details

If an actual value is `String`, have_files treats the value as a path of directory whose actual files. Then have_files copies the directory into a working directory and compares it to an expected file tree.

If an actual value is `nil`, have_files does nothing for preparing an actual file tree. However, you can specify a handler to the `block` parameter to manually prepare an actual file tree. See Usage.

## Releases

* v0.1.2
  * HaveFiles::Expectation
  * HaveFiles::Dsl
  * fixes

## Development

[WIP]

## Contributing

1. Fork it ( https://github.com/mosop/have_files/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [mosop](https://github.com/mosop) - creator, maintainer
