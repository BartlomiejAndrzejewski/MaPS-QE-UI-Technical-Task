import { expect, Then } from '../fixtures/holiday-entitlement/fixtures';
import { findAccessibilityViolations } from '../support/accessibility';

Then('the page title should be {string}', async ({ page }, title: string) => {
  await expect(page).toHaveTitle(title);
});

Then('the {string} button should be visible', async ({ page }, name: string) => {
  await expect(page.getByRole('button', { name })).toBeVisible();
});

Then('the page should have no accessibility violations', async ({ page }) => {
  expect(await findAccessibilityViolations(page)).toEqual([]);
});
