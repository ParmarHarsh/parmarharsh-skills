### Dark mode doesn't persist

**Description:** The dark mode toggle in settings resets to light every time the app is reopened.

**Steps to reproduce:**
1. Go to Settings.
2. Enable dark mode.
3. Reopen the app.

**Expected behavior:** Dark mode stays on.
**Actual behavior:** It's back to light mode.

**Environment:** Chrome on Windows (unconfirmed)

Possible cause: the preference isn't being saved to local storage.
