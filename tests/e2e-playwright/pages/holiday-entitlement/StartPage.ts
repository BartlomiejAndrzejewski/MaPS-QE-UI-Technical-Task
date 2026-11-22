import type { Locator } from '@playwright/test';
import { routes } from '../../support/routes';
import { BasePage } from '../BasePage';

export class StartPage extends BasePage {
  get startNowButton(): Locator {
    return this.page.getByRole('button', { name: 'Start now' });
  }

  async open(): Promise<void> {
    await this.goto(routes.start);
  }

  async start(): Promise<void> {
    await this.startNowButton.click();
  }
}
