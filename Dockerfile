# Stage 1 — Download
FROM alpine:3.19 AS downloader

RUN apk add --no-cache curl tar ca-certificates

WORKDIR /

# Download the WSL root filesystem
RUN curl -fL \
    https://cdimage.ubuntu.com/ubuntu-wsl/daily-live/current/resolute-wsl-amd64.wsl \
    -o rootfs.tar.gz

# Extract it directly into /
RUN tar -xzf rootfs.tar.gz \
    && rm rootfs.tar.gz


# Stage 2 — Final scratch image
FROM scratch

# Copy entire extracted filesystem
COPY --from=downloader / /

CMD ["/bin/bash"]
