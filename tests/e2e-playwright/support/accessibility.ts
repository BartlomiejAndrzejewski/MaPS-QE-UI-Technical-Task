import AxeBuilder from '@axe-core/playwright';
import type { Page } from '@playwright/test';

// WCAG 2.0, 2.1 and 2.2 levels A and AA. Best-practice rules are left out
// because they flag GOV.UK's own skip link and feedback prompt, which sit
// outside a landmark by design.
const WCAG_TAGS = ['wcag2a', 'wcag2aa', 'wcag21a', 'wcag21aa', 'wcag22aa'];

// Returns one readable line per rule that failed, or an empty list.
export async function findAccessibilityViolations(page: Page): Promise<string[]> {
  const results = await new AxeBuilder({ page }).withTags(WCAG_TAGS).analyze();

  return results.violations.map(
    (violation) =>
      `${violation.id} (${violation.impact}): ${violation.help} - ${violation.nodes.length} element(s)`,
  );
}
