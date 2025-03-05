#!/bin/sh
set -e

echo "Installing pack-cli..."

download_url="https://github.com/buildpacks/pack/releases/download/v${PACK_VERSION}/pack-v${PACK_VERSION}-linux.tgz"

curl -sSL -o pack.tgz "$download_url"
mkdir -p /usr/local/bin
tar -C /usr/local/bin -xzf pack.tgz
chmod 777 /usr/local/bin/pack
chown -R root:root /usr/local/bin/pack
