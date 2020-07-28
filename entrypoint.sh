#!/bin/bash
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

sendEvent() {
    local messageTitle="${1}"
    local message="${2}"
    local tags="${3}"
    local datadogUrl="https://api.datadoghq.eu/api/v1/events?api_key=${4}"
    local alertType="${5}"
    if [ -z "$alertType" ]; then
        echo "No argument for alert type supplied - setting it to 'info'"
        alertType="info"
    fi
    curl -X POST -H "Content-type: application/json" \
        -d "{\"title\": \"${messageTitle}\",\"text\": \"${message}\",\"priority\": \"normal\",\"tags\": \"${tags}\",\"alert_type\": \"${alertType}\",\"source_type_name\": \"GITHUB\"}" \
        "${datadogUrl}"
}

sendEvent "${1}" "${2}" "${3}" "${4}" "${5}"
