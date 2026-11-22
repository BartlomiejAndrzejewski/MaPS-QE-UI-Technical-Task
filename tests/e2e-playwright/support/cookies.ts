import type { BrowserContext } from '@playwright/test';

// Records "reject additional cookies" before the test starts, so the
// GOV.UK cookie banner never appears, even on a deep link. The cookies
// are set for the baseURL from playwright.config.ts.
export async function rejectAdditionalCookies(
  context: BrowserContext,
  baseURL: string | undefined,
): Promise<void> {
  if (!baseURL) {
    throw new Error('Set baseURL in playwright.config.ts to reject cookies.');
  }

  const policy = { essential: true, settings: false, usage: false, campaigns: false };

  await context.addCookies([
    {
      name: 'cookies_policy',
      value: JSON.stringify(policy),
      url: baseURL,
    },
    { name: 'cookies_preferences_set', value: 'true', url: baseURL },
  ]);
}
