# Container image that runs your code
FROM curlimages/curl:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint2.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint2.sh"]