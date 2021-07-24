#!/bin/sh
/tmp/srtla/srtla_rec 5000 ${SRT_ENDPOINT_ADDR} ${SRT_ENDPOINT_PORT}
# & /tmp/srt/srt-live-transmit -st:yes "srt://${SRT_ENDPOINT_ADDR}:${SRT_ENDPOINT_PORT}?mode=listener&lossmaxttl=40&latency=2000" "srt://0.0.0.0:5001?mode=listener"