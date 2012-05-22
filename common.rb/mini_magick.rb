class Thumbnails
  def call(env)
    image = MiniMagick::Image.open("../image.jpg")
    image.resize("100x100")

    [200, {"Content-Type" => "image/jpeg"}, [
      image.to_blob
    ]]
  end
end