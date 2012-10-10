#! /bin/bash

if [ "$#" -ne 2 ]
then
	echo "./revert.sh source-directory destination-directory"
	exit 1
fi
source=$1
destination=$2
if [ ! -d "$destination" ]
then
	mkdir -p $destination
fi

for file in $source/*-*-*.xml
do
	file=${file##*/}
	file=${file%.xml}

	echo "$file"
	xsltproc revert.xsl $source/$file.xml > $destination/$file.txt
done