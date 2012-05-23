require "bundler/setup"

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
      command = "gm convert -size 100x100 ..//image.jpg -resize 100x100 JPG:-"
      image = ""
      IO.popen(command) do |result|
        while part = result.read(1024)
          image << part
        end
      end

      response.status = 200
      response.content = image
    end

    callback = proc do |res|
      response.send_response
    end

    EM.defer(operation, callback)
  end
end

EM.run {
  EM.start_server "0.0.0.0", 9292, MyHttpServer
}