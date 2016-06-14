#!/bin/bash

SIZE=2299
FILE="./testdata.txt"

URL=$(curl -X POST -i $TUS_URL -H 'Tus-Resumable: 1.0.0'  -H "Upload-Length: $SIZE" |  \
	grep 'Location:' |  \
	sed "s/$(printf '\r')\$//" | \
	awk '{print $2}')

echo "URL is $URL"

curl -X PATCH -i $URL \
	-H 'Tus-Resumable: 1.0.0'  \
	-H 'Upload-Offset: 0' \
	-H 'Content-Type: application/offset+octet-stream' \
	--upload-file $FILE 

