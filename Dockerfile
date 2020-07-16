FROM debian:9.6-slim

LABEL "com.github.actions.name"="DataDog Event Trigger (eu)"
LABEL "com.github.actions.description"="Trigger DataDog Events from GitHub Actions"
LABEL "com.github.actions.icon"="hash"
LABEL "com.github.actions.color"="gray-dark"

LABEL version="1.0.0"
LABEL repository="https://github.com/cinch-labs/datadog-event-action"
LABEL homepage="https://github.com/cinch-labs/datadog-event-action"
LABEL maintainer="Cinch labs"

RUN apt-get update && apt-get install -y curl

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]