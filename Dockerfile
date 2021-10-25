FROM debian:stable-slim

RUN set -ex; \
	apt-get update; \
	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	tini \
	# Install chromium, https://github.com/web-platform-tests/results-collection/pull/268/files
	chromium \
	xvfb \
	xauth \
	; \
	ln -s /usr/bin/chromium /usr/bin/google-chrome; \
	ln -s /usr/bin/chromium /usr/bin/chromium-browser; \
	# Install nodejs
	curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -; \
	DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \
	nodejs npm \
	; \
	apt-get clean; \
	rm -rf /var/lib/apt/lists/*

# Essentials for scripts
ENV NODE_PATH=/usr/local/lib/node_modules
RUN set -e; \
	if [ "/usr/local/lib/node_modules" != "$(npm root -g)" ]; then \
	echo >&2 "NODE_PATH invalid" && exit 2; \
	fi
# Default playwright browsers path: https://github.com/microsoft/playwright/blob/master/src/utils/registry.ts#L185
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 \
	PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/usr/bin/chromium-browser \
	PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=1 \
	PUPPETEER_EXECUTABLE_PATH=/usr/bin/chromium-browser

RUN set -e; \
	npm -g install \
	playwright-chromium \
	puppeteer \
	puppeteer-extra \
	puppeteer-extra-plugin-stealth \
	puppeteer-extra-plugin-user-preferences \
	puppeteer-extra-plugin-user-data-dir

ENTRYPOINT ["tini", "--"]