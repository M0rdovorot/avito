FROM golang:alpine as build

ENV CGO_ENABLED=1

COPY . /project

WORKDIR /project

RUN apk add make git gcc musl-dev && make build

#================================

FROM alpine:latest

WORKDIR /

COPY ./db/migrations db/migrations
COPY --from=build /project/bin/ /bin/

CMD ["api"]