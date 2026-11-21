import { createBdd } from 'playwright-bdd';
import { routes } from '../../support/routes';

const { Given } = createBdd();

Given('I open the holiday entitlement calculator start page', async ({ page }) => {
  await page.goto(routes.start);
});
