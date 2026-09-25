# Chapter 14 Task Traceability

- Task 1 → `LoanRepaymentMgtTests.Codeunit.al` (`Subtype = Test`).
- Task 2 → `LoanRepaymentMgtTests.Codeunit.al` (`MarkInstallmentPaidSetsPaymentDate`).
- Task 3 → `LoanRepaymentMgtTests.Codeunit.al` (`MarkingPaidDoesNotTriggerBlockedEditError`).
- Task 4 → covered by the same regression test design: it fails if `xRec.Paid` is reverted to `Paid`.
- Task 5 → `LoanRepaymentMgtTests.Codeunit.al` (`GenerateScheduleCreatesThreeRows`).
