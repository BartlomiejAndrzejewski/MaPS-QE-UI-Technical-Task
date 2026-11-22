import type { Locator } from '@playwright/test';
import { BasePage } from '../BasePage';

export class OutcomePage extends BasePage {
  // The result has no role or label of its own, so this covers the whole
  // main area. Check the full result sentence, because the "Your answers"
  // summary on the same page contains other text that could match by accident.
  get result(): Locator {
    return this.mainContent;
  }
}
