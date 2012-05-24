count = 1000
limit = 2

1.upto(count / limit) do
  threads = []

  1.upto(limit) do
    threads << Thread.new do
      IO.popen("/usr/local/bin/gm convert -size 100x100 ../image.jpg -resize 100x100 JPG:-") do |result|
        devnull = File.open("/dev/null", "w")

        while part = result.read(1024)
          devnull.puts(part)
        end
      end
    end
  end

  threads.join
end