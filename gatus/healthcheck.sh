#!/bin/sh

LOG_DIR=/var/log/gatus
mkdir -p $LOG_DIR

response=$(printf "GET /health HTTP/1.1\r\n\r\n" | nc localhost $PORT)

code=$(echo "$response" | grep -i HTTP/ | cut -d' ' -f2)

OK=$(echo $response | grep -c '200 OK')
UP=$(echo $response | grep -c 'UP')

printf "$(date)\n=== Response ===\n$response\n\n\n" >> $LOG_DIR/healthcheck.log

if [ $OK  -eq 1 ] && [ $UP  -eq 1 ]; then
    exit 0
else
    printf "$(date)\n=== ERROR ===\n$response\n\n\n" >> $LOG_DIR/unhealthy.log
    [[ $code -ge 300 ]] && exit $(($code - 300)) || exit $code
fi
