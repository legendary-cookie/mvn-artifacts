#!/bin/bash
repoLoc=/path/to/repository

mvn -q clean package
version=`mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.version | rg -v "^\["`
groupId=`mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.groupId | rg -v "^\["`
artifactId=`mvn org.apache.maven.plugins:maven-help-plugin:2.1.1:evaluate -Dexpression=project.artifactId | rg -v "^\["`

mvn deploy -q -DaltDeploymentRepository=release-repo::default::file://$repoLoc

cd $repoLoc
./generate.sh
git add -A
git commit -m "Added ${groupId}:${artifactId}:${version}"
git push
