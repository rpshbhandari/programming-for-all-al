# Chapter 4 Worked Solutions

## Task 1 — Type review (starter set)

- `Loan No.` → `Code[20]` (structured identifier, compact and searchable).
- `Installment No.` → `Integer` (ordered numeric sequence).
- `Principal Amount` → `Decimal` (money-safe precision).
- `Paid` → `Boolean` (binary business state).
- `Due Date` → `Date` (date-only business deadline).
- `Payment Date` → `Date` (date-only posting information).

## Task 2 — Boundary practice

- `Code[20]`
  - Valid: `LN-2026-0001`
  - Invalid: `LOAN-2026-0001-EXTRA` (more than 20 chars)
- `Text[100]`
  - Valid: `First disbursement linked to contract amendment.`
  - Invalid: a paragraph beyond 100 chars
- `Decimal`
  - Valid: `15250.75`
  - Invalid: `15,250.75 USD` (not a pure decimal value)

## Task 3 — Variable scope cleanup

Expected answer pattern:

- Keep only shared state as globals.
- Move temporary calculation variables (`InterestAmount`, `NetAmount`) to local procedure `var` blocks.
- Keep procedure parameters strongly typed instead of relying on globals.

## Task 4 — Consistent identifier typing

Expected answer pattern:

- Use `Code[20]` for `Loan No.` in table fields, page bindings, report columns, and codeunit procedure parameters.
- Do not mix `Text` for the same identifier across objects.

## Task 5 — Validation guard

Example guard:

```al
if "Principal Amount" <= 0 then
    Error('Principal Amount must be greater than zero.');
if "Interest Amount" < 0 then
    Error('Interest Amount cannot be negative.');
```

## Task 6 — Try it yourself

Sample answer:

- Field: `External Reference`
- Recommended type: `Code[35]` if it is a compact external identifier from another system.
- Use `Text[100]` only if free-form human notes are expected.
