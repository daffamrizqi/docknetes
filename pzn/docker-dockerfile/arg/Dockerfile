FROM golang:1.18-alpine

ARG app=main
ENV app=$app

RUN echo "Building with app=${app}"

RUN mkdir app
COPY main.go app/
RUN mv app/main.go app/${app}.go

EXPOSE 8080

CMD go run app/${app}.go
