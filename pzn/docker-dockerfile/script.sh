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

docker container create --name env --publish 9090:9090 --env APP_PORT=9090 daffamrizqi/env
# .dockerignore File
# di dalam .dockerignore
text/*.log
text/temp


# EXPOSE Instruction
# EXPOSE hanya digunakan untuk informasi/dokumentasi pada Dockerfile
FROM golang:1.18-alpine

RUN mkdir app
COPY main.go app/
EXPOSE 8080

CMD go run app/main.go


# ENV Instruction
FROM golang:1.18-alpine

RUN mkdir app
COPY main.go app/

EXPOSE 8080

CMD go run app/main.go


# VOLUME Instruction
FROM golang:1.18-alpine

ENV APP_PORT=8080
ENV APP_DATA=/logs

RUN mkdir ${APP_DATA}
RUN mkdir app
COPY main.go app/

EXPOSE ${APP_PORT}
VOLUME ${APP_DATA}
CMD go run app/main.go


# WORKDIR Instruction
FROM golang:1.18-alpine

# WORKDIR akan membuat dir secara otomatis jika dir belum ada
WORKDIR /app
COPY main.go /app

EXPOSE ${APP_PORT}

# karena sekarang workdir menjadi app, maka command run go menjadi seperti ini
CMD go run main.go


# ARG Instruction
FROM golang:1.18-alpine

ARG app=main
ENV app=$app

RUN echo "Building with app=${app}"

RUN mkdir app
COPY main.go app/
RUN mv app/main.go app/${app}.go

EXPOSE 8080

CMD go run app/${app}.go

# saat proses build dan pass arg
docker build -t daffamrizqi/arg arg --build-arg  app=pzn
# ARG janya bisa diakses pada waktu build time, sedangkan CMD itu dijalankan saat runtime
#  Jadi saati menggunakan ARG pada CMD, kita perlu memasukan data ARG tsb ke ENV


# HEALTCHECK Instruction
FROM golang:1.18-alpine

ARG app=main
ENV app=$app

RUN echo "Building with app=${app}"

RUN mkdir app
COPY main.go app/
RUN mv app/main.go app/${app}.go

EXPOSE 8080

CMD go run app/${app}.go


# ENNTRYPOINT Instruction
FROM golang:1.18-alpine

RUN mkdir /app/
COPY main.go /app/

EXPOSE 8080

ENTRYPOINT ["go", "run"]
CMD ["/app/main.go"]


# Multi Stage Build Image
FROM golang:1.18-alpine as builder
WORKDIR /app/

# . (copy main.go to working directory)
COPY main.go .
#  command to compile golang progmram and save it into main
RUN go build -o /app/main main.go

FROM alpine:3
WORKDIR /app/
COPY --from=builder /app/main ./
CMD /app/main


