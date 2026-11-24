# MaPS QE UI Technical Task

Your task is to create a functional automated UI test suite.

There are no trick questions; we want to see your solution work, analyse your code structure, and understand your thought process.

We are aware that AI can be used to help with this, and we welcome constructive use of AI tools. If you want some guidance as to how we use AI, please refer to the Civil Service's AI in Recruitment guidance page: https://www.civil-service-careers.gov.uk/artificial-intelligence-and-recruitment/

Where to find things: the test suite is described under
[Running the Playwright tests](#running-the-playwright-tests), the Part 2
audit is in [Part 2: accessibility audit](#part-2-accessibility-audit), and my
notes on the approach are in
[Approach and further considerations](#approach-and-further-considerations).

## Running the Playwright tests

Playwright and TypeScript tests, written as Gherkin scenarios with
[playwright-bdd](https://vitalets.github.io/playwright-bdd/), for the GOV.UK
[Calculate your holiday entitlement](https://www.gov.uk/calculate-your-holiday-entitlement)
page. Running `npm test` generates the tests from the feature files, then runs
them. The suite contains a smoke scenario for the start page, five
click-through journeys through the calculator, validation scenarios that
check the error messages for invalid answers, calculation scenarios that
check the entitlement for different working patterns, and accessibility
scenarios that run axe and match an ARIA snapshot on the calculator pages.

### Prerequisites
- [Node.js](https://nodejs.org/) with npm: version 22.13+ or 24+
  (Node 23 is not supported). Developed with Node v26; the latest
  LTS release is recommended.
- Git
- An internet connection: the tests run against gov.uk, and the setup
  downloads the Playwright browsers, which take several hundred megabytes. On
  Linux, install the browsers with `npx playwright install --with-deps` so
  that the system libraries are included.

Developed and tested locally on Windows 11 with Visual Studio. CI runs on
Ubuntu.

### Setup
1. Go to the test project:
   ```bash
   cd tests/e2e-playwright
   ```
2. Install dependencies, in this folder and not the repository root. This
   installs everything the tests need, including playwright-bdd:
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

The tests run against https://www.gov.uk by default. Set the `BASE_URL`
environment variable to use another address.

The accessibility scenarios compare each page with an ARIA snapshot in
`tests/e2e-playwright/snapshots`, in one folder for each feature folder. Each
snapshot keeps a page's heading, text, controls, error alert and buttons, and
leaves out lists of links to other pages and the answers summary, which
change more often. If a page changes on purpose, run
`npm run accessibility -- --update-snapshots`. It rewrites only the snapshots
that no longer match, as the full page, so trim those files again. Use
`--update-snapshots=missing` to create the snapshot for a new page.

Useful variations:
```bash
npm test                                   # everything, on all three browsers
npm run chromium                           # Chromium only
npm run firefox                            # Firefox only
npm run webkit                             # WebKit only
npm run headed                             # watch the browser
npm run ui                                 # open Playwright's UI mode
npm run smoke                              # smoke scenarios only
npm run regression                         # the full regression suite
npm run journey                            # click-through journeys only
npm run validation                         # validation scenarios only
npm run calculation                        # calculation scenarios only
npm run accessibility                      # accessibility scenarios only
npm run holiday-entitlement                # holiday entitlement service only
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
| `snapshots/` | ARIA snapshots of the pages, in one folder for each feature folder |

### Tags
| Kind | Tags | Use |
|---|---|---|
| Service | `@holiday-entitlement` | Run one service |
| Suite | `@smoke`, `@regression` | Choose how much to run |
| Type | `@journey`, `@validation`, `@calculation`, `@accessibility` | The kind of check |

### Cookie banner
Each test starts with the GOV.UK cookie preference set to "reject additional
cookies" (see `support/cookies.ts`), so the banner never appears, the tests do
not have to deal with it, and test runs do not send analytics. The banner
itself is not tested.

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
artifact. The accessibility scenarios also write an axe report for each page,
which CI uploads as the `axe-reports` artifact.

CI runs the tests with two workers to keep the run short. Locally the tests run
with Playwright's default number of workers.

Pull requests run the tests on Chromium only, to give faster feedback. Pushes
to `main` run all three browsers.

### Troubleshooting
- On Windows PowerShell, if `npm` is blocked by the execution policy, run
  `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned`, or use
  Command Prompt.
- On Windows PowerShell, put tags in quotes if you use `--grep` directly, for
  example `npm test -- --grep "@smoke"`, because `@` has a special meaning
  there. The tag scripts, such as `npm run smoke`, do not need quotes.

> The `npm start` steps further down are only for the local accessibility page
> (Part 2). Run them from the repository root, not from `tests/e2e-playwright`.
> The Part 2 audit is in [Part 2: accessibility audit](#part-2-accessibility-audit).

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

## Part 2: accessibility audit
The accessibility findings, including a formal bug report (BUG-001), are in
[docs/accessibility-audit.md](docs/accessibility-audit.md). The evidence
(screenshots and reports from Lighthouse, axe, WAVE and Accessibility Insights)
is in [docs/evidence](docs/evidence/), with a log of each test in
[docs/evidence/README.md](docs/evidence/README.md).

## Approach and further considerations

### Approach
- **Playwright, TypeScript and Gherkin.** The scenarios are written in
  plain English with playwright-bdd, so someone who does not read code can
  still see what is checked. Examples tables hold the data, so adding a case
  is one new row.
- **Page objects hold locators and actions only; assertions live in the
  steps.** Locators use roles and accessible names, with no CSS or XPath.
  Fixtures give each step its page objects, and each test starts with a
  fresh browser context, so tests do not depend on each other.
- **The cookie banner is switched off for every test.** Each test starts with
  the "reject additional cookies" preference already set, so the banner never
  appears, test runs stay stable and no analytics are sent. Nothing checks the
  banner itself.
- **Tags and npm scripts** (`npm run smoke`, `npm run accessibility` and so
  on) let anyone run one kind of check with a short command, without needing
  to know Playwright's command-line options.
- **Quality checks.** TypeScript runs in strict mode, ESLint includes the
  Playwright rules and catches unawaited promises, and an `.editorconfig`
  keeps indentation the same in every editor and adds a final newline to each
  code and config file. CI runs the type check, lint and the suite.
  Dependabot proposes dependency updates. Every change went through a pull
  request, and GitHub Copilot reviewed them as a reviewer, using the
  instructions in `.github/copilot-instructions.md`.
- **A readable git history.** Commit messages follow the rules in
  [How to Write a Git Commit Message](https://cbea.ms/git-commit/): a short
  imperative subject, a body that says what and why, and lines wrapped for
  reading. A pull request template asks for what changed, why, how and how it
  was tested, so each pull request explains itself. My pull requests were
  squash merged, so each of my changes is one clear commit on `main`.

### How I used AI
I used AI tools, as the brief welcomes:
- **Claude (Sonnet 5.5)** generated boilerplate and first drafts of the page
  objects. I verified each one by hand, running the tests and checking the
  locators against the live page.
- **GitHub Copilot** reviewed the pull requests, using the instructions in
  `.github/copilot-instructions.md`. I reviewed each comment thoroughly to
  check that it was correct and made sense, replied to it and made the
  changes myself, without using its automatic fix buttons.
- I also used Claude to explain options and to draft wording, including parts
  of this README. I edited the text and checked it against the repository.

### What is covered
The suite has 62 test cases on each browser, counting every example row, and
runs on three browsers (186 tests): 1 smoke, 5 journeys, 19 validation, 32
calculation and 5 accessibility.
- **Smoke:** the start page loads with its title, heading and Start now
  button.
- **Journeys:** five click-through journeys from the start page to a result:
  days worked per week, hours worked per week, annualised hours, a part-year
  start, and irregular hours for one pay period.
- **Calculations:** every working pattern has at least one test that checks
  the entitlement the calculator returns. The days worked per week pattern
  also covers the 28-day cap and part-year starting, leaving and both.
- **Validation:** the error messages for blank answers, out-of-range
  numbers, impossible dates and inconsistent dates.
- **Accessibility:** axe checks the start, a question, a date question, an
  error and an outcome page against WCAG 2.2 A and AA, and an ARIA snapshot
  checks the structure of each page's main content.

### What is not covered
- Part-year calculations for the hours, compressed hours, shifts and
  annualised hours patterns, and a few less common validation rules.
- Changing an answer or using the back button part way through.
- The cookie banner itself. The tests set the "reject additional cookies"
  preference before each test, so the banner never appears and no analytics
  are sent, but nothing checks that the banner works.
- The axe checks cover only part of WCAG 2.2, on five pages in one state
  each. They do not judge content, such as whether alt text makes sense, and
  they cannot test keyboard use, zoom or screen readers. Uncertain results
  are not checked either. Those need manual testing, as the Part 2 audit
  shows.

### Things I noticed in the calculator
These are observations from testing, not confirmed defects:
- Hours worked per week of `0.4` is accepted, although the error for `0`
  says "Please enter at least .5 hours worked".
- Hours such as `37.25` are accepted, although the error message says "Do not
  enter fractions" and the hint only mentions half-hours, for example 40.5.
- The pay period question has no upper limit: 100000 hours returns an
  entitlement of 12070 hours.

### Working with a live site
The tests run against gov.uk, so a wording change on the site can fail a
test without any fault in the suite, and the expected messages and figures
would then need updating. A few tests on Firefox have failed once and passed
on a retry. In the one failure I read, the next page had not appeared within
the five-second assertion timeout. CI retries failed tests twice, so
those runs pass. I would look at the first failure of each flaky test before
changing any timeouts.

### CI choices
CI uses two workers, as a middle ground between speed and load on a public
site. A new axe release can add rules and fail pages that passed before. The
lock file pins the versions, and Dependabot proposes updates in a pull
request.

### With more time
- Add the other part-year patterns and the remaining validation rules.
- Test changing an answer from the results summary and using the back
  button part way through a calculation.
- Cover more date boundaries, such as leap years and leave years that cross
  a year end.
- Extend the axe checks and ARIA snapshots to more calculator pages, such as
  the leave year start, the pay period hours and the shift questions.
- Test the cookie banner, which the suite hides for every test.
- If a second service were added, I would move the shared fixtures, such as
  the cookie setup, into a base fixtures file that each service extends.
- If the repository grew into a monorepo with more packages or services, I
  would weigh npm workspaces against pnpm workspaces. pnpm adds shared
  dependency versions, a stricter `node_modules` and commands that run only
  in the packages that changed.
- Test the Part 2 page with screen readers such as JAWS, NVDA and VoiceOver.

## 🕗 Time Allocation

There's no strict time limit for completing this task before the specified deadline given, we don't expect an extensive number of tests, but a well-rounded selection is appreciated.

If you have the time and inclination, feel free to attempt Task 2 (bonus task), also provide any additional thoughts on your framework solution, with any further considerations you would take in to account if you had more time.

## 📨 Presenting/Submitting Your Solution

Please email your solution with a public link to the Github repository you have created for the project. Any issues please do get in touch with the recruiter you have been speaking with.
