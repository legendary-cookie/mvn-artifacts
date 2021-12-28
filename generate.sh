#!/bin/bash

function prnt () {
	echo "$1" >> README.md
}

echo "# Maven Repository" > README.md
prnt "Add the repository to your build tool, for example gradle:"
prnt '```groovy'
prnt "maven {"
prnt "	url 'https://maven.tisigue.de'"
prnt "}"
prnt '```'

for f in $(find . -name maven-metadata.xml)
do
	dir=`dirname $f`
	groupId=`dirname $dir | sed 's#^./##g' | sed 's#/#.#g'`
	artifactId=`echo $dir | sed 's#'$groupId\/'##g' | sed 's#^./##g'`
	version=`cat $f | rg release | sed 's/[a-z<>/]//g' | tr -d " \t\n\r"`
	full=$groupId:$artifactId:$version
	echo $full

	prnt "## $artifactId"
	prnt "Add this to your build.gradle:"
	prnt '```groovy'
	prnt "implementation $full"
	prnt '```'
	prnt ""
	prnt "Add this to your pom.xml:"
	prnt '```xml'
	prnt "<dependencies>"
	prnt " <dependency>"
	prnt "   <groupId>$groupId</groupId>"
	prnt "   <artifactId>$artifactId</artifactId>"
	prnt "   <version>$version</version>"
	prnt " </dependency>"
	prnt "</dependencies>"
	prnt '```'
	prnt ""
	prnt "<br>"
	prnt ""
done

pandoc -s README.md -o index.html --metadata title="Maven Repository"
