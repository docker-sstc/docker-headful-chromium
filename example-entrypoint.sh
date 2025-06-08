#!/bin/bash

# https://stackoverflow.com/questions/78677008/how-do-i-forward-signals-to-a-process-started-with-xfvb-run-in-docker

# Start the process with a virtual x server
xvfb-run -s "-screen 0 1920x1080x8" "$@" &

# Get the PID of the background process of the x server
CHILD_PID=$!

forward_signal() {
  # $1 is the signal that is forwarded
  # pgrep -P gives me processes which have the xfvb-run as a parent process
  kill -"$1" $(pgrep -P $CHILD_PID)
}

# Trap the signals you need and forward them
trap 'forward_signal SIGTERM' SIGTERM

# Wait for the xfvb-run process to finish
wait $CHILD_PID
