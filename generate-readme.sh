#!/bin/bash

for f in $(find . -name maven-metadata.xml)
do
	dir="$(dirname $f)"
	groupId="$(dirname $dir | sed 's#^./##g')"
	artifactId="$(echo $dir | sed 's#'$groupId\/'##g' | sed 's#^./##g')"
	version=""
	echo $groupId:$artifactId:$version
done
