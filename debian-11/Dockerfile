ARG PLAYWRIGHT_VERSION
FROM debian:11-slim

ENV PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium
RUN set -ex; \
	apt update; \
	DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
		curl \
		ca-certificates \
	# Install headful deps
		chromium \
		xvfb \
		xauth \
		; \
	ln -s /usr/bin/chromium /usr/bin/google-chrome; \
	ln -s /usr/bin/chromium /usr/bin/chromium-browser

# Install scripts
RUN set -ex; \
	apt update; \
	curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -; \
	DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y \
		nodejs \
		; \
	apt clean; \
	apt purge -y --auto-remove \
    curl \
		; \
  rm -rf /usr/share/doc; \
	rm -rf /var/lib/apt/lists/*

# Essentials for scripts
ENV NODE_PATH=/usr/lib/node_modules
RUN set -e; \
	if [ "$NODE_PATH" != "$(npm root -g)" ]; then \
		echo >&2 "NODE_PATH invalid" && exit 2; \
	fi

RUN set -e; \
	npm -g install \
		playwright@${PLAYWRIGHT_VERSION}
