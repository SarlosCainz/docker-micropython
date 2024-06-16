FROM gcc as build

RUN set eux \
 && apt update \
 && apt install -y build-essential libffi-dev git pkg-config \
 && rm -rf /var/lib/apt/lists/*

RUN set eux \
 && git clone https://github.com/micropython/micropython \
 && cd micropython/mpy-cross \
 && make \
 && cd ../ports/unix \
 && make submodules \
 && make

FROM debian:bookworm-slim

COPY --from=build /micropython/ports/unix/build-standard/micropython /usr/local/bin
ENTRYPOINT ["/usr/local/bin/micropython"]
