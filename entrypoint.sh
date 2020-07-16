#!/bin/bash
set -e

if [ $# -lt 5 ]; then
    echo "Usage:"
    echo -e "\t./send-github-action-event.sh \"Message Title\" \"Build successeded for feature branch\" \"production\" \"pull-request\" <dd-api-key> \"warning\" (optional)"
    echo "#3 can be one of production, uat, dev, or <NORMALISED_BRANCH_NAME>"
    echo "#4 is the name of the workflow logging the event"
    echo "#6 can be one of error, warning, info, or success. Default: info"
    exit 1
fi
echo "Send github action event to datadog"
echo

sendEvent() {
    local messageTitle="${1}"
    local message="${2}"
    local env="${3}"
    local workflow="${4}"
    local datadogUrl="https://api.datadoghq.eu/api/v1/events?api_key=${5}"
    local alertType="${6}"
    if [ -z "$alertType" ]
        then
            echo "No argument for alert type supplied - setting it to 'info'"
            alertType="info"
    fi
    curl  -X POST -H "Content-type: application/json" \
    -d "{\"title\": \"${messageTitle}\",\"text\": \"${message}\",\"priority\": \"normal\",\"tags\": \"[workflow:${workflow},env:${env}]\",\"alert_type\": \"${alertType}\",\"source_type_name\": \"GITHUB\"}" \
     "${datadogUrl}"
}

sendEvent "${1}" "${2}" "${3}" "${4}" "${5}" "${6}"