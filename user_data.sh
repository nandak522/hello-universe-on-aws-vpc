#!/bin/bash

set -eou pipefail

export VERSION=v1.3.3
wget https://github.com/none-da/hello-universe-go-app/releases/download/$VERSION/hello-universe-$VERSION-linux-amd64 && \
    mv hello-universe-$VERSION-linux-amd64 /usr/local/bin/hello-universe && \
    chmod +x /usr/local/bin/hello-universe && \
    nohup hello-universe > /var/log/syslog 2>&1 &
