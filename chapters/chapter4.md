# Chapter 4: Data Types and Variables in AL

## Objectives

By the end of this chapter you will be able to:

- ✅ Choose appropriate AL primitive and complex data types
- ✅ Declare variables with intent and clear scope
- ✅ Avoid common type-related errors in business logic
- ✅ Prepare strongly typed data handling for table/page work in Chapter 7 and 8

## 4.1 Primitive Data Types

AL primitive types include `Integer`, `Decimal`, `Boolean`, `Text`, `Date`, and `DateTime`. Pick the narrowest type that still matches business meaning.

- Use `Decimal` for money and rates.
- Use `Code[n]` for compact identifiers (for example, document numbers).
- Use `Text[n]` for free-form descriptive fields.

## 4.2 Complex Data Types

Common complex types include:

- `Record` for table rows
- `List` and `Dictionary` for in-memory collections
- Enums/options for constrained business states

Most business workflows in this book pass `Record` values into codeunit procedures, especially from Chapter 9 onward.

## 4.3 Variable Declaration and Scope

```al
procedure CalculateInstallmentAmount(Principal: Decimal; InterestRate: Decimal): Decimal
var
    InterestAmount: Decimal;
begin
    InterestAmount := Principal * InterestRate;
    exit(Principal + InterestAmount);
end;
```

Prefer local variables inside procedures. Keep global variables only when state must be shared across procedures in the same object.

## 4.4 Type-Safety Patterns You Will Reuse

- Validate assumptions early with `TestField` or explicit `Error`.
- Avoid implicit conversions that hide precision or truncation issues.
- Keep identifier types consistent across objects (for example, loan number as `Code[20]` everywhere).

These habits reduce downstream defects in table triggers and codeunit logic.

## Chapter Summary

- ✅ You reviewed key AL primitive and complex types
- ✅ You practiced purposeful variable declaration and scope control
- ✅ You learned type-safety habits that prevent later business-logic bugs
- ✅ You prepared for strongly typed table and codeunit development

---

## Tasks

1. **Type review.** Classify five fields from your project as `Code`, `Text`, `Decimal`, `Boolean`, or `Date` and justify each choice.
2. **Procedure cleanup.** Refactor one procedure to remove unnecessary global variables.
3. **Validation guard.** Add one explicit validation where type misuse could cause incorrect business output.

**Check your work:** your type choices should stay consistent when those same fields appear in Chapters 7, 9, and 15.
