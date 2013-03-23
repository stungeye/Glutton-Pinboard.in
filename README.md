## Glutton Pinboard

A simple wrapper for the [pinboard.in](http://pinboard.in) API.

## Example

    pinboard = GluttonPinboard.new 'username:YOUR_AUTH_TOKEN_HERE'
    
    require 'pp'
    
    all_my_tags = pinboard.tags_get
    puts "I have used #{all_my_tags.size} tags."
    
    all_my_posts = pinboard.posts_all
    puts "I have saved #{all_my_posts.size} links."

## Unlicense

This is free and unencumbered software released into the public domain. See UNLICENSE for details.