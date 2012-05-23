import tornado.httpserver
import tornado.ioloop
import tornado.options
import tornado.web
from PythonMagick import Image, Blob, Geometry

class ImageHandler(tornado.web.RequestHandler):
    def get(self):
        image = Image("../image.jpg")
        image.resize(Geometry(100, 100))
        blob = Blob()
        image.write(blob)
        self.write(blob.data)
        
application = tornado.web.Application([
    (r"/", ImageHandler)
])
        
def main():
    application.listen(9292)
    tornado.ioloop.IOLoop.instance().start()
    
if __name__ == '__main__':
    main()
