require "dragonfly"

$app = Dragonfly::App[:thumbnails].configure_with(:imagemagick)

class Thumbnails
  def initialize(app)
    @app = app
  end

  def call(env)
    response = @app.fetch_file("../image.jpg").thumb("100x100")
    response.to_response(env)
  end
end