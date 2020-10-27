FROM alpine:latest

ENV MKDOCS_VERSION=1.1.2 \
    DOCS_DIRECTORY='/mkdocs' \
    LIVE_RELOAD_SUPPORT='false' \
    ADD_MODULES='false' \
    FAST_MODE='false' \
    PYTHONUNBUFFERED=1 \
    GIT_REPO='false' \
    GIT_BRANCH='master' \
    AUTO_UPDATE='false' \
    UPDATE_INTERVAL=15

ADD container-files/ /

RUN \
    sed -i -e 's/v[[:digit:]]\..*\//edge\//g' /etc/apk/repositories
    apk add --update \
    ca-certificates \
    bash \
    git=2.29.1-r0 \
    openssh \
    python3 \
    python3-dev \
    py3-pip \
    build-base && \
    pip install --upgrade pip && \
    pip install mkdocs==${MKDOCS_VERSION} && \
    cd /bootstrap && pip install -e /bootstrap && \
    rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/* && \
    chmod 600 /root/.ssh/config

CMD ["/usr/bin/bootstrap", "start"]
