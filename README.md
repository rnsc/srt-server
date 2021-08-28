# Noalbs Hosting Setup for Belabox on the Jetson

The streaming folder contains the docker compose for running the containers that are needed on the endpoint side (e.g. at home or cloud).

## Updating

Just update the `.env` file and increase the version number (see changelog) and rerun.

```shell
docker compose up -d
```

## Changelog

1.1: applied critical patch from b3cks repo

1.0: first docker release

## Pre-Requirements

+ [OBS](https://obsproject.com/download)
+ [OBS WebSocket plugin](https://github.com/Palakis/obs-websocket/releases) and configure it with a password (can be randomly generate and saved into the config.json)
+ Docker for your OBS machine OS
+ Router that can Port-Forward to your OBS/SRT receiver machine (also check local firewall of the machine)

## Installation

+ Download <https://github.com/rnsc/srt-server/archive/refs/heads/main.zip> extract to a folder that will be used permamently
+ Go into the folder `streaming` in that extracted directory
+ Edit the `config.json` (see documentation for details and below table <https://github.com/715209/nginx-obs-automatic-low-bitrate-switching#using-sls-srt-live-server> ).
+ (optional) Modify the `entrypoint.sh` file if you need to change the inbound port for the srtla stream (coming from jetson, don't forget to change the port in docker-compose.yml).
+ (optional) Modify the `sls.conf` file if you wanna add more stream id's or change the name or do other things.
+ If using Docker for Windows, make sure the containers are switched to "Linux containers" (see <https://docs.docker.com/desktop/windows/#switch-between-windows-and-linux-containers>).
+ Open a Terminal (on Windows, suggestion: <https://www.microsoft.com/store/productId/9N8G5RFZ9XK3> ) browse to that directory and type:

```shell
docker-compose up -d
```

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

## OBS Confguration

Make sure you have set up the scenes in OBS with the correct names (LIVE, BRB, LOW, REFRESH).
Tweak the scenes to your taste.
On the LIVE scene, add a media source with the following properties:

+ Uncheck local file
+ srt://localhost:30000/?streamid=PUBLISHER
+ Input format should be `mpegts`
+ Check the Seekable checkbox

## Troubleshooting

+ You can still access the normal srt server without bonding feature using udp port 30000 as a fallback (you'd need to add that to portforwarding though).
+ You can access the stats page via the ip of your windows machine using port 8282 in your browser if you need to fetch the statistics (bitrate/tts) that can be used in OBS.
+ This setup is highly flexible - if you don't wanna use noalbs just configure the `docker-compose.yml` file and replace it with some other SRT solution. you can just re-configure ports and the container name via environment variables that are used in the `entrypoint.sh` file.

## Note

The other folders contain the docker build files for streaming on a jetson nano and srt setup to send stream data to the build folder contains the docker compose for building all the containers everything is opensource, there are no secrets about the setup.
