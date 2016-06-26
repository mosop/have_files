# have_files

An expectation for testing if two file trees are identical, written in the Crystal language.

[![Build Status](https://travis-ci.org/mosop/have_files.svg?branch=master)](https://travis-ci.org/mosop/have_files)

## Requirements

* Git (git diff) - is used for detecting differences.

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
  nil.should have_files("/path/to/expected") do |dir|
    File.write dir + "/test.txt", "Hello, worlb!\n"
  end
end
```

Maybe, it fails like:

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

## API

### have_files

#### Parameters

* expected_dir : A path to expected file tree. (required)
* base_dir : A base path to working directory. To execute git diff, have_files makes a uniquely-named temporary directory under this path and copy all files into the underlying directory. (default: `/tmp`)
* cleanup : Sets whether the working directory will be deleted after test ends. (default: `true`)
* &block : A handler for preparing actual file tree. It is called with a path to the working directory.

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
