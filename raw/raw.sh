#!/bin/bash
i=0
while [ $i -le 1000 ]; do
gm convert -size 100x100 ../image.jpg -resize 100x100 +profile '*' /dev/null &
i=$(( $i + 1 ))
done