FROM ubuntu:18.04

ENV MATTERBRIDGE_VERSION 1.16.1
ENV SIGIL_VERSION 0.4.0
ENV TINI_VERSION v0.18.0

WORKDIR /app

RUN apt update && apt install -y curl && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /bin/tini
ADD https://github.com/42wim/matterbridge/releases/download/v${MATTERBRIDGE_VERSION}/matterbridge-${MATTERBRIDGE_VERSION}-linux-arm64 /bin/matterbridge
RUN chmod +x /bin/matterbridge /bin/tini

RUN curl -L "https://github.com/gliderlabs/sigil/releases/download/v${SIGIL_VERSION}/sigil_${SIGIL_VERSION}_$(uname -sm|tr \  _).tgz" \
    | tar -zxC /bin

COPY run /app/run
COPY matterbridge.toml.sigil /app/matterbridge.toml.sigil

ENTRYPOINT ["/bin/tini", "--"]
