import { createHtmlReport } from 'axe-html-reporter';
import { expect, Then } from '../fixtures/holiday-entitlement/fixtures';
import { AXE_REPORT_DIR, describeViolations, runAxe } from '../support/accessibility';

Then('the page title should be {string}', async ({ page }, title: string) => {
  await expect(page).toHaveTitle(title);
});

Then('the {string} button should be visible', async ({ page }, name: string) => {
  await expect(page.getByRole('button', { name })).toBeVisible();
});

Then('the page should have no accessibility violations', async ({ page, $testInfo }) => {
  const results = await runAxe(page);
  const scenario = $testInfo.title.replace(/\W+/g, '-');
  createHtmlReport({
    results,
    options: {
      outputDir: AXE_REPORT_DIR,
      reportFileName: `${$testInfo.project.name}-${scenario}-retry-${$testInfo.retry}.html`,
    },
  });
  expect(describeViolations(results)).toEqual([]);
});
