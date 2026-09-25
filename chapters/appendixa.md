# Appendix A: AL Syntax Reference

## Objectives

By the end of this appendix you will be able to:

- ✅ Quickly look up common AL syntax and object patterns
- ✅ Reuse safe, production-oriented code templates
- ✅ Avoid beginner syntax mistakes that block compile or runtime behavior
- ✅ Cross-reference syntax patterns used throughout Chapters 7–17

## A.1 Core Syntax Cheatsheet

### Object and procedure scaffolding

```al
codeunit 50100 "Example"
{
    procedure DoWork(InputValue: Integer): Integer
    var
        Result: Integer;
    begin
        Result := InputValue + 1;
        exit(Result);
    end;
}
```

### Conditionals and loops

```al
if IsValid then
    Process()
else
    Error('Validation failed.');

if Rec.FindSet() then
    repeat
        HandleRec(Rec);
    until Rec.Next() = 0;
```

## A.2 Common AL Patterns (Practical)

### Record filtering before iteration

```al
Installment.SetRange(Paid, false);
if Installment.FindSet() then
    repeat
        ProcessInstallment(Installment);
    until Installment.Next() = 0;
```

### Safe state transition in trigger logic

```al
trigger OnModify()
begin
    if xRec.Paid then
        Error('A paid installment cannot be changed.');
end;
```

### Event subscriber scaffold

```al
[EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterInsertEvent', '', false, false)]
local procedure OnAfterInsertVendor(var Rec: Record Vendor)
begin
    // reaction logic
end;
```

## A.3 Frequent Syntax Pitfalls

- Using `=` instead of `:=` for assignment
- Forgetting `begin/end` for multi-line blocks
- Calling `FindSet` before `SetRange`
- Checking `Rec` when prior state requires `xRec`
- Mixing field names with inconsistent casing or quoting

## A.4 Quick Lookup Table

| Need | Recommended AL construct |
|---|---|
| Reusable business rule | Codeunit procedure |
| Data integrity at source | Table trigger + field properties |
| User-triggered workflow | Page action calling codeunit |
| Extension reaction point | Publisher/subscriber events |
| Regression safety | Test codeunit + assertions |

## Appendix Summary

- ✅ You have a compact syntax reference for daily AL work
- ✅ You have practical patterns that match this book's architecture
- ✅ You can identify and avoid common syntax and flow mistakes

---

## Tasks

1. **Pattern matching.** Pick two chapter snippets and map each to a pattern in A.2.
2. **Pitfall review.** Check one of your objects for at least two A.3 pitfalls.
3. **Try it yourself.** Add one personal syntax snippet to your local notes for future reuse.

**Check your work:** your selected patterns should align with Chapters 7, 9, 11, 14, and 17 practices.
