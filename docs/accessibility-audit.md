# Accessibility audit: public/index.html

**Page tested:** `public/index.html`, served with `npm start` at http://localhost:8080/
**Browser:** Chrome 158.0.8127.37 (64-bit), Windows 11
**Tested on:** 22 and 23 November 2026
**Standard:** WCAG 2.2 (levels A and AA). The automated tools applied the WCAG 2.1 AA
ruleset, which has the same criteria numbers for everything found here.
**Evidence:** Codes such as `03a` refer to the screenshots and reports in
[docs/evidence](evidence/). Each test is described in the
[evidence log](evidence/README.md).

## How I tested

| Method | Evidence |
|---|---|
| Keyboard-only use (Tab, Shift+Tab, Enter, Space) and the Console | `01`, `02` |
| Zoom to 300% and 400%, and an iPhone SE (375px) view | `09` |
| Chrome DevTools: Elements, Accessibility pane, Computed, Issues | `03` |
| Lighthouse 13.5.0 | `04` |
| axe DevTools (axe-core 4.13.0) | `05` |
| WAVE | `06` |
| Accessibility Insights for Web (FastPass) | `07` |
| WebAIM Contrast Checker | `08` |
| Network tab | `10` |

## Summary

I found **21 issues: 4 high, 7 medium and 10 low**. Lighthouse and axe together
found 5 of the 21. Chrome's Issues panel found two more (findings 14 and 19), and
WAVE found the missing form labels (finding 1). Accessibility Insights found the
same three issues as axe. The rest came from manual testing, which is why a tool
run alone would not be enough: no automated tool detected the blocked scrolling,
the lack of reflow, the faint focus ring or the silent Done button.

