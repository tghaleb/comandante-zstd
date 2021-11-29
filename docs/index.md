# Welcome to Comandante/Zstd

An add-on for Comandante to allow for zstd reading/writing.

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  comandante-zstd:
    github: tghaleb/comandante-zstd
```

2. Run `shards install`

## Usage

```crystal
require "comandante-zstd"
```

This is actually a wrapper around [zstd.cr](https://github.com/didactic-drunk/zstd.cr). 

To write a string, or any type that has a `to_slice` method to file in
one go,

```crystal
str = "test"
Helper.write_zstd(str, file)
```

To Write Strings to a file using a block, and setting compressing level,

```crystal
Helper.write_zstd(file, level: 19) do |io|
  io.print "test1"
  io.print "test2"
end
```

To read a file into a string,

```crystal
x = Helper.read_zstd(file)
```

To read line by line

```crystal
results = Array(String).new
Helper.read_zstd(file) do |x|
  results << x
end
```

:::Comandante::Helper

