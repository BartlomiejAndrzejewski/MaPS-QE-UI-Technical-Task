import type { BrowserContext } from '@playwright/test';

// Records "reject additional cookies" before the test starts, so the
// GOV.UK cookie banner never appears, even on a deep link.
export async function rejectAdditionalCookies(context: BrowserContext): Promise<void> {
  const policy = { essential: true, settings: false, usage: false, campaigns: false };

  await context.addCookies([
    {
      name: 'cookies_policy',
      value: encodeURIComponent(JSON.stringify(policy)),
      domain: 'www.gov.uk',
      path: '/',
    },
    {
      name: 'cookies_preferences_set',
      value: 'true',
      domain: 'www.gov.uk',
      path: '/',
    },
  ]);
}
