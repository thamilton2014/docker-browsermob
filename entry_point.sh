#!/bin/bash --login

ROOT=/opt/browsermob

function shutdown {
    echo "Shutting down Browsermob..."
    kill -s SIGTERM $BROWSERMOB_PID
    wait $BROWSERMOB_PID
    echo "Shutdown complete"
}

java ${JAVA_OPTS} -jar browsermob-proxy-2.1.0-beta-4/lib/browsermob-dist-2.1.0-beta-4.jar -port 9000 &
BROWSERMOB_PID=$!

trap shutdown SIGTERM SIGINT
wait $BROWSERMOB_PID
