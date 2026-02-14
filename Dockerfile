# ---- Stage 1: Download the WSL image ----
FROM alpine:3.19 AS downloader

RUN apk add --no-cache curl

WORKDIR /download

RUN curl -L -o rootfs.tar.gz \
    https://cdimage.ubuntu.com/ubuntu-wsl/daily-live/current/resolute-wsl-amd64.wsl

# ---- Stage 2: Build final image from scratch ----
FROM scratch

# Add the downloaded rootfs as the container root filesystem
ADD --from=downloader /download/rootfs.tar.gz /

CMD ["/bin/bash"]
