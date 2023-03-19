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


# CMD Instruction
FROM alpine:3

RUN mkdir "data"
RUN echo "hello data" > "data/world.txt"

CMD cat "data/world.txt"

docker build -t daffamrizqi/cmd command

- saat dijalankan seharusnya container langsung mati karena hanya menjalankan cat
- untuk melihat hasil cat bisa dengan docker container logs containerName
- detail CMD intruction bisa dilihat dengan docker container inspect containerName


# LABEL Instruction
FROM alpine:3

LABEL author="Daffa Muhammad Rizqi"
LABEL company="Circular Economy Indonesia" position="CTO"

RUN mkdir "data"
RUN echo "hello data" > "data/world.txt"

CMD cat "data/world.txt"

- detail LABEL instruction yang sudah dibuat bisa dilihat saat docker container inspect containerName


# ADD Instruction
FROM alpine:3

RUN mkdir hello
ADD text/*.txt hello/
- add text (sourceFile) -> add all file ends with .txt format inside text directory into 
a directory called hello created by RUN Instruction -> cat hello.txt inside hello directory

CMD cat "hello/hello.txt"
