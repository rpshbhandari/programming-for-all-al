# Chapter 6 Worked Solutions

## Task 1 — Branching choice

Use `case` when you have discrete statuses:

```al
case InstallmentStatus of
    InstallmentStatus::Open:
        HandleOpen();
    InstallmentStatus::Due:
        HandleDue();
    InstallmentStatus::Paid:
        HandlePaid();
end;
```

## Task 2 — Decision fallback

```al
case InstallmentStatus of
    InstallmentStatus::Open:
        HandleOpen();
    InstallmentStatus::Due:
        HandleDue();
    InstallmentStatus::Paid:
        HandlePaid();
else
    Error('Unsupported installment status: %1', Format(InstallmentStatus));
end;
```

## Task 3 — Loop correction

```al
if LoanRepaymentSchedule.FindSet() then
    repeat
        ProcessInstallment(LoanRepaymentSchedule);
    until LoanRepaymentSchedule.Next() = 0;
```

## Task 4 — Loop intent check

Use `for` for known counts:

```al
for InstallmentNo := 1 to NumberOfInstallments do
    CreateInstallment(InstallmentNo);
```

## Task 5 — Guard clause

```al
if Amount <= 0 then
    Error('Amount must be greater than zero before posting.');
```

## Task 6 — Reduce nesting depth

Expected answer pattern:

- Extract nested checks to helpers such as `ValidateInstallment(Rec);` or `CanPostInstallment(Rec)`.
- Keep top-level procedures focused on one control-flow path.
- Return early on invalid data before main processing logic.
