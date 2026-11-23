# Accessibility evidence log: public/index.html

Page served locally with `npm start` and tested at http://localhost:8080/ in
Chrome on Windows 11.

## 1. Keyboard-only test

**Date and time:** 22 November 2026, about 21:15 to 23:00
**Browser:** Chrome 158.0.8127.37 (64-bit), Windows 11

**What I did:** Used only the keyboard. I clicked the page heading, then pressed
Tab through the page, used Shift+Tab to go back, typed in a field and pressed
Enter, and pressed Enter and Space on the Done button. The screenshots `01a` to
`01d` were taken with the browser at about 150% zoom, `01e` at 300% and `01h` at
100%.

### What I saw
- **Tab order:** Full name, Email, Your message, Done. A fifth Tab press moves
  focus out of the page to Chrome's own Tab search button, so there is no
  keyboard trap. (`01a` to `01d`, `01g`)
- **Going backwards:** Shift+Tab moves back up through the controls.
- **Enter in a text field:** Nothing happens. The page stays as it is, because
  the form has no submit button and Done is `type="button"`.
- **Enter and Space on Done:** Nothing visible happens on the page. Each press of
  Enter or Space logs `Uncaught ReferenceError: submitForm is not defined` in the
  Console, raised by the button's `onclick` at `(index):22:96`, and the error
  count goes up each time. The button runs but fails silently, with no message
  for the user. (`02a`, `02b`)
- **Focus on the fields:** The focus ring is very faint. A focused field shows
  only a slightly thicker dark border, which is hard to tell apart from the
  unfocused state. (`01a` to `01c`, compared with `01h`)
- **Focus on Done:** A focus ring is present but very faint. I could only just
  make it out on screen, and it is barely distinguishable from the unfocused
  state in the screenshots, at about 150% zoom (`01d`) and at 300% (`01e`,
  compared with `01f`). The unfocused page at 100% is `01h`.
- **Why the focus is hard to see:** The page defines a hover style for Done (a
  grey background) but no focus style, so it relies on the browser's default
  ring. In Chrome that ring is `outline: auto 1px rgb(16, 16, 16)` (`03d`), and the
  controls already have a dark `#333` border, so the ring blends into it.

### What it means
| Check | Result | WCAG |
|---|---|---|
| Every control can be reached and used from the keyboard | Pass | 2.1.1 Keyboard (A) |
| Focus can leave the page, so there is no keyboard trap | Pass | 2.1.2 No Keyboard Trap (A) |
| The focus order is logical | Pass | 2.4.3 Focus Order (A) |
| A focus indicator is visible | Present but very faint on every control | 2.4.7 Focus Visible (AA), 1.4.11 Non-text Contrast (AA) |
| Feedback after pressing Done | Fail: nothing visible, and the console shows an error | 4.1.3 Status Messages (AA) |

**Who is affected:** Keyboard-only and switch users and people with low vision,
who can't tell which control has focus. Screen reader users also get no response
from Done.

**Caveat:** WCAG 2.4.7 only requires that a focus indicator is visible, so a
tester could argue that the browser's default ring technically meets it. The
stronger concern is contrast (1.4.11): a near-black ring beside a dark border
gives little change between the focused and unfocused states.

**Suggested fix:** Add a distinct focus style, for example
`.contact-submit-button:focus-visible { outline: 3px solid #1d70b8; outline-offset: 2px; }`,
with matching styles for the fields. Give the form a real submit button and a
status message after submission.

**Evidence:** `01a-keyboard-name.png`, `01b-keyboard-email.png`,
`01c-keyboard-message.png`, `01d-keyboard-done.png`,
`01e-focus-done-zoomed.png`, `01f-unfocused-done-zoomed.png`,
`01g-keyboard-leaves-page.png`,
`01h-unfocused-page-100.png`, `02a-console.png`, `02b-console.png`

## 2. Zoom and reflow

**What I did:** Zoomed Chrome to 300% on http://localhost:8080/. With DevTools
open, the effective viewport was about 432 CSS pixels wide.
I also emulated an iPhone SE (375 by 667) with DevTools' device toolbar.

**What I saw:**
- **No reflow:** The page magnifies but does not reflow. It keeps its two-column
  layout, and the robot image is cut off at the right edge (`09a`).
- **At 400%:** The effective viewport is about 478 CSS pixels wide (a 1912px
  window divided by 4). The page still shows its two-column layout: the heading and
  intro on the left and the robot image cut off at the right edge. The form fields
  and the Done button are out of view. (`09b`)
- **At phone width (375px):** The page has no viewport meta tag, so the browser
  lays it out at about 980px wide and shrinks it to fit: the body is 900 by 1743
  pixels with 40px margins. Both columns stay side by side, the text is about 38%
  of its normal size, and the robot image touches the right edge. Nothing stacks.
  (`09e`, `09f`; `09f` is the same view with the emulator's display scale set to
  200% so it is easier to read.)
