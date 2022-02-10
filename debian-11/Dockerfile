FROM debian:11-slim

RUN set -ex; \
	apt-get update; \
	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	# Install headful deps
	xvfb \
	xauth \
	; \
	ln -s /usr/bin/chromium /usr/bin/google-chrome; \
	ln -s /usr/bin/chromium /usr/bin/chromium-browser; \
	# Install nodejs
	curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -; \
	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	nodejs npm \
	python3 \
	; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/*

# Essentials for scripts
ENV NODE_PATH=/usr/local/lib/node_modules
RUN set -e; \
	if [ "$NODE_PATH" != "$(npm root -g)" ]; then \
	echo >&2 "NODE_PATH invalid" && exit 2; \
	fi

RUN set -e; \
	npm -g install \
	playwright
