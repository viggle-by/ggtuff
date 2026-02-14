# syntax=docker/dockerfile:1

############################
# Stage 1 — Download rootfs
############################
FROM alpine:3.19 AS downloader

RUN apk add --no-cache curl ca-certificates tar

WORKDIR /download

# Download WSL root filesystem
RUN curl -fL \
    https://cdimage.ubuntu.com/ubuntu-wsl/daily-live/current/resolute-wsl-amd64.wsl \
    -o rootfs.tar.gz

# Verify it's a valid tar archive (fails build if corrupted)
RUN tar -tzf rootfs.tar.gz > /dev/null


##################################
# Stage 2 — Extract into scratch
##################################
FROM scratch

# Add and auto-extract rootfs into /
ADD --from=downloader /download/rootfs.tar.gz /

CMD ["/bin/bash"]
