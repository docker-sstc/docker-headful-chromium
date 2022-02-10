# https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.focal
FROM mcr.microsoft.com/playwright:v1.18.1-focal

# RUN set -ex; \
# 	apt-get update; \
# 	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
# 	; \
# 	apt-get clean; \
# 	rm -rf /var/lib/apt/lists/*

# Essentials for scripts
ENV NODE_PATH=/usr/lib/node_modules
RUN set -e; \
	if [ "$NODE_PATH" != "$(npm root -g)" ]; then \
	echo >&2 "NODE_PATH invalid" && exit 2; \
	fi

RUN set -e; \
	npm -g install \
	playwright
