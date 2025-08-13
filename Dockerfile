FROM golang:1.25-alpine3.22 AS builder

RUN apk add --no-cache build-base

COPY *.go go.mod go.sum src
WORKDIR src
RUN go install -trimpath

FROM alpine:3.22

COPY --from=builder /go/bin/whoami.filippo.io /usr/local/bin/
COPY whoami.sqlite3 /usr/local/share/
ENV DB_PATH /usr/local/share/whoami.sqlite3

ENTRYPOINT ["whoami.filippo.io"]
