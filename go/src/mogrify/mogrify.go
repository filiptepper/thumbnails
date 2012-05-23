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
	cmd := exec.Command("gm", "convert", "-size", size, "-resize", size, "-", "-")
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

	io.Copy(stdin, in)
	stdin.Close()
	io.Copy(out, stdout)

	return cmd.Wait()
}
