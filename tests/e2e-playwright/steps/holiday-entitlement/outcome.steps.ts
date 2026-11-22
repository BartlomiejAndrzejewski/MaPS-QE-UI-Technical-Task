import { expect, Then } from '../../fixtures/holiday-entitlement/fixtures';

Then('the outcome should say {string}', async ({ outcomePage }, text: string) => {
  await expect(outcomePage.result).toContainText(text);
});
