The field is subscription analytics. A senior retention analyst owns this.

**1. What a top professional would do here**

- Check that the jump from 3.1% to 4.4% is real and not a change in how churn is counted.
- Separate voluntary cancellations from failed payments. Involuntary churn needs a billing fix, not a feature.
- Split churn by signup cohort and plan before explaining it. A rise concentrated in one SMB cohort points to onboarding or pricing, not the whole product.

**2. Rawest material**

- Account-level subscription events from the billing system (start, upgrade, downgrade, cancel, failed payment) for the last 18 months, not the dashboard's monthly rate. The rate hides which accounts left and when.
- The free-text cancellation reasons, and the support tickets from churned accounts in the 60 days before they left.

**3. Methods and tools**

- Cohort retention curves, and a Kaplan-Meier survival curve by plan.
- Hand-code 100 cancellation reasons before trusting any dropdown category.
- Exit interviews with five to eight churned SMB accounts.

**4. Outside check**

- The rebuilt churn count reconciles with billing's own Q3 cancellation total.
- The explanation predicts which current accounts are at risk. Check that list against who actually cancels next month.

**5. Rewritten prompt**

```
Figure out why customers are leaving and what we should fix first, for the retention team.

Don't work from the dashboard summary. Start from account-level billing events for the last 18 months, plus the cancellation reasons and support tickets of accounts that churned in Q3. Ask me for them if you don't have them.

1. Confirm the jump from 3.1% to 4.4% isn't a change in how churn is counted.
2. Split voluntary from failed-payment churn, then build retention curves by signup cohort and plan.
3. Hand-code 100 cancellation reasons before using any category.

Done means your churn count reconciles with billing's Q3 cancellation total, and your explanation names the current accounts at risk, so we can check it against next month's cancellations. Say what you couldn't verify.
```

Same deliverable: why customers are leaving and what to fix first, for the retention team.

Want me to run it?
