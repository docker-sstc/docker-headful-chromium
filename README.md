# docker-headful-chromium

## Usage

```bash
docker run --rm \
    -v $(pwd):/app \
    -w /app \
    sstc/headful-chromium
    xvfb-run main.js
```

> main.js

```js
const { chromium } = require("playwright-chromium")

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
}

;(async () => {
  try {
    await main()
  } finally {
    process.exit()
  }
})()
```
