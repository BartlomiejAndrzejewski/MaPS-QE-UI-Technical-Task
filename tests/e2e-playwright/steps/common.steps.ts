import { expect } from '@playwright/test';
import { createBdd } from 'playwright-bdd';

const { Then } = createBdd();

Then('the page title should be {string}', async ({ page }, title: string) => {
  await expect(page).toHaveTitle(title);
});

Then('the main heading should be {string}', async ({ page }, heading: string) => {
  await expect(page.getByRole('main').getByRole('heading', { level: 1 })).toHaveText(heading);
});

Then('the {string} button should be visible', async ({ page }, name: string) => {
  await expect(page.getByRole('button', { name })).toBeVisible();
});
