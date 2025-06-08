import { chromium } from 'playwright'

// - Download: https://chromewebstore.google.com/category/extensions
// - Goto: chrome://extensions/
// - Copy extension folder:
//   - C:\Users\[YOURUSERNAME]\AppData\Local\Google\Chrome\User Data\Default\Extensions
//   - C:\Users\[YOURUSERNAME]\AppData\Local\Google\Chrome\User Data\Default\[Profile]\Extensions
const extId = 'ophjlpahpchlmihnnnihgmmeilfjmjjc'
const pathToExtension = `/app/chromium-extensions/${extId}/3.7.0_0`
const entrypoint = `chrome-extension://${extId}/index.html`
const userDataDir = '/tmp'

async function main() {
  const browserContext = await chromium.launchPersistentContext(userDataDir, {
    executablePath: process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH,
    headless: false,
    bypassCSP: true,
    timeout: 10000,
    args: [
      `--disable-extensions-except=${pathToExtension}`,
      `--load-extension=${pathToExtension}`,
      // '--disable-gpu',
      // '--no-sandbox',
    ],
  })
  const page = await browserContext.newPage()
  await page.goto(entrypoint, { timeout: 5000 })
  await page.waitForSelector('input[name="email"]')
  await page.pdf({ path: import.meta.filename + '.pdf' })
  await browserContext.close()
}
try {
  await main()
} catch (e) {
  console.error(e)
}
