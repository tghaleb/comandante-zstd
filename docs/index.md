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

:::Comandante::Helper

