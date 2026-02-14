# Stage 1 — Download
FROM alpine:3.19 AS downloader

RUN apk add --no-cache curl tar ca-certificates

WORKDIR /

# Download the WSL root filesystem
RUN curl -fL \
    https://cdimage.ubuntu.com/ubuntu-wsl/daily-live/current/resolute-wsl-amd64.wsl \
    -o rootfs.tar.gz

# Extract into /21
RUN mkdir /21 \
    && tar -xzf rootfs.tar.gz -C /21 \
    && rm rootfs.tar.gz


# Stage 2 — Final scratch image
FROM scratch

# Copy extracted filesystem into container root
COPY --from=downloader /21/ /

CMD ["/bin/bash"]
