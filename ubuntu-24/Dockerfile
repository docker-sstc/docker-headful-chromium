# https://github.com/microsoft/playwright/blob/main/utils/docker/Dockerfile.noble
# playwright version: https://github.com/microsoft/playwright/releases
# ubuntu version: https://releases.ubuntu.com/
ARG PLAYWRIGHT_VERSION
FROM mcr.microsoft.com/playwright:v${PLAYWRIGHT_VERSION}-noble

# RUN set -ex; \
# 	apt-get update; \
# 	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
# 		npm \
# 		; \
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
		playwright@${PLAYWRIGHT_VERSION}
