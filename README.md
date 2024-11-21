# docker-headful-chromium

[![Build workflow](https://github.com/docker-sstc/docker-headful-chromium/actions/workflows/main.yml/badge.svg)](https://github.com/docker-sstc/docker-headful-chromium/actions)
[![Docker pulls](https://img.shields.io/docker/pulls/sstc/headful-chromium.svg)](https://hub.docker.com/r/sstc/headful-chromium)

## Usage

```bash
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    sstc/headful-chromium
    xvfb-run -a bash -c "node main.mjs"
```

> main.mjs

```js
import playwright from 'playwright'
const { chromium } = playwright

const extId = 'xxxxxxxxxx'
const pathToExtension = `/app/chromium-extension/${extId}`
const entrypoint = `chrome-extension://${extId}/index.html`
const userDataDir = '/tmp/chromium'

async function main() {
  const browserContext = await chromium.launchPersistentContext(userDataDir, {
    executablePath: process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH,
    headless: false,
    args: [
      `--disable-extensions-except=${pathToExtension}`,
      `--load-extension=${pathToExtension}`
    ],
  })
  const page = await browserContext.newPage()
  await page.goto(entrypoint)
  // ...
  await browserContext.close()
}
try {
  await main()
} finally {
  process.exit()
}
```

## Refs

- ubuntu version: https://releases.ubuntu.com/
- playwright versions: https://github.com/microsoft/playwright/releases
- playwright docker build files: https://github.com/microsoft/playwright/tree/main/utils/docker
- playwright docker image tags: https://mcr.microsoft.com/en-us/artifact/mar/playwright/tags