- **Scrolling is blocked:** The mouse wheel and trackpad cannot scroll the page,
  so everything below the heading is out of reach by mouse. Keyboard focus does
  still scroll the page, so Tab brings Done into view (`01e`).
- **Stuck after zooming back out:** After returning to 100% zoom, the page stays
  scrolled down with the heading cut off, and cannot be scrolled back by mouse.
  Reloading restores it, but tabbing back to the first field does not bring the
  heading back into view. (`09c`, `09d`)

**Cause (from the CSS):** Fixed widths (800px section, 700px image, 300px fields),
no `@media` queries, and `overflow: hidden` on the `<body>` (`.contact-page`),
which also disables scrolling of the whole page.

**WCAG:** 1.4.10 Reflow (AA) and 1.4.4 Resize Text (AA).
Reflow is tested at 320 CSS pixels wide. The page did not reflow at about 478, which
is wider than that, so it also fails at the criterion's width.

**Who is affected:** People with low vision who zoom in, mobile users, and anyone
with a small window.

**Suggested fix:** Use relative widths (`max-width: 100%`), let the flex container
wrap or stack at narrow widths with a media query, give the image `max-width: 100%`
and `height: auto`, remove `overflow: hidden` from the body, and add a viewport
meta tag.

**Evidence:** `09a-zoom-300.png`, `09b-zoom-400.png`, `09c-scroll-stuck-100.png`,
`09d-reload-restores-100.png`, `09e-phone-375.png`, `09f-phone-200-percent.png`

## 3. DevTools inspection

**What I did:** Opened Chrome DevTools (F12) on http://localhost:8080/ and
inspected the page structure (Elements), the accessibility data for the form
fields (Accessibility pane), the Done button's styles (Styles and Computed) and
the Issues panel.

**What I saw:**
- **Page structure (`03a`):** There is no `<!DOCTYPE html>` before `<html>`, and
  `<html>` has no `lang` attribute. `<head>` has no `<title>` and no viewport meta
  tag. It contains only an Iconify script, two preconnect links, the Google Fonts
  stylesheet and `index.css`. The `<img class="contact-image">` has only `class`
  and `src`, with no `alt`. The Styles pane in the same screenshot shows
  `overflow: hidden` on `.contact-page`, which is the `<body>`.
- **Form fields (`03b`):** The Full name input's accessible name ("Full name")
  comes only from its placeholder. `aria-labelledby`, `aria-label`, label and
  `title` are all "Not specified". The Email and message fields have the same
  markup, with only a placeholder (`03a`). None has an `autocomplete` attribute.
- **Done button styles (`03c`):** The page's own CSS for the button sets the
  border, padding, radius, width, cursor and font, but has no focus style. The only
  focus rule is the browser's own `:focus-visible` rule.
- **Focus ring (`03d`, `03f`):** With `:focus-visible` forced on in DevTools, the
  computed outline on Done is `outline-style: auto`, `outline-width: 1px`,
  `outline-color: rgb(16, 16, 16)`. Without the forced state, no outline is
  applied. Calculated from those colours, the ring against the button's `#333`
  border is about 1.5:1 contrast, and against the white page about 19:1.
- **Issues panel (`03e`):** Chrome reports 4 issues in two groups: "A form field
  element should have an id or name attribute" (all 3 fields) and "Page layout may
  be unexpected due to Quirks Mode". It does not report the missing labels,
  because the placeholder supplies a name.
- **Message box font size (`03g`, `03h`):** Text typed into the message box is
  smaller than in the Full name and Email fields. `.contact-input` sets
  `font-size: 16px`, but `.contact-textarea` sets none, so the browser's default of
  about 13.33px applies (Computed value in `03h`).

**What it means:**
| Finding | WCAG |
|---|---|
| The image has no `alt` | 1.1.1 Non-text Content (A) |
| The fields' only name is a placeholder, with no label | 1.3.1 Info and Relationships (A), 3.3.2 Labels or Instructions (A), 4.1.2 Name, Role, Value (A) |
| `<html>` has no `lang` | 3.1.1 Language of Page (A) |
| The page has no `<title>` | 2.4.2 Page Titled (A) |
| The fields have no `autocomplete` | 1.3.5 Identify Input Purpose (AA) |
| No viewport meta tag | 1.4.10 Reflow (AA) on mobile |
| No `id` or `name` on the fields, and no doctype | Not WCAG: autofill and quirks mode |

**Caveat:** Because the placeholder gives each field a name, Lighthouse, axe and
Chrome's Issues panel do not flag the missing labels, although WAVE does
(section 7). It is still a real issue: a placeholder disappears once the user
types, and its contrast is low.

