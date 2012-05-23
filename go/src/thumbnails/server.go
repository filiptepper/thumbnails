package main

import (
	"mogrify"
	"net/http"
	"flag"
  "io"
  "bytes"
  "os"
)

func main() {
  flag.Parse()

  http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
    content, err := os.Open("../image.jpg")
    if err != nil { panic(err) }

    buffer := bytes.NewBuffer(nil)
    mogrify.Resize(buffer, content, "100x100")

    io.Copy(w, buffer)

    return
  })

  http.ListenAndServe(":9292", nil)
}