# Noalbs Hosting Setup for Belabox on the Jetson

the streaming folder contains the docker compose for running the containers that are needed on the endpoint side (e.g. at home or cloud)

## Updating

just modify the `.env` file and increase the version number (see changelog)
and rerun

```shell
docker compose up -d
```

## Changelog

1.1: applied critical patch from b3cks repo

1.0: first docker release

## config.json explanation

| Parameter   |     Note   |
|----------|:-------------:|
| obs.ip |  Public or private IP of your OBS instance appended with ":4444" |
| obs.password |    password for the websocket plugin of OBS  |
| rtmp.server | type of server you're using, can be: "srt-live-server", "node-media-server", "nimble" |
| rtmp.stats  | URL for your stats server, use your OBS machine LAN IP |
| rtmp.publisher | path used to publish your stream (should be the same string as configured in belaUI) |
| twitchChat.botUsername | Username of the Twitch account you want to use for chat notifications and to accept commands |
| twitchChat.oauth | you can get an oAuth token from <https://twitchapps.com/tmi/> |
| twitchChat.adminUsers | list of Twitch chat users in your channel that are considered admins |

## Pre-Requirements (windows)

+ [OBS](https://obsproject.com/download)
+ Docker for Windows (it's important to check their requirements) <https://docs.docker.com/docker-for-windows/install/>
+ Router that can Port-Forward to your windows machine (also check windows firewall)

## Installation (windows)

+ download <https://github.com/rnsc/streaming/archive/refs/heads/main.zip> extract do a folder that will be used permamently
+ go into the folder `streaming` in that extracted directory
+ modify the `config.json` (see documentation for details <https://github.com/715209/nginx-obs-automatic-low-bitrate-switching#using-sls-srt-live-server> )
+ (optional) modify the `entrypoint.sh` file if you need to change the inbound port for the srtla stream (coming from jetson)
+ (optional) modify the `sls.conf` file if you wanna add more stream id's or change the name or do other things
+ make sure docker for windows is started and the containers are switched to "linux containers" (see <https://docs.docker.com/docker-for-windows/>)
+ open a Terminal (suggestion: <https://www.microsoft.com/store/productId/9N8G5RFZ9XK3> ) browse to that directory and type

```shell
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
