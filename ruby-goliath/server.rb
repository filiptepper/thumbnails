require "bundler/setup"

if defined?(Rubinius)
  p "a"
  Fiber = Rubinius::Fiber
end

require "goliath"

class Thumbnails < Goliath::API
  def response(env)
    command = "gm convert -size 100x100 ..//image.jpg -resize 100x100 JPG:-"
    image = ""
    IO.popen(command) do |result|
      while part = result.read(1024)
        image << part
      end
    end

    [200, {}, image]
  end
end