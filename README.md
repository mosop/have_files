# have_files

A Crystal Spec/spec2 matcher for testing if two file trees are identical.

[![CircleCI](https://circleci.com/gh/mosop/have_files.svg?style=shield)](https://circleci.com/gh/mosop/have_files)

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
require "have_files/spec/expectation"

it "may work" do
  "/path/to/actual".should HaveFiles::Spec::Expectation.new("/path/to/expected")
end
```

Or you can define the `have_files` method anywhere you like.

```crystal
require "spec"
require "have_files/spec/dsl"

module Test
  extend HaveFiles::Spec::Dsl

  it "may work" do
    "/path/to/actual".should have_files "/path/to/expected"
  end
end

have_files "/path/to/expected" # => compile error
```

## With spec2

You can also use have_files with [spec2](https://github.com/waterlink/spec2.cr).

```crystal
require "spec2"
require "have_files/spec2"

Spec2.describe "with spec2" do
  it "is expected to work" do
    expect("/path/to/actual") have_files "/path/to/expected"
  end
end
```

## API

### have_files

#### Parameters

* expected_dir : A path to your expected file tree. (required)
* base_dir : A base path of working directory. To compare file trees with `git diff`, have_files makes a working directory, that is temporary and uniquely named, under this path and copies all of target files into the working directory. (default: `/tmp`)
* cleanup : Determines whether working directory will be deleted after test ends. (default: `true`)

#### Details

have_files treats an actual value as a path of directory whose actual files. Then have_files copies the directory into a working directory and compares it to an expected file tree.

## Releases

* v0.3.0
  * (Breaking Change) nil can't be passed as an actual value any longer.
* v0.2.0
  * (Experimental) spec2 matcher
  * (Breaking Change) Move HaveFiles::Expectation to HaveFiles::Spec::Expectation
  * (Breaking Change) Move HaveFiles::Dsl to HaveFiles::Spec::Dsl
* v0.1.2
  * HaveFiles::Expectation
  * HaveFiles::Dsl

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
