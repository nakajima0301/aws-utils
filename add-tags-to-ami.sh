#!/bin/bash

CMDNAME=`basename $0`

# Profile
PROFILE=

# Tag
NAME=
COUNTRY=
SERVICE=
DOMAIN=
BRAND=
ENV=
ROLE=
SEGMENT=
SYSTEM_ID=
SUBSYSTEM_ID=

function usage() {
    echo "Usage: $CMDNAME [-i AMI ID] [-r Region]" 1>&2
    exit 1
}

while getopts r:i: OPT
do
	case $OPT in
        "i" ) flag_i="true"; value_i="$OPTARG";;
        "r" ) flag_r="true"; value_r="$OPTARG";;
        * ) usage
    esac
done

if [[ $flag_i == "true" ]]; then
	RESOURCE=$value_i
else
    usage
fi

if [[ $flag_r == "true" ]]; then
	REGION=$value_r
else
    usage
fi

TAGS="
Key=Name,Value=$NAME
Key=Country,Value=$COUNTRY
Key=Service,Value=$SERVICE
Key=Domain,Value=$DOMAIN
Key=Brand,Value=$BRAND
Key=Env,Value=$ENV
Key=Role,Value=$ROLE
Key=Segment,Value=$SEGMENT
Key=SystemID,Value=$SYSTEM_ID
Key=SubSystemID,Value=$SUBSYSTEM_ID
"

aws ec2 create-tags --resources $RESOURCE --tags $TAGS --profile $PROFILE --region $REGION
