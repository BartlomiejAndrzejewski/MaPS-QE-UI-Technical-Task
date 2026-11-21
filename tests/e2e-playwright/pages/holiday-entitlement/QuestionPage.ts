import type { Locator } from '@playwright/test';
import { BasePage } from '../BasePage';

export class QuestionPage extends BasePage {
    get answerBox(): Locator {
      return this.mainContent.getByRole('textbox');
    }

    radio(label: string): Locator {
      return this.mainContent.getByRole('radio', { name: label, exact: true });
    }

    async chooseOption(label: string): Promise<void> {
      await this.radio(label).check();
    }

    async enterAnswer(value: string): Promise<void> {
      await this.answerBox.fill(value);
    }

    async enterDate(day: string, month: string, year: string): Promise<void> {
      await this.mainContent.getByRole('textbox', { name: 'Day' }).fill(day);
      await this.mainContent.getByRole('textbox', { name: 'Month' }).fill(month);
      await this.mainContent.getByRole('textbox', { name: 'Year' }).fill(year);
    }

    async clickContinue(): Promise<void> {
      await this.continueButton.click();
    }
}
