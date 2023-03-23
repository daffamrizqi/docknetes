FROM golang:1.18-alpine

ENV APP_PORT=8080

# WORKDIR akan membuat folder secara otomatis jika folder belum ada
WORKDIR /app
COPY main.go /app

EXPOSE ${APP_PORT}

CMD go run main.go