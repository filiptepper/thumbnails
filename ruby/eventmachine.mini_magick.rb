require "bundler/setup"
require "mini_magick"
require "eventmachine"
require "evma_httpserver"

class MyHttpServer < EM::Connection
  include EM::HttpServer

   def post_init
     super
     no_environment_strings
   end

  def process_http_request
    response = EventMachine::DelegatedHttpResponse.new(self)

    operation = proc do
      image = MiniMagick::Image.open("../image.jpg")
      image.resize "100x100"

      response.status = 200
      response.content_type "image/jpeg"
      response.content = image.to_blob
    end

    callback = proc do |res|
      response.send_response
    end

    EM.defer(operation, callback)
  end
end

EM.run {
  EM.start_server '0.0.0.0', 9292, MyHttpServer
}