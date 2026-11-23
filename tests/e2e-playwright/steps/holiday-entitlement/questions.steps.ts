import { expect, When, Then } from '../../fixtures/holiday-entitlement/fixtures';

When('I select {string} and continue', async ({ questionPage }, option: string) => {
  await questionPage.chooseOption(option);
  await questionPage.clickContinue();
});

When('I enter {string} and continue', async ({ questionPage }, answer: string) => {
  await questionPage.enterAnswer(answer);
  await questionPage.clickContinue();
});

When(
  'I enter the date {string} {string} {string} and continue',
  async ({ questionPage }, day: string, month: string, year: string) => {
    await questionPage.enterDate(day, month, year);
    await questionPage.clickContinue();
  },
);

When('I continue without answering', async ({ questionPage }) => {
  await questionPage.clickContinue();
});

Then('I should see the error {string}', async ({ questionPage }, message: string) => {
  await expect(questionPage.errorMessage).toContainText(message);
});

Then('I should be asked {string}', async ({ questionPage }, question: string) => {
  await expect(questionPage.heading).toContainText(question);
});