**Suggested fix:** Add a `<!DOCTYPE html>`, `lang="en"` and a `<title>`; add an
`alt` to the image; give each field an `id` and `name`, a visible `<label>` and an
`autocomplete` value; and add `<meta name="viewport" content="width=device-width, initial-scale=1">`.

**Evidence:** `03a-elements.png`, `03b-accessibility-name.png`,
`03c-done-button-styles.png`, `03d-computed-outline.png`,
`03e-devtools-issues.png`, `03f-computed-outline-unfocused.png`,
`03g-textarea-font-size.png`, `03h-textarea-computed-font.png`

## 4. Lighthouse

**What I did:** Ran Lighthouse from DevTools in an Incognito window (so no
extensions interfered) on http://localhost:8080/, with the Accessibility category
only, in Navigation mode, emulated desktop. Lighthouse 13.5.0, captured on
22 November 2026 at 11:33 PM GMT.

**What I saw:** An accessibility score of **64**.
- **Failed (4):** images without `alt` (`img.contact-image`), no `<title>`, no
  `lang` on `<html>`, and no main landmark. (`04a`, `04b`)
- **Passed (6):** including "Form elements have associated labels" and "Background
  and foreground colors have a sufficient contrast ratio". (`04d`)
- **Manual checks (10):** tab order, focus indicator, landmarks and others are
  listed as manual, not scored. (`04c`)

**What it means:** Lighthouse confirms the missing `alt`, `<title>`, `lang` and
main landmark. It did not flag the fields that have only a placeholder, because
the placeholder gives each field a name, or the low-contrast placeholder text
(2.32:1), so those are manual findings. It also cannot detect the faint focus ring,
the missing reflow, the blocked scrolling or the silent Done button, so automated
tools alone would have missed them.

**Evidence:** `04a-lighthouse-score.png`, `04b-lighthouse-lang-landmark.png`,
`04c-lighthouse-manual-checks.png`, `04d-lighthouse-passed-audits.png`,
`04-lighthouse-desktop.html`

## 5. axe DevTools

**What I did:** Installed the axe DevTools extension (axe-core 4.13.0) and scanned
the whole page at http://localhost:8080/ twice, on 22 November 2026: first with the
WCAG 2.1 AA ruleset only (about 11:46 PM), then with Best Practices switched on
(about 11:57 PM).

**What I saw:**
- **WCAG 2.1 AA only: 3 issues** (`05a`, `05b`, `05c`). Critical: images must have
  alternative text. Serious: the document must have a `<title>`. Serious: the
  `<html>` element must have a `lang` attribute.
- **With Best Practices on: 11 issues** (`05d` to `05g`). The same 3, plus 8
  moderate best-practice issues: the document should have one main landmark (1),
  the page should contain a level-one heading (1), and all page content should be
  contained by landmarks (6 elements).

**What it means:** axe agrees with Lighthouse on the missing `alt`, `<title>`,
`lang` and main landmark, and adds the missing level-one heading and landmark
regions. It did not flag the fields that have only a placeholder, or the
low-contrast placeholder text, so those remain manual findings. It also cannot
detect the faint focus ring, the missing reflow, the blocked scrolling or the
silent Done button.

**Export:** I exported the Best Practices scan as JSON (`05-axe-export.json`). The
export contained my personal email address in the `foundBy` field, so I replaced
it with `redacted`. Nothing else was changed.

**Evidence:** `05a-axe-overview.png`, `05b-axe-title-lang.png`,
`05c-axe-lang-image-alt.png`, `05d-axe-best-practices.png`,
`05e-axe-bp-title-lang.png`, `05f-axe-bp-image-main-landmark.png`,
`05g-axe-bp-heading-landmarks.png`, `05-axe-export.json`

## 6. Colour contrast

**What I did:** Checked the colours from the page's CSS and from DevTools with the
WebAIM Contrast Checker (webaim.org/resources/contrastchecker). The placeholder
colour is `#aaaaaa` (`index.css`), the page background is white, the button border
is `#333333` and the default focus ring is `rgb(16, 16, 16)` (`03d`).

**What I saw:**
- **Placeholder text on white:** 2.32:1. It fails WCAG AA and AAA for normal text,
  large text and UI components. (`08a`)
- **Focus ring against the button border:** 1.5:1. It fails every check. (`08b`)
- **Focus ring against the white page:** 19.02:1. It passes every check. (`08c`)

**What it means:** The placeholder text is below the 4.5:1 minimum for text
(1.4.3, AA) and even below the 3:1 minimum for large text. The focus ring stands out
against the white page, but it is a thin line in almost the same dark tone as the
control's own border, so the change between focused and unfocused is small
(1.4.11, AA). Neither Lighthouse nor axe reported the placeholder contrast.

