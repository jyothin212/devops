#!/bin/bash

ARTIFACTORY_NAME=`grep artifactory_name artifactory.properties|awk -F"=" '{print $2}'`
	if [ -z "$ARTIFACTORY_NAME" ]
	then
		echo "Provide artifactory_name in artifactory.properties"
		exit 1
	else
		echo "Artifactory is $ARTIFACTORY_NAME"
	fi

if [ $# -eq 1 ]
then
	if [ ${ARTIFACTORY_NAME} == "JFROG" ]
	then
	USRNAME=`grep ${ARTIFACTORY_NAME}_username artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$USRNAME" ]
		then
			echo "Provide ${ARTIFACTORY_NAME}_username in artifactory.properties"
            exit 1
		else
			echo "${ARTIFACTORY_NAME}_username is $USRNAME"
		fi
    PASSWD=`grep ${ARTIFACTORY_NAME}_password artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$PASSWD" ]
        then
			echo "Provide ${ARTIFACTORY_NAME}_password in artifactory.properties"
            exit 1
        else
            echo "${ARTIFACTORY_NAME}_password is $PASSWD"
        fi
    APP=`grep ${ARTIFACTORY_NAME}_app_name artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$APP" ]
        then
            echo "Provide ${ARTIFACTORY_NAME}_app_name in artifactory.properties"
            exit 1
        else
            echo "${ARTIFACTORY_NAME}_app_name is $APP"
        fi
    MODULE=`grep ${ARTIFACTORY_NAME}_module_name artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$MODULE" ]
        then
            echo "Provide ${ARTIFACTORY_NAME}_module_name in artifactory.properties"
             exit 1
        else
            echo "${ARTIFACTORY_NAME}_module_name is $MODULE"
        fi
    SERVER=`grep ${ARTIFACTORY_NAME}_server_name artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$SERVER" ]
        then
            echo "Provide ${ARTIFACTORY_NAME}_server_name in artifactory.properties"
            exit 1
        else
            echo "${ARTIFACTORY_NAME}_server_name is $SERVER"
        fi
    PORT=`grep ${ARTIFACTORY_NAME}_port_number artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$PORT" ]
        then
            echo "Provide ${ARTIFACTORY_NAME}_port_number in artifactory.properties"
            exit 1
        else
			echo "${ARTIFACTORY_NAME}_port_number is $PORT"
        fi
    STAGE_LOCATION=`grep app_stage appserver.properties|awk -F"=" '{print $2}'`
        if [ -z "$STAGE_LOCATION" ]
        then
            echo "Provide app_stage in appserver.properties"
            exit 1
        else
			echo "app_stage is $STAGE_LOCATION"
        fi

cd $STAGE_LOCATION
	curl -u${USRNAME}:${PASSWD} -O http://${SERVER}:${PORT}/artifactory/generic-local/${APP}/${1}/${MODULE}
		if [ $? -eq 0 ]
        then
			echo "Download is successful."
        else
			echo "Download is not successful."
			exit 1
        fi
	fi

	if [ ${ARTIFACTORY_NAME} == "NEXUS" ]
	then
	USRNAME=`grep ${ARTIFACTORY_NAME}_username artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$USRNAME" ]
		then
			echo "Provide ${ARTIFACTORY_NAME}_username in artifactory.properties"
            exit 1
		else
			echo "${ARTIFACTORY_NAME}_username is $USRNAME"
		fi
    PASSWD=`grep ${ARTIFACTORY_NAME}_password artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$PASSWD" ]
        then
			echo "Provide ${ARTIFACTORY_NAME}_password in artifactory.properties"
            exit 1
        else
            echo "${ARTIFACTORY_NAME}_password is $PASSWD"
        fi
    APP=`grep ${ARTIFACTORY_NAME}_app_name artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$APP" ]
        then
            echo "Provide ${ARTIFACTORY_NAME}_app_name in artifactory.properties"
            exit 1
        else
            echo "${ARTIFACTORY_NAME}_app_name is $APP"
        fi
    MODULE=`grep ${ARTIFACTORY_NAME}_module_name artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$MODULE" ]
        then
            echo "Provide ${ARTIFACTORY_NAME}_module_name in artifactory.properties"
             exit 1
        else
            echo "${ARTIFACTORY_NAME}_module_name is $MODULE"
        fi
    SERVER=`grep ${ARTIFACTORY_NAME}_server_name artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$SERVER" ]
        then
            echo "Provide ${ARTIFACTORY_NAME}_server_name in artifactory.properties"
            exit 1
        else
            echo "${ARTIFACTORY_NAME}_server_name is $SERVER"
        fi
    PORT=`grep ${ARTIFACTORY_NAME}_port_number artifactory.properties|awk -F"=" '{print $2}'`
        if [ -z "$PORT" ]
        then
            echo "Provide ${ARTIFACTORY_NAME}_port_number in artifactory.properties"
            exit 1
        else
			echo "${ARTIFACTORY_NAME}_port_number is $PORT"
        fi
    STAGE_LOCATION=`grep app_stage appserver.properties|awk -F"=" '{print $2}'`
        if [ -z "$STAGE_LOCATION" ]
        then
            echo "Provide app_stage in appserver.properties"
            exit 1
        else
			echo "app_stage is $STAGE_LOCATION"
        fi

cd $STAGE_LOCATION
	curl -u ${USRNAME}:${PASSWD} -O http://${SERVER}:${PORT}/repository/sprint_applications/${APP}/${1}/${MODULE}
		if [ $? -eq 0 ]
        then
			echo "Download is successful."
        else
			echo "Download is not successful."
        exit 1
        fi
	fi
else
        echo "Please pass argument: <build_number>"
fi
