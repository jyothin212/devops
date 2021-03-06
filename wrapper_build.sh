#!/bin/bash

Build_num=$2

if [ $# -ne 2 ]
then
	echo "Please pass the application name and Build Number"
	echo "sh wrapper_build.sh app1 2"
	exit 1
fi

echo "Triggering the Build checkout"
sh testGitJdk.sh $java_name
if [ $? -eq 0 ]
then
echo "Checkout completed under $pwd"
else
echo "Checkout failed under $pwd"
exit 1
fi

echo "Starting the Build"
sh maven_build.sh
if [ $? -eq 0 ]
then
echo "Build completed "
else
echo "Build failed "
exit 1
fi

echo "Uploading Artifacts"
sh artifactory_build.sh $Build_num 
if [ $? -eq 0 ]
then
echo "Artfact upload completed"
else
echo "Artifact upload failed"
exit 1
fi

echo "Performing Sonar Analaysis"
sh sonar.sh sonar.properties
if [ $? -eq 0 ]
then
echo "Sonar completed under $pwd"
else
echo "Sonar failed under $pwd"
exit 1
fi

echo "Downloading the Artifacts to stage location"
sh artifactory_build_download.sh $Build_num
if [ $? -eq 0 ]
then
echo "Artifactory download completed"
else
echo "Artifactory download failed"
exit 1
fi

echo "Starting the Artifact deployment"
sh deploy-app.sh $Env
if [ $? -eq 0 ]
then
echo "Deployment completed"
else
echo "Deployment failed"
exit 1
fi

sleep 2


