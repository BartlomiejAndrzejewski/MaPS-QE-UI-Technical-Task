import { expect, Then } from '../fixtures/holiday-entitlement/fixtures';
import { describeViolations, runAxe } from '../support/accessibility';

Then('the page title should be {string}', async ({ page }, title: string) => {
  await expect(page).toHaveTitle(title);
});

Then('the {string} button should be visible', async ({ page }, name: string) => {
  await expect(page.getByRole('button', { name })).toBeVisible();
});

Then('the page should have no accessibility violations', async ({ page, $testInfo }) => {
  const results = await runAxe(page);
  await $testInfo.attach('axe-results', {
    body: JSON.stringify(results, null, 2),
    contentType: 'application/json',
  });
  expect(describeViolations(results)).toEqual([]);
});
