FROM alpine:latest
LABEL maintainer="Travis Quinnelly <tquinnelly@gmail.com>"

RUN apk update && apk add clamav && apk add clamav-libunrar && apk add unrar

ENV SCANDIR=/scan
COPY scan.sh /scan.sh
ENTRYPOINT [ "sh", "/scan.sh" ]
