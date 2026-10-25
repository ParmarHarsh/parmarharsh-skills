## Export PDF spins forever on Android for invoices with more than 50 line items

**Steps to reproduce**
1. Sign in on Android as a Pro plan user.
2. Open an invoice with 51 or more line items.
3. Tap **Export PDF**.

**Expected:** The PDF is generated and opens.
**Actual:** The spinner never stops; no PDF is produced.
**Frequency:** Unknown (Q1)

**Environment**
- App version: Unknown (Q2)
- Platform: Android, device Unknown (Q3)
- Browser or client: Android app
- Account or plan: Pro
- First seen: within the last week (worked last week)

**Suspected area:** PDF export pagination for long invoices, changed in the last week (hypothesis).

### Questions for the reporter
- Q1. Does it happen every time, or only for some invoices?
- Q2. Which app version is installed?
- Q3. Which device and Android version?
