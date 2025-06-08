import { chromium } from 'playwright'

async function main() {
  const browser = await chromium.connect('ws://127.0.0.1:3000/')
  const browserContext = await browser.newContext()
  const page = await browserContext.newPage()
  await page.goto('https://google.com')
  await page.pdf({ path: import.meta.filename + '.pdf' })
  await browserContext.close()
  await browser.close()
}
try {
  await main()
} catch (e) {
  console.error(e)
}
