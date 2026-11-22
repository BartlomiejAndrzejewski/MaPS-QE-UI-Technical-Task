import { test as base, createBdd } from 'playwright-bdd';
import { OutcomePage } from '../../pages/holiday-entitlement/OutcomePage';
import { QuestionPage } from '../../pages/holiday-entitlement/QuestionPage';
import { StartPage } from '../../pages/holiday-entitlement/StartPage';
import { rejectAdditionalCookies } from '../../support/cookies';

type Fixtures = {
  startPage: StartPage;
  questionPage: QuestionPage;
  outcomePage: OutcomePage;
};

export const test = base.extend<Fixtures>({
  context: async ({ context, baseURL }, use) => {
    await rejectAdditionalCookies(context, baseURL);
    await use(context);
  },
  startPage: async ({ page }, use) => {
    await use(new StartPage(page));
  },
  questionPage: async ({ page }, use) => {
    await use(new QuestionPage(page));
  },
  outcomePage: async ({ page }, use) => {
    await use(new OutcomePage(page));
  },
});

export const { Given, When, Then } = createBdd(test);
export { expect } from '@playwright/test';
