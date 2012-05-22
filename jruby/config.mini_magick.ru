require "bundler/setup"
require "mini_magick"

class Thumbnails
  def call(env)
    image = MiniMagick::Image.open("../image.jpg")
    image.resize("100x100")

    [200, {"Content-Type" => "image/jpeg"}, [
      image.to_blob
    ]]
  end
end

run Thumbnails.new