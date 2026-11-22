import type { Locator, Page } from '@playwright/test';

export abstract class BasePage {
  constructor(protected readonly page: Page) { }

  get mainContent(): Locator {
    return this.page.getByRole('main');
  }

  get heading(): Locator {
    return this.mainContent.getByRole('heading', { level: 1 });
  }

  get continueButton(): Locator {
    return this.mainContent.getByRole('button', { name: 'Continue' });
  }

  get cookieBanner(): Locator {
    return this.page.getByRole('region', { name: 'Cookies on GOV.UK' });
  }

  async rejectCookies(): Promise<void> {
    await this.cookieBanner
      .getByRole('button', { name: 'Reject additional cookies' })
      .click();
    await this.cookieBanner
      .getByRole('button', { name: 'Hide cookie message' })
      .click();
  }

  async goto(path: string): Promise<void> {
    await this.page.goto(path);
  }
}
