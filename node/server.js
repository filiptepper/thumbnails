var http = require("http");
var gm = require("gm");

http.createServer(function (req, res) {
  res.writeHead(200, {"Content-Type": "image/jpeg"});

  gm("../image.jpg")
    .resize(100, 100)
    .stream("jpg", function(err, stdout, stderr) {
      stdout.pipe(res);
    });
}).listen(9292, "127.0.0.1");