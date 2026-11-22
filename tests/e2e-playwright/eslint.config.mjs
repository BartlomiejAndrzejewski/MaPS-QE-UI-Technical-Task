import eslint from '@eslint/js';
import { defineConfig } from 'eslint/config';
import playwright from 'eslint-plugin-playwright';
import tseslint from 'typescript-eslint';

export default defineConfig(
  { ignores: ['.features-gen/', 'playwright-report/', 'test-results/'] },
  eslint.configs.recommended,
  tseslint.configs.recommended,
  {
    files: ['fixtures/**', 'pages/**', 'steps/**', 'support/**'],
    extends: [playwright.configs['flat/recommended']],
    languageOptions: {
      parserOptions: {
        projectService: true,
        tsconfigRootDir: import.meta.dirname,
      },
    },
    rules: { '@typescript-eslint/no-floating-promises': 'error' },
  },
  {
    // Gherkin steps call expect outside a test() block, so skip this rule.
    files: ['steps/**'],
    rules: { 'playwright/no-standalone-expect': 'off' },
  },
);
