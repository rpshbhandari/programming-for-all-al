# Chapter 5 Worked Solutions

## Task 1 — Operator warmup

- Arithmetic: `NetAmount := PrincipalAmount + InterestAmount;`
- Comparison: `if InstallmentAmount > 0 then`
- Logical: `if (InstallmentAmount > 0) and (DueDate <> 0D) then`

## Task 2 — Formula extraction

```al
GrossAmount := Quantity * UnitPrice;
DiscountAmount := GrossAmount * DiscountPct;
NetAmount := GrossAmount - DiscountAmount;
```

This is easier to test and review than one dense inline expression.

## Task 3 — Precedence check

- Without parentheses: `A + B * C` evaluates multiplication first.
- With parentheses: `(A + B) * C` changes the business result.

Rule: always use explicit parentheses for money formulas.

## Task 4 — Condition hardening

```al
IsDue := DueDate <= Today;
HasAmount := Amount > 0;
HasValidStatus := not Paid;
if (IsDue and HasAmount) and HasValidStatus then
    Message('Ready for processing.');
```

## Task 5 — Validation expression

```al
if (Amount <= 0) or (DueDate = 0D) then
    Error('Installment must have a positive amount and a due date.');
```

## Task 6 — Ready-to-post expression

Sample expression:

`ReadyToPost := (Amount > 0) and (DueDate <> 0D) and (not Paid);`

Why each condition exists:

- `Amount > 0`: blocks non-postable financial rows.
- `DueDate <> 0D`: blocks incomplete scheduling data.
- `not Paid`: prevents duplicate posting.
