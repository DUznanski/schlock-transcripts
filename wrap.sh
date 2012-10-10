#! /bin/bash

if [ "$#" -ne 2 ]
then
	echo "./wrap.sh source-directory destination-directory"
	exit 1
fi
source=$1
destination=$2
if [ ! -d "$destination" ]
then
	mkdir -p $destination
fi

for file in $source/*-*-*.md
do
	file=${file#./}
	file=${file%.md}
	
	echo "<root>" > $destination/$file.xml
	cat ./$file.md >> $destination/$file.xml
	echo "</root>" >> $destination/$file.xml
done