'use strict';

var gm = require("gm")
  , fs = require("fs")

  , output = fs.createWriteStream("/dev/null")
  , image = "../image.jpg"
  , limit = 2, count = 1000;

(function self() {
  --count;
  --limit;
  gm(image)
    .resize(100, 100)
    .stream("jpg", function(err, stdout, stderr) {
      if (err) {
        throw err;
      }
      stdout.pipe(output);
      stdout.on('end', function () {
        ++limit;
        if (count) {
          self();
        }
      });
    });
  if (limit && count) {
    self();
  }
}());