package mogrify

import (
	"io"
	"log"
	"os"
	"os/exec"
)

func init() {
	_, err := exec.LookPath("gm")
	if err != nil {
		log.Print("Could not locate gm (GraphicsMagic) tool in path")
		os.Exit(1)
	}
}

func Resize(out io.Writer, in io.Reader, size string) (err error) {
	defer func() {
		log.Printf("resizing stream to %s - %t", size, err == nil)
	}()

	cmd := exec.Command("gm", "convert", "-resize", size, "-colorspace", "RGB", "-", "-")
	stdin, err := cmd.StdinPipe()
	if err != nil {
		return
	}

	stdout, err := cmd.StdoutPipe()
	if err != nil {
		return
	}

	err = cmd.Start()
	if err != nil {
		log.Print(err)
		return
	}

	// copy stream ot gm tool, close stream once done and 
	// read the output of the tool back to the out stream
	io.Copy(stdin, in)
	stdin.Close()
	io.Copy(out, stdout)

	return cmd.Wait()
}
