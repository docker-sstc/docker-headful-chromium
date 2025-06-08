ARG PLAYWRIGHT_VERSION
FROM mcr.microsoft.com/playwright:v${PLAYWRIGHT_VERSION}-jammy

# Essentials for scripts
ENV NODE_PATH=/usr/lib/node_modules
RUN set -e; \
	if [ "$NODE_PATH" != "$(npm root -g)" ]; then \
		echo >&2 "Invalid \$NODE_PATH: $NODE_PATH" && exit 2; \
	fi

RUN set -e; \
	npm -g install \
		playwright@${PLAYWRIGHT_VERSION}
