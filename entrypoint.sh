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

if [[ -z "$EVENT_TEXT" || -z "$MESSAGE_TITLE" || -z "$ENV" || -z "$WORKFLOW" || -z "$DATADOG_API_KEY" ]]; then
  echo "One or more required variables are missing: DATADOG_API_KEY, EVENT_TITLE, EVENT_TEXT"
  exit 1
fi

if [[ -z "$EVENT_PRIORITY" ]]; then
  # normal or low
  EVENT_PRIORITY="normal"
fi

if [[ -z "$EVENT_ALERT_TYPE" ]]; then
  # error, warning, info, and success.
  EVENT_ALERT_TYPE="info"
fi

DATADOG_URL="https://api.datadoghq.eu/api/v1/events?api_key=$DATADOG_API_KEY"
curl  -X POST -H "Content-type: application/json" \
-d "{\"title\": \"${EVENT_TITLE}\",\"text\": \"${EVENT_TEXT}\",\"priority\": \"normal\",\"tags\": \"[workflow:${WORKFLOW},env:${ENV}]\",\"alert_type\": \"${EVENT_ALERT_TYPE}\",\"source_type_name\": \"GITHUB\"}" \
    "${DATADOG_URL}"