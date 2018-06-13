#!/bin/sh -xu

MEDIAINFO_VERSION="18.05"
ZEN_VERSION="0.4.37"


# Download and extract archives
mkdir -p "Staging" && cd "Staging"

curl -O "https://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VERSION}/libmediainfo0_${MEDIAINFO_VERSION}-1_amd64.Debian_8.0.deb"
curl -O "https://mediaarea.net/download/binary/libmediainfo0/${MEDIAINFO_VERSION}/libmediainfo0_${MEDIAINFO_VERSION}-1_i386.Debian_8.0.deb"
curl -O "https://mediaarea.net/download/binary/libzen0/${ZEN_VERSION}/libzen0_${ZEN_VERSION}-1_amd64.Debian_8.0.deb"
curl -O "https://mediaarea.net/download/binary/libzen0/${ZEN_VERSION}/libzen0_${ZEN_VERSION}-1_i386.Debian_8.0.deb"

for FILE in *.deb
	do mkdir -p "${FILE%.*}" && cd "${FILE%.*}" && ar -vx "../$FILE" && cd ..
done

for FILE in */data.tar.*
	do mkdir -p "${FILE%.tar.*}" && tar -xvf "$FILE" -C"${FILE%.tar.*}"
done


# Copy native libraries into repository
cd ..

cp --backup=numbered ./Staging/*/data/usr/lib/x86_64-linux-gnu/libmediainfo.so.0.0.0 ./amd64/libmediainfo.so 
cp --backup=numbered ./Staging/*/data/usr/lib/i386-linux-gnu/libmediainfo.so.0.0.0 ./i686/libmediainfo.so
cp --backup=numbered ./Staging/*/data/usr/lib/x86_64-linux-gnu/libzen.so.0.0.0 ./amd64/libzen.so
cp --backup=numbered ./Staging/*/data/usr/lib/i386-linux-gnu/libzen.so.0.0.0 ./i686/libzen.so

rm -r ./Staging

