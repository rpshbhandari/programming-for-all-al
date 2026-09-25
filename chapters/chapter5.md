# Chapter 5: Operators and Expressions

## Objectives

By the end of this chapter you will be able to:

- ✅ Use arithmetic, comparison, and logical operators correctly in AL
- ✅ Write readable expressions for business rules
- ✅ Avoid precedence mistakes that silently change behavior
- ✅ Prepare expression patterns used in table triggers and codeunits

## 5.1 Arithmetic Operators in Business Logic

AL supports `+`, `-`, `*`, and `/` for numeric calculations.

```al
procedure CalculateLineTotal(Quantity: Decimal; UnitPrice: Decimal; DiscountPct: Decimal): Decimal
begin
    exit((Quantity * UnitPrice) * (1 - DiscountPct));
end;
```

Use `Decimal` for money calculations to avoid rounding surprises.

## 5.2 Comparison and Logical Operators

Comparison operators (`=`, `<>`, `<`, `>`, `<=`, `>=`) and logical operators (`and`, `or`, `not`) drive validation and branching.

```al
if (Amount > 0) and (DueDate <> 0D) then
    Message('Installment is valid for posting.');
```

Prefer explicit parentheses when combining conditions.

## 5.3 Expression Clarity and Maintainability

Long expressions are correct only if future readers can audit them quickly.

- Break complex formulas into named local variables.
- Avoid duplicated calculations across procedures.
- Keep business intent obvious (for example, `IsOverdue` variable).

These choices make Chapter 13 performance and Chapter 14 testing much easier.

## 5.4 Expression Evaluation Flow (Visual Guide)

Use this as a reminder of evaluation order and validation gates:

```mermaid
flowchart TD
    A[Read inputs] --> B{Quantity > 0?}
    B -->|No| C[Error: invalid quantity]
    B -->|Yes| D{UnitPrice >= 0?}
    D -->|No| E[Error: invalid unit price]
    D -->|Yes| F[Gross = Quantity * UnitPrice]
    F --> G[Discounted = Gross * (1 - DiscountPct)]
    G --> H[Return line total]
```

## Chapter Summary

- ✅ You used arithmetic, comparison, and logical operators in realistic AL scenarios
- ✅ You practiced composing expressions that are both correct and readable
- ✅ You learned patterns to reduce hidden logic bugs in later chapters

---

## Tasks

1. **Operator warmup.** Write one AL example each for arithmetic, comparison, and logical operators using loan-installment values.
2. **Formula extraction.** Replace one long inline expression with named local variables (`GrossAmount`, `DiscountAmount`, `NetAmount`).
3. **Precedence check.** Evaluate the same formula once without parentheses and once with parentheses; explain the difference.
4. **Condition hardening.** Rewrite one multi-condition `if` with explicit parentheses and positive naming (`IsDue`, `HasAmount`, etc.).
5. **Validation expression.** Add one expression that rejects invalid installment input (`Amount <= 0`, missing date, or invalid status combination).
6. **Try it yourself.** Create a boolean expression for "ready to post" that uses at least three conditions and document why each is needed.

**Check your work:** compare your answers with `/solutions/chapter5/TASKS.md`, then ensure your expressions remain reusable in Chapter 7 triggers and Chapter 9 codeunit procedures.
