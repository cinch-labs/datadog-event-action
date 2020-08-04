#!/bin/sh
set -e

if [ $# -lt 4 ]; then
    echo "Usage:"
    echo -e "\t./send-github-action-event.sh \"Message Title\" \"Build successeded for feature branch\" \"[workflow:\"pull-request\",branch:\"${NORMALISED_BRANCH_NAME}\",env:\"${CINCH_ENVIRONMENT}\" <dd-api-key> \"warning\" (optional)"
    echo "'env' can be one of production, uat, development, or <NORMALISED_BRANCH_NAME>"
    echo "'workflow' is the name of the workflow logging the event"
    echo "#5 can be one of error, warning, info, or success. Default: info"
    exit 1
fi
echo "Send github action event to datadog"
echo

messageTitle="$1"
message="$2"
tags="$3"
datadogUrlBase="http://api.datadoghq.eu/api/v1/events?api_key="
datadogUrl="${datadogUrlBase}${4}"
alertType="$5"
echo "messageTitle=$messageTitle"
echo "message=$message"
echo "tags=$tags"
echo "datadogUrlBase=$datadogUrlBase"
echo "alertType=$alertType"
echo "{\"title\": \"${messageTitle}\",\"text\": \"${message}\",\"priority\": \"normal\",\"tags\": \"${tags}\",\"alert_type\": \"${alertType}\",\"source_type_name\": \"GITHUB\"}" \
"${datadogUrl}"

if [ -z "$alertType" ]; then
    echo "No argument for alert type supplied - setting it to 'info'"
    alertType="info"
fi
curl -X POST -H "Content-type: application/json" \
-d '{
            "title": "'"${messageTitle}"'",
            "text": "'"${message}"'",
            "priority": "normal",
            "tags": "'"${tags}"'",
            "alert_type": "'"${alertType}"'",
            "source_type_name": "GITHUB"
}' \
"'"${datadogUrl}"'"
