# Noalbs Hosting Setup for Belabox on the Jetson
the streaming folder contains the docker compose for running the containers that are needed on the endpoint side (e.g. at home or cloud)

## Pre-Requirements (windows)
+ OBS https://obsproject.com/download
+ Docker for Windows (it's important to check their requirements) https://docs.docker.com/docker-for-windows/install/
+ Router that can Port-Forward to your windows machine (also check windows firewall)

## Installation (windows)
+ download https://github.com/moo-the-cow/streaming/archive/refs/heads/main.zip extract do a folder that will be used permamently
+ go into the folder `streaming` in that extracted directory
+ modify the `config.json` (see documentation for details https://github.com/715209/nginx-obs-automatic-low-bitrate-switching#using-sls-srt-live-server )
+ (optional) modify the `entrypoint.sh` file if you need to change the inbound port for the srtla stream (coming from jetson)
+ (optional) modify the `sls.conf` file if you wanna add more stream id's or change the name or do other things
+ make sure docker for windows is started and the containers are switched to "linux containers" (see https://docs.docker.com/docker-for-windows/)
+ open a Terminal (suggestion: https://www.microsoft.com/store/productId/9N8G5RFZ9XK3 ) browse to that directory and type
```
docker-compose up -d
```

## Troubleshooting
+ you can still access the normal srt server without bonding feature using udp port 30000 as a fallback (you'd need to add that to portforwarding though)
+ you can access the stats page via the ip of your windows machine using port 8282 in your browser if you need to fetch the statistics (bitrate/tts) that can be used in OBS
+ the linux setup is quite similar, just skip the windows related parts
+ this setup is highly flexible - if you don't wanna use noalbs just configure the `docker-compose.yml` file and replace it with some other SRT solution. you can just re-configure ports and the container name via environment variables that are used in the `entrypoint.sh` file

## Note
the other folders contain the docker build files for streaming on a jetson nano and srt setup to send stream data to

the build folder contains the docker compose for building all the containers

everything is opensource, there are no secrets about the setup
