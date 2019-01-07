FROM arm32v6/alpine:latest
COPY qemu-arm-static /usr/bin

RUN \
  mkdir -p /build && \
  wget \
    https://apt.rb24.com/pool/main/r/rbfeeder/rbfeeder_0.2.6-20180313082038_armhf.deb \
    -O /build/rbfeeder.deb && \
  apk add \
    --no-cache \
    binutils \
    libc6-compat \
    libcurl \
    glib && \
  apk add \
    --no-cache \
    --repository 'http://dl-cdn.alpinelinux.org/alpine/edge/testing' \
    librtlsdr && \
  cd /build && \
  ar x rbfeeder.deb && \
  tar -xJf data.tar.xz && \
  cp usr/bin/rbfeeder /usr/bin && \
  apk del --no-cache binutils && \
  rm -rf \
    /usr/bin/qemu-arm-static \
    /build

CMD ["rbfeeder"]
