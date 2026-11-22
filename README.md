# MaPS QE UI Technical Task

Your task is to create a functional automated UI test suite.

There are no trick questions; we want to see your solution work, analyse your code structure, and understand your thought process.

We are aware that AI can be used to help with this, and we welcome constructive use of AI tools. If you want some guidance as to how we use AI, please refer to the Civil Service's AI in Recruitment guidance page: https://www.civil-service-careers.gov.uk/artificial-intelligence-and-recruitment/

## Running the Playwright tests

Playwright and TypeScript tests, written as Gherkin scenarios with
[playwright-bdd](https://vitalets.github.io/playwright-bdd/), for the GOV.UK
[Calculate your holiday entitlement](https://www.gov.uk/calculate-your-holiday-entitlement)
page. Running `npm test` generates the tests from the feature files, then runs
them. The suite contains a smoke scenario for the start page and five
click-through journeys through the calculator.

### Prerequisites
- [Node.js](https://nodejs.org/) with npm: version 20.19+, 22.13+ or 24+
  (odd-numbered releases such as 21 and 23 are not supported). Developed
  with Node v26; the latest LTS release is recommended.
- Git

### Setup
1. Go to the test project:
   ```bash
   cd tests/e2e-playwright
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Install the Playwright browsers:
   ```bash
   npm run install:browsers
   ```

### Run the tests
From tests/e2e-playwright:

```bash
npm test
```

The generated tests are written to `tests/e2e-playwright/.features-gen`, which
git ignores. Don't edit them: change the feature files and steps instead.

Useful variations:
```bash
npm test -- --project=chromium             # one browser only
npm test -- --headed                       # watch the browser
npm test -- --grep "@smoke"                # smoke scenarios only
npm test -- --grep "@holiday-entitlement"  # one service only
```

### Project structure
Everything lives in `tests/e2e-playwright`. The features, steps, pages and
fixtures folders each have one subfolder per service, so more services can be
added alongside holiday entitlement.

| Folder | Contents |
|---|---|
| `features/` | Gherkin feature files |
| `steps/` | Step definitions (`common.steps.ts` is shared by all services) |
| `pages/` | Page objects, with locators and actions only |
| `fixtures/` | Fixtures that give each step its page objects |
| `support/` | Shared helpers and constants, such as routes and cookie preferences |

### Tags
| Kind | Tags | Use |
|---|---|---|
| Service | `@holiday-entitlement` | Run one service |
| Suite | `@smoke`, `@regression` | Choose how much to run |
| Type | `@journey` | The kind of check |

### Cookie banner
Each test starts with the GOV.UK cookie preference set to "reject additional
cookies" (see `support/cookies.ts`), so the banner never appears and test runs
do not send analytics.

### View the report
```bash
npm run test:report
```

### Type check
From tests/e2e-playwright:

```bash
npm run typecheck
```

### Lint
From tests/e2e-playwright:

```bash
npm run lint
```

ESLint checks the pages, steps, fixtures and support folders, including the
Playwright rules and unawaited promises. No output means no problems.

### Continuous integration
On every push and pull request to `main`, GitHub Actions type-checks and lints
the code and then runs the suite. The HTML report is uploaded as a build
artifact.

### Troubleshooting
- On Windows PowerShell, if `npm` is blocked by the execution policy, run
  `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`, or use
  Command Prompt.
- On Windows PowerShell, put tags in quotes, for example
  `npm test -- --grep "@smoke"`, because `@` has a special meaning there.

> The `npm start` steps further down are only for the local accessibility page
> (Part 2). Run them from the repository root, not from `tests/e2e-playwright`.

## 📝 The Task - Part 1

On a public facing UK Government webpage 'Calculate your holiday entitlement', please write a working automated UI test suite. 

You have autonomy on this task, the only remits are that you provide a working solution and clear instructions on how to build and execute your solution.

We are looking for a demonstration of your technical skills, your ability to write a clear working solution that can be shared, and your 'tester mindset'. We would like to see evidence of:
* Maintenable Code
* Readable Code
* Scalable Code
* Best Practices

The URL for 'Calculate your holiday entitlement': https://www.gov.uk/calculate-your-holiday-entitlement

## 🎢 The Task - Part 2 (bonus task)

At MaPS, we prioritise Accessibility. While we understand that not everyone may meet our understanding of the subject, we are eager to gauge your knowledge and awareness in this area.

Task two is to launch the basic web page we have created 'index.html' and provide us with a list of Accessibility issues/bugs you can find.

You can provide your list of answers anywhere you like, but tell us where you have put them. (e.g. within you README.md). Finally please provide at least one of them in the format of a Bug report. (doesn't have to be more then 1 in this format, the others can just be a quick list).

#### Page Launch Instructions

To launch the page locally, follow these simple steps:

1. Install dependencies:
   ```bash
   npm install
   ```
2. Start the application:
   ```bash
   npm start
   ```
3. Open your web browser and navigate to:
   ```bash
   http://localhost:8080/
   ```

## 🕗 Time Allocation

There's no strict time limit for completing this task before the specified deadline given, we don't expect an extensive number of tests, but a well-rounded selection is appreciated.

If you have the time and inclination, feel free to attempt Task 2 (bonus task), also provide any additional thoughts on your framework solution, with any further considerations you would take in to account if you had more time.

## 📨 Presenting/Submitting Your Solution

Please email your solution with a public link to the Github repository you have created for the project. Any issues please do get in touch with the recruiter you have been speaking with.