A formal bug report is at the end of this file ([BUG-001](#bug-001)).

## Findings

### High

| # | Issue | WCAG | Evidence |
|---|---|---|---|
| 1 | **The form fields have no labels.** Full name, Email and Your message are identified only by a placeholder, which disappears once the user types. See BUG-001. | 1.3.1, 3.3.2, 4.1.2 | `03a`, `03b`, `06a`, `06b` |
| 2 | **The page does not reflow.** It keeps its two-column layout at 300%, 400% and at phone width. Widths are fixed (800px section, 700px image, 300px fields) and there are no `@media` queries. | 1.4.10 | `09a`, `09b`, `09e`, `09f` |
| 3 | **Scrolling is blocked.** `overflow: hidden` on the `<body>` stops the mouse wheel and trackpad scrolling the page. When zoomed in, content below the heading is out of reach by mouse. After zooming back out, the page stays scrolled down; reloading restores it, but tabbing back to the first field does not bring the heading back into view. | 1.4.4, 1.4.10 | `03a`, `09a`, `09c`, `09d` |
| 4 | **The image has no alt text.** `<img class="contact-image">` has no `alt` attribute. | 1.1.1 | `03a`, `04a`, `05a`, `06a`, `07a` |

### Medium

| # | Issue | WCAG | Evidence |
|---|---|---|---|
| 5 | **No `lang` attribute on `<html>`**, so screen readers cannot choose the right pronunciation. | 3.1.1 | `03a`, `04b`, `05b`, `06a`, `07a` |
| 6 | **No `<title>`.** | 2.4.2 | `03a`, `04b`, `05b`, `06a`, `07a` |
| 7 | **Placeholder text has low contrast.** `#aaaaaa` on white is 2.32:1, below the 4.5:1 minimum and also below 3:1. | 1.4.3 | `08a` |
| 8 | **The focus indicator is very faint.** The page has no focus style, so it relies on Chrome's default ring (1px `rgb(16, 16, 16)`), which blends into the controls' `#333` border (about 1.5:1). It is visible, so 2.4.7 is arguable, but the contrast is too low. | 2.4.7, 1.4.11 | `01a` to `01f`, `03d`, `07d`, `08b` |
| 9 | **The Done button fails silently.** `onclick="submitForm()"` calls a function that does not exist, so each press logs `Uncaught ReferenceError: submitForm is not defined` and the user gets no message. | 4.1.3 | `02a`, `02b` |
| 10 | **No viewport meta tag.** On a phone the browser lays the page out at about 980px and shrinks it, so the text is about 38% of its normal size. | 1.4.10 | `03a`, `09e`, `09f` |
| 11 | **No main landmark, and the content is not in any landmark.** There is only a `<div id="main">`. | Best practice (supports 2.4.1) | `04b`, `05f`, `05g`, `06a` |

### Low

| # | Issue | WCAG | Evidence |
|---|---|---|---|
| 12 | **No level-one heading.** The only heading is an `<h2>`. | Best practice (1.3.1, 2.4.6) | `05g`, `06a` |
| 13 | **The fields have no `autocomplete`, and Email is `type="text"`.** | 1.3.5 | `03b` |
| 14 | **The fields have no `id` or `name`.** This breaks browser autofill. | Not WCAG | `03e` |
| 15 | **Pressing Enter in a field does nothing.** The form has no submit button, and Done is `type="button"`. | Usability | `01a` to `01c` |
| 16 | **Font sizes are in `px`** (48px heading, 20px intro, 16px fields), so they ignore the user's browser font-size preference. | Advisory (1.4.4) | `index.css` |
| 17 | **Emoji in the intro and the Done button** may be read out by screen readers. | Advisory | `01h` |
| 18 | **"Accesibility" is misspelt** in the heading. | Not WCAG | `01h` |
| 19 | **No `<!DOCTYPE html>`**, so the page renders in quirks mode. | Not WCAG | `03a`, `03e` |
| 20 | **Unneeded third-party requests and a large image.** The Iconify script is loaded but not used, three outside domains are contacted, the robot image is 196 kB (about 86% of the page weight), and `favicon.ico` returns 404. | Not WCAG (performance and privacy) | `10a` |
| 21 | **The message box text is smaller than the other fields.** `.contact-textarea` sets no `font-size`, so the browser's 13.33px applies against 16px for the inputs. | Advisory | `03g`, `03h` |

## Checked and passing

- Every control can be reached and used with the keyboard, in a logical order that
  matches the visual order (2.1.1, 2.4.3). `01a` to `01d`, `07d`
- Focus can leave the page, so there is no keyboard trap (2.1.2). `01g`
- Focus does not move unexpectedly. `07d`
- The focus ring has a contrast of about 19:1 against the white page. `08c`
- WAVE reports no contrast errors and no ARIA errors. `06a`

## What I did not test

- A screen reader (NVDA, VoiceOver or JAWS). Findings about what screen readers
  announce come from the page source and the browser's accessibility tree, not from
  listening to it.
- The W3C HTML validator.
- Browsers other than Chrome. I did not use a real phone either: the phone-width
  checks used Chrome's DevTools device emulation (iPhone SE, 375px).
- High-contrast or forced-colours mode, and text-spacing overrides (1.4.12).

## How this would work in a real project

In a real project I would raise each finding as a ticket in the team's tracker
and attach the screenshots to it, instead of committing them to the code
repository. I would also add axe checks to the Playwright suite so they run in CI
on every build. I kept the audit and the evidence in this repository so they can
be reviewed with the submission.

## BUG-001

**Title:** Form fields have no label; the placeholder is the only text
**Severity:** High
**Status:** Open
**Page:** `public/index.html` at http://localhost:8080/
**Environment:** Chrome 158.0.8127.37 on Windows 11, 100% zoom
**Found by:** WAVE (3 "Missing form label" errors) and manual inspection with the
DevTools Accessibility pane. Lighthouse, axe and Chrome's Issues panel did not
report it, because they accept a placeholder as an accessible name.

**Steps to reproduce**
1. Run `npm start` and open http://localhost:8080/.
2. Press F12, open Elements and select the Full name `<input>`.
3. Open the Accessibility pane. The name is "Full name", and the pane shows it
   comes only from the placeholder: `aria-labelledby`, `aria-label`, label and
   `title` are all "Not specified".
4. Click into the Full name field and type any character. The text "Full name"
   disappears and nothing else on screen says what the field is for.
5. Repeat for Email and Your message, or run the WAVE extension and look at the
   Details tab.

**Expected result:** Each field has a visible `<label>` that stays on screen while
the user types, and that is programmatically associated with the field.

**Actual result:** Each field has only a `placeholder`. There is no `<label>`, no
`aria-label` and no `aria-labelledby`. WAVE reports 3 missing form labels. The
placeholder is also low contrast (2.32:1, finding 7).

**Impact:** Once someone starts typing, the prompt is gone, which is a problem for
anyone with memory, attention or cognitive difficulties and for anyone who
checks their entries. Some assistive technologies and voice-control tools do not
treat a placeholder as a label, and without a label there is nothing to click to
move focus into the field.

**WCAG:** 1.3.1 Info and Relationships (A), 3.3.2 Labels or Instructions (A),
4.1.2 Name, Role, Value (A)

**Suggested fix:**

```html
<label for="full-name">Full name</label>
<input id="full-name" name="name" class="contact-input" type="text" autocomplete="name">

<label for="email">Email</label>
<input id="email" name="email" class="contact-input" type="email" autocomplete="email">

<label for="message">Your message</label>
<textarea id="message" name="message" class="contact-textarea" rows="4" cols="50"></textarea>
```

**Evidence:** `03a`, `03b`, `06a`, `06b`, `08a`