**Suggested fix:** Use a darker placeholder colour with at least 4.5:1 contrast on
white, for example `#767676` or darker, and give the focus ring a colour that
contrasts with both the border and the page.

**Evidence:** `08a-contrast-placeholder.png`, `08b-contrast-focus-ring.png`,
`08c-contrast-ring-vs-white.png`

## 7. WAVE

**What I did:** Installed the WAVE browser extension (WebAIM) in Chrome and ran
it on http://localhost:8080/ on 23 November 2026, about 01:00. I used the Details
tab and scrolled the results list.

**What I saw:**
- **6 errors:** 1 missing alternative text, 3 missing form labels, 1 missing page
  title and 1 missing language. (`06a`)
- **2 alerts:** no page regions and no first-level heading. (`06a`, `06b`)
- **Structure:** one heading, level 2. (`06b`)
- **Contrast errors:** 0.
- **AIM score:** 6.1 out of 10.

**What it means:** WAVE reports the three form fields with no label as errors.
Lighthouse, axe and Chrome's Issues panel did not, because they accept a
placeholder as an accessible name. A placeholder disappears when the user types and
is not a reliable label, so I count this as a real failure (1.3.1, 3.3.2, 4.1.2).
The other errors and alerts match what Lighthouse and axe found. WAVE reported no
contrast errors, so it did not catch the placeholder contrast I measured manually
as 2.32:1 (section 6).

**Evidence:** `06a-wave-summary.png`, `06b-wave-details.png`

## 8. Accessibility Insights for Web

**What I did:** Installed the Accessibility Insights for Web extension
(Microsoft), ran FastPass on http://localhost:8080/ on 23 November 2026, between
about 01:10 and 01:35, and exported the result as HTML. FastPass has three steps:
automated checks, tab stops and needs review.

**What I saw:**
- **Automated checks: 3 failed instances** (`07a`, `07b`). `document-title`
  (WCAG 2.4.2), `html-has-lang` (3.1.1) and `image-alt` (1.1.1). These are the
  same 3 failures axe reported with the WCAG ruleset only.
- **Tab stops** (`07c`, `07d`): With the visual helper on, the tool drew the tab
  order as Full name, Email, Your message, Done. I recorded Pass for keyboard
  navigation, keyboard traps, tab order and input focus. I recorded Fail for the
  focus indicator and added the comment "Focus ring is present but very faint,
  about 1.5:1 against the field border."
- **Needs review: 0 instances** (`07e`).

**A false result I did not keep:** Before I pressed Tab through the page with the
visual helper on, the tool automatically reported four "unreachable element"
failures (the three fields and the button). They cleared once it had seen the tab
stops. I had already tested the keyboard by hand (section 1), so I treated them as
a side effect of the tool not having observed the tab stops, not as real.

**What it means:** The automated step adds nothing new beyond Lighthouse and axe.
The useful part is the tab stops view, which shows the keyboard order visually and
agrees with my manual test. The Focus indicator failure is my own judgement from
sections 1 and 6, recorded in the tool.

**Evidence:** `07a-insights-automated.png`, `07b-insights-automated-image-alt.png`,
`07c-insights-tab-stops.png`, `07d-insights-tab-stops-results.png`,
`07e-insights-needs-review.png`, `07-insights-report.html`

## 9. Network tab

**What I did:** Opened the Network tab in Chrome DevTools on
http://localhost:8080/ on 23 November 2026, about 02:15, with Disable cache on,
and did a hard reload (Ctrl+Shift+R). I added the Domain column to see where each
request goes.

**What I saw:**
- **8 requests, 227 kB transferred**, finished in 187 ms. (`10a`)
- **Three outside domains, four requests:** `code.iconify.design` (the Iconify
  script, 10.7 kB), `fonts.googleapis.com` (the font stylesheet) and
  `fonts.gstatic.com` (two Poppins font files). The other four requests are
  `localhost`.
- **The Iconify script is not used.** `index.html` loads it in the `<head>` but
  nothing in the page uses an icon from it.
- **The robot image is 196 kB**, about 86% of the 227 kB transferred. Its file
  name suggests 1280px wide, but the page shows it at 700px.
- **`favicon.ico` returns 404.** The page has no favicon.

**What it means:** This is a performance and privacy point, not a WCAG failure.
The unused script adds a request to a third-party server and a download that
visitors on slow or metered connections do not need. Loading fonts from Google
and the script from Iconify sends each visitor's IP address to those servers.
The font stylesheet also means the heading and body text fall back to a default
sans-serif font if Google is blocked or unreachable. It does not change the
accessibility findings, so it appears as a low-priority item (finding 20 in the
audit).

**Evidence:** `10a-network-requests.png`
