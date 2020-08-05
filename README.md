# datadog-event-action
A GitHub Action that triggers DataDog Events

# Latest working version
Latest version = v1.0.6

# Update latest

To update the latest tag run following git commands:


```bash
git commit -am "<your message here>"
git tag -f -am "<your message here>" latest
git push -f --tags
```

# usage

name: Send event to datado
id: send-event-to-datadog
uses: cinch-labs/datadog-event-action@latest
env:
    message-title: 'Feature branch build succeeded'
    message: 'Build, deployment and e2e tests completed successfully'
    tags: needs to be a list of strings e.g. "['branch:master','env:dev']"
    datadog-api-key: ${{ secrets.DATADOG_EVENTS_API_KEY }}
    alert-type: can be one of error, warning, info, or success. Default: info