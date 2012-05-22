require "bundler/setup"
require "image_voodoo"

class Thumbnails
  def call(env)
    [200, {"Content-Type" => "image/jpeg"}, [
      ImageVoodoo.with_image("../image.jpg").thumbnail(100).bytes("jpg")
    ]]
  end
end

run Thumbnails.new