# docker image bisa dicari pada hub.docker.com

# FROM instruction
from/Dockerfile
1. FROM alpine:3
- FROM imageName:tag
- For building build stage

2. docker build -t daffamrizqi/from from
- -t = imageName/tag folder

# RUN instruction
# flow 1
1. RUN mkdir data
- create dir named data
2. RUN echo "hello data" > "data/world.txt"
- print hello data and put it in file named world.txt inside data directory
3. RUN cat "data/world.txt"
- read data/world.txt
4. docker build -t daffamrizqi/run run

# flow 2 (cached argument and progress=plain)
docker build -t daffamrizqi/run run --progress=plain --no-cache


