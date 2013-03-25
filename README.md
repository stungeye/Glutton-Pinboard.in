## Glutton Pinboard

A simple Ruby wrapper for the [pinboard.in](http://pinboard.in) API.

The following methods have been implemented:

* `tags_get` - Retrieves all the tags associated with your account.
* `posts_all` - Retrieves all the bookmarks associated with your account.

Methods are throttled using the [glutton_ratelimit](https://github.com/stungeye/glutton_ratelimit) gem to conform to the Pinboard.in API specs.

## Example

    pinboard = GluttonPinboard.new 'username:YOUR_AUTH_TOKEN_HERE'
    
    all_my_tags = pinboard.tags_get
    puts "I have used #{all_my_tags.size} tags."
    
    all_my_posts = pinboard.posts_all
    puts "I have saved #{all_my_posts.size} links."

## Tests

There is a small Minitest spec suite. These test can be run from the root folder:

    rake test
    
HTTP requests are mocked for the specs using the [fakeweb](https://github.com/chrisk/fakeweb) gem.

## Unlicense

This is free and unencumbered software released into the public domain. See UNLICENSE for details.