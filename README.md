# RSS

RSS feed generator. Crystal small implementation of [dylang/node-rss](https://github.com/dylang/node-rss)

TODO: Write a detailed description here

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  RSS:
    github: ga2mer/RSS.cr
```

## Usage

```crystal
require "RSS"

# create feed
feed = RSS.new title: "Simple RSS Feed"

# add item to feed
feed.item(
  title: "Simple item",
  link: "http://example.com/simple-item"
)

# get XML of feed
xml = feed.xml indent: true

```

TODO: Write more usage instructions here

## Development

TODO: Write development instructions here

## Contributing

1. Fork it ( https://github.com/ga2mer/RSS.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [ga2mer](https://github.com/ga2mer) Nikita Savyolov - creator, maintainer
