import { expect } from '@playwright/test';
import { createBdd } from 'playwright-bdd';

const { Given, Then } = createBdd();

Given('I open the holiday entitlement calculator start page', async ({ page }) => {
    await page.goto('/calculate-your-holiday-entitlement');
});

Then('the page title should be {string}', async ({ page }, title: string) => {
    await expect(page).toHaveTitle(title);
});
