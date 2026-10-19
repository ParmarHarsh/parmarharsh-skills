# Phase 4: rate limiting on the public auth endpoints

## 0. Setup

Start a fresh branch from the up-to-date default branch, install, run the full gate and record the baseline.

## 1. Objective

Signup and password reset reject bursts from one client, without changing anything else.

## 2. Items

### A · Rate limit POST /signup

- **Acceptance.** The 6th request inside 60 seconds gets a 429.

## 3. Must not change

- The response bodies of /signup and /password-reset.

## 4. Not in this phase

- CAPTCHA and account lockout: next phase.

## 5. Validation gates

1. Inspect before modifying. If any claim in this brief is wrong, say so and stop.
2. Full gate green against the baseline.
3. Existing tests pass unedited. Never weaken an assertion.
4. Name every file in the diff.

## 6. Report

Changed · Preserved · Verification · Scope deviations · Could not verify · New findings · Files changed.
Chat summary under 300 words. No pull request unless asked.
