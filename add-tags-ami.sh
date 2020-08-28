#!/bin/bash

CMDNAME=`basename $0`

# Profile
PROFILE=my-account
REGION=ap-northeast-1

# AMI ID
RESOURCE=foo

# Tag
NAME=stg01-foo-bar-r
COUNTRY=JP
SERVICE=logaggregator
DOMAIN=staging
BRAND=fr
ENV=staging
ROLE=
SEGMENT=

function usage() {
    echo "Usage: $CMDNAME [-i AMI ID]" 1>&2
    exit 1
}

while getopts i: OPT
do
	case $OPT in
        "i" ) flag_i="true"; value_i="$OPTARG";;
        * ) usage
    esac
done

if [[ $flag_i == "true" ]]; then
	RESOURCE=$value_i
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
Key=SystemID,Value=INF
Key=SubSystemID,Value=LGA
"

aws ec2 create-tags --resources $RESOURCE --tags $TAGS --profile $PROFILE --region $REGION
