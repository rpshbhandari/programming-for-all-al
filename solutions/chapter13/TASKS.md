# Chapter 13 Task Traceability

- Task 1 → `LoanRepaymentPerformance.Codeunit.al` (`CountUnpaidInstallments` uses `SetRange(Paid, false)` before `FindSet`).
- Task 2 → `LoanRepaymentPerformance.Codeunit.al` (`SetLoadFields(Paid)` added).
- Task 3 → `LoanRepaymentPerformance.Codeunit.al` (`ExplainBorrowerLookupPlacement` documents lookup placement outside loop).
- Task 4 → `LoanRepaymentMgt.Codeunit.al` in Chapter 9 keeps trigger-driven insert behavior; optimize writes only after measuring realistic volume, lock behavior, and trigger requirements.
