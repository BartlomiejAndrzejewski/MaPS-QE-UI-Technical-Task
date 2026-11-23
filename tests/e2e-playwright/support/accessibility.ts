import AxeBuilder from '@axe-core/playwright';
import type { Page } from '@playwright/test';
import type { AxeResults } from 'axe-core';

// WCAG 2.0, 2.1 and 2.2 levels A and AA. Best-practice rules are left out
// because they flag GOV.UK's own skip link and feedback prompt, which sit
// outside a landmark by design.
const WCAG_TAGS = ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa', 'wcag22aa'];

// Keep in sync with .gitignore and the artifact path in the CI workflow.
export const AXE_REPORT_DIR = 'axe-reports';

export async function runAxe(page: Page): Promise<AxeResults> {
  return new AxeBuilder({ page }).withTags(WCAG_TAGS).analyze();
}

// One readable line per rule that failed, or an empty list.
export function describeViolations(results: AxeResults): string[] {
  return results.violations.map(
    (violation) =>
      `${violation.id} (${violation.impact}): ${violation.help} - ${violation.nodes.length} element(s)`,
  );
}
