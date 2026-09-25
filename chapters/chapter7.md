# Chapter 7: Creating and Managing Tables

## Objectives

By the end of this chapter you will be able to:

- ✅ Design a table with reliable keys and field constraints
- ✅ Use `TableRelation`, `NotBlank`, and validation triggers correctly
- ✅ Apply trigger logic that protects data integrity without blocking valid updates
- ✅ Prepare a table structure that later chapters can build on safely

## 7.1 Defining Tables in AL

Tables hold your extension's source of truth. A good table design enforces rules close to the data, not only in UI code.

```al
table 50100 "Loan Repayment Schedule"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Loan No."; Code[20]) { DataClassification = CustomerContent; }
        field(2; "Installment No."; Integer) { DataClassification = CustomerContent; }
        field(3; "Due Date"; Date) { DataClassification = CustomerContent; }
        field(4; "Principal Amount"; Decimal) { DataClassification = CustomerContent; }
        field(5; "Interest Amount"; Decimal) { DataClassification = CustomerContent; }
        field(6; "Total Amount"; Decimal) { DataClassification = CustomerContent; }
        field(7; Paid; Boolean) { DataClassification = CustomerContent; }
    }

    keys
    {
        key(PK; "Loan No.", "Installment No.") { Clustered = true; }
    }
}
```

## 7.2 Keys and Indexing Strategy

Use a primary key that reflects uniqueness of business meaning. In this case, one installment number is unique only within a loan, so a composite key is appropriate.

Add secondary keys only for real query paths. Extra keys speed reads but slow writes.

## 7.3 Field Properties and Validation

Use field properties to move obvious rules out of procedural code:

- `NotBlank = true` where empty values are invalid
- `TableRelation` for foreign-key style lookups
- `MinValue` where negative values are impossible

This reduces duplicated checks in pages and codeunits.

## 7.4 Triggers for Data Integrity

Keep trigger logic minimal and deterministic.

```al
trigger OnInsert()
begin
    "Total Amount" := "Principal Amount" + "Interest Amount";
end;

trigger OnModify()
begin
    if xRec.Paid then
        Error('A paid installment cannot be changed.');
    "Total Amount" := "Principal Amount" + "Interest Amount";
end;
```

Use `xRec` when checking prior state; using `Rec` here would block valid state transitions (covered deeply in Chapter 9).

## 7.5 Table Design Practices

- Keep derived values consistent (`Total Amount` from principal + interest).
- Avoid side effects that belong in codeunits.
- Align field classification and permissions with Chapters 11 and 15.

## Chapter Summary

- ✅ You designed a table with business-correct keys
- ✅ You used properties and relations to enforce integrity
- ✅ You implemented trigger logic with correct `Rec`/`xRec` semantics
- ✅ You established a table foundation for page and codeunit work

---

## Tasks

1. **Create the table.** Implement `Loan Repayment Schedule` with composite key and core fields.
2. **Add constraints.** Apply `TableRelation`, `NotBlank`, and value guards where needed.
3. **Harden triggers.** Ensure `OnModify` checks `xRec.Paid` before allowing edits.
4. **Try it yourself.** Add one additional field and justify its `DataClassification`.

**Check your work:** Chapter 9's codeunit and Chapter 14's tests should run against this table design without trigger-related regressions.
