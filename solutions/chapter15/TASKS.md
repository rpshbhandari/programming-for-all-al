# Chapter 15 Task Traceability

- Task 1 → `LoanRepaymentSchedule.Table.al` (all `Loan Repayment Schedule` fields classified as `CustomerContent` per chapter guidance).
- Task 2 → `LoanRepaymentView.PermissionSet.al` and `LoanRepaymentFull.PermissionSet.al` (split "View" and "Full" model).
- Task 3 → Role assignment rationale:
  - **View**: assigned to finance auditors because they must inspect repayment status without changing records.
  - **Full**: assigned to loan operations users because they create schedules and mark installments paid.
- Task 4 → `"Borrower Name"` should be `EndUserIdentifiableInformation`; keep it off broad-access pages and expose only via role-restricted page extension.
