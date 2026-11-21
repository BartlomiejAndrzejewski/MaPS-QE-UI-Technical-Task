import type { Locator } from '@playwright/test';
import { BasePage } from '../BasePage';

export class OutcomePage extends BasePage {
  get result(): Locator {
    return this.mainContent;
  }
}
