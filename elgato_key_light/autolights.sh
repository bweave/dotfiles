#!/bin/bash

# Begin looking at the system log via the steam sub-command. Using a --predicate and filtering by the correct and pull out the camera event
log stream --predicate 'subsystem == "com.apple.UVCExtension" and composedMessage contains "Post PowerLog"' | while read -r line; do
  # The camera start event has been caught and is set to 'On', turn the light on
  if echo "$line" | grep -q "= On"; then
    echo "Camera has been activated, turn on the light."
    # Light 1 - change IP to your first lights IP
    curl --location --request PUT 'http://elgato-key-light-air-9c7f.local:9123/elgato/lights' --header 'Content-Type: application/json' --data-raw '{"lights":[{"on":1}],"numberOfLights":1}'
  fi

  # If we catch a camera stop event, turn the light off.
  if echo "$line" | grep -q "= Off"; then
    echo "Camera shut down, turn off the light."
    #Light 1 - set to off
    curl --location --request PUT 'http://elgato-key-light-air-9c7f.local:9123/elgato/lights' --header 'Content-Type: application/json' --data-raw '{"lights":[{"on":0}],"numberOfLights":1}'
  fi
done
