FROM ubuntu:18.04


WORKDIR /app

RUN apt update && apt install -y curl file && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN curl -L "https://github.com/gliderlabs/sigil/releases/download/v0.4.0/sigil_0.4.0_Linux_x86_64.tgz" | tar -zxC /bin
ADD https://github.com/krallin/tini/releases/download/v0.18.0/tini /bin/tini
ADD https://github.com/42wim/matterbridge/releases/download/v1.22.0/matterbridge-1.22.0-linux-64bit /bin/matterbridge
RUN chmod +x /bin/matterbridge /bin/sigil /bin/tini

COPY Procfile run /app/
COPY matterbridge.toml.sigil /app/matterbridge.toml.sigil

ENTRYPOINT ["/bin/tini", "--"]
