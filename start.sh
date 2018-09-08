#!/bin/bash

function handle_signal {
  PID=$!
  echo "received signal. PID is ${PID}"
  kill -s SIGHUP $PID
}

trap "handle_signal" SIGINT SIGTERM SIGHUP

echo "starting jackett"
mono /opt/Jackett/JackettConsole.exe --NoUpdates -d=/volumes/config/Jackett & wait
echo "stopping jackett"
