# Chapter 9 Task Traceability

- Task 1 → `LoanRepaymentSchedule.Table.al` (`OnModify` uses `xRec.Paid`).
- Task 2 → `LoanRepaymentMgt.Codeunit.al` (codeunit `50100` / `"Loan Repayment Mgt."`).
- Task 3 → `LoanRepaymentMgt.Codeunit.al` (`MarkInstallmentPaid`).
- Task 4 → `LoanRepaymentMgt.Codeunit.al` (`GenerateSchedule`).
- Task 5 → `LoanRepaymentScheduleList.Page.al` (`MarkPaid` action calls `MarkInstallmentPaid`).
- Task 6 → `LoanRepaymentMgt.Codeunit.al` (existing-schedule guard by `Loan No.`).
