import type { Locator, Page } from '@playwright/test';

export abstract class BasePage {
  constructor(protected readonly page: Page) { }

  get mainContent(): Locator {
    return this.page.getByRole('main');
  }

  get heading(): Locator {
    return this.mainContent.getByRole('heading', { level: 1 });
  }

  async goto(path: string): Promise<void> {
    await this.page.goto(path);
  }
}
