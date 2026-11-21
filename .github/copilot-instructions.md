# Code review instructions

This repository is a Playwright (TypeScript) UI test suite for the gov.uk
holiday entitlement calculator, plus a small static page used for an
accessibility audit.

## Review behaviour
- Review every changed file. Do not stop after the first finding.
- Prioritise correctness and security over style.
- Comment on the exact line, explain why it matters, and suggest a fix.
- Prefix each comment with [blocker], [should-fix] or [non-blocking].
- Flag unrelated changes that belong in a separate pull request.

## Commit and pull request conventions
- Report violations as findings. Do not rewrite messages.
- If commit history is unavailable, say it could not be checked. Do not guess.
- Subject: 50 characters or fewer, capitalised, imperative, no trailing period.
- Body, if present: separated by a blank line, wrapped at about 72 characters,
  explains what and why, and may use bullets.
- The final squashed message must meet the same rules.
- The pull request title is imperative. The description follows the
  repository's pull request template.

## Correctness and types
- Flag a missing `await`, unhandled promise rejections and swallowed errors.
- Flag `any`, unsafe casts and non-null assertions that hide real nullability.

## Playwright practices
- Prefer `getByRole`, `getByLabel` and `getByText` over CSS or XPath selectors.
- Flag hard-coded waits such as `waitForTimeout`. Use auto-waiting and
  web-first assertions.
- Page objects hold locators and actions only. Assertions belong in specs.
- Test data belongs in data files, not repeated in specs.
- Tests must be independent and must not rely on execution order.

## Security
- No secrets, tokens or personal data hard-coded, logged or committed.

## Tests and docs
- Flag tests with weak or missing assertions.
- Check that README instructions are accurate and runnable.

## Avoid
- Do not suggest switching tools or rewriting the framework.
