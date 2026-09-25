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

## Chapter Summary

- ✅ You used arithmetic, comparison, and logical operators in realistic AL scenarios
- ✅ You practiced composing expressions that are both correct and readable
- ✅ You learned patterns to reduce hidden logic bugs in later chapters

---

## Tasks

1. **Formula extraction.** Replace one long inline expression with named local variables.
2. **Condition hardening.** Rewrite one multi-condition `if` with explicit parentheses.
3. **Try it yourself.** Add one validation expression that rejects invalid installment input.

**Check your work:** your expressions should be easy to reuse in Chapter 7 triggers and Chapter 9 codeunit procedures.
