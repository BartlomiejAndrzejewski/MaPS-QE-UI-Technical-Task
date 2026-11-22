import { expect, Given, Then } from '../../fixtures/holiday-entitlement/fixtures';

Given('I open the holiday entitlement calculator start page', async ({ startPage }) => {
  await startPage.open();
});

Given('I start the calculator', async ({ startPage }) => {
  await startPage.open();
  await startPage.start();
});

Then('the main heading should be {string}', async ({ startPage }, heading: string) => {
  await expect(startPage.heading).toHaveText(heading);
});
