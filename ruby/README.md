Servers:

    ruby eventmachine.mini_magick.rb
    rackup -s puma config.dragonfly.rb
    rackup -s puma config.mini_magick.rb
    unicorn -c unicorn.rb -p 9292 config.mini_magick.ru
    unicorn -c unicorn.rb -p 9292 config.dragonfly.ru