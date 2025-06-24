import { chromium } from 'playwright'

async function main() {
  // https://github.com/microsoft/playwright/blob/main/packages/playwright-core/src/cli/program.ts#L347
  const browserServer = await chromium.launchServer({
    executablePath: process.env.PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH,
    headless: false,
    host: '0.0.0.0',
    port: 3000,
    wsPath: '/',
    // _userDataDir: '/tmp'
  })
  const wsEndpoint = browserServer.wsEndpoint()
  console.log(wsEndpoint)
}
try {
  await main()
} catch (e) {
  console.error(e)
}
