# Chapter 9: Developing Business Logic with Codeunits

## Objectives

By the end of this chapter you will be able to:

- ✅ Explain what a codeunit is and when logic belongs in one instead of a
  table or page trigger
- ✅ Write public and local procedures, with parameters and return values
- ✅ Call a codeunit from a page action
- ✅ Recognize the `Rec` vs `xRec` distinction and why it matters in triggers
- ✅ Apply codeunit best practices you can defend in a code review

## 9.1 What Is a Codeunit?

A codeunit is a container for procedures — it has no UI and no data
structure of its own. It exists purely to hold business logic so that
logic can be reused, tested, and called from more than one place (a
page action, another codeunit, a report, an API).

A good rule of thumb: if logic is more than a line or two, or if more
than one object might need to call it, it belongs in a codeunit —
not duplicated inside a table trigger or a page action.

```al
codeunit 50100 "Loan Repayment Mgt."
{
    // Procedures go here
}
```

## 9.2 Public and Local Procedures

Procedures are public by default — callable from any other object that
has a variable of this codeunit's type. Mark a procedure `local` when
it's only a helper for other procedures in the same codeunit; this keeps
your codeunit's public surface small and easy to understand from the
outside.

```al
procedure MarkInstallmentPaid(var LoanRepaymentSchedule: Record "Loan Repayment Schedule")
begin
    LoanRepaymentSchedule."Payment Date" := Today;
    LoanRepaymentSchedule.Paid := true;
    LoanRepaymentSchedule.Modify(true);
end;

local procedure CalculateTotal(PrincipalAmount: Decimal; InterestAmount: Decimal): Decimal
begin
    exit(PrincipalAmount + InterestAmount);
end;
```

> **HINT** — `var` before a parameter passes it by reference: changes the
> procedure makes to `LoanRepaymentSchedule` are visible to the caller.
> Leave off `var` for a parameter you only want to read, like the
> amounts going into `CalculateTotal`.

## 9.3 A Gotcha: `Rec` vs `xRec`

Chapter 7's `OnModify` trigger checked `if Paid then Error(...)` to block
edits to a paid installment. Look closely, though: by the time
`OnModify` runs, `Rec` already holds the *new* values you're about to
save — including the very change from `Paid = false` to `Paid = true`
that `MarkInstallmentPaid` is trying to make. That trigger would block
the transition to paid too, not just edits after.

The fix is to check the record's state *before* this change, which AL
gives you as `xRec`:

```al
trigger OnModify()
begin
    if xRec.Paid then
        Error('A paid installment cannot be changed.');
    "Total Amount" := "Principal Amount" + "Interest Amount";
end;
```

> **HINT** — `Rec` is "the record as it will be saved"; `xRec` is "the
> record as it was before this change." Any time a trigger needs to ask
> "did this field just change?" rather than "what is this field now?",
> you need `xRec`. Go back and update the table from Chapter 7 with this
> fix before continuing.

## 9.4 A Procedure That Creates Multiple Records

Not all business logic modifies one record — generating a whole loan
schedule up front means inserting several rows in a loop, which is
exactly the kind of multi-step work that doesn't belong in a table
trigger.

```al
procedure GenerateSchedule(LoanNo: Code[20]; NumberOfInstallments: Integer; PrincipalPerInstallment: Decimal; InterestPerInstallment: Decimal; FirstDueDate: Date)
var
    LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    i: Integer;
begin
    for i := 1 to NumberOfInstallments do begin
        LoanRepaymentSchedule.Init();
        LoanRepaymentSchedule."Loan No." := LoanNo;
        LoanRepaymentSchedule."Installment No." := i;
        LoanRepaymentSchedule."Due Date" := CalcDate(StrSubstNo('<+%1M>', i - 1), FirstDueDate);
        LoanRepaymentSchedule."Principal Amount" := PrincipalPerInstallment;
        LoanRepaymentSchedule."Interest Amount" := InterestPerInstallment;
        LoanRepaymentSchedule.Insert(true);
    end;
end;
```

> **HINT** — `Insert(true)` (not just `Insert()`) tells AL to run the
> table's `OnInsert` trigger, so `"Total Amount"` still gets calculated
> for every generated row without you repeating that logic here.

## 9.5 Calling a Codeunit from a Page

Business logic is only useful once something can trigger it. A page
action is the most common entry point:

```al
trigger OnAction()
var
    LoanRepaymentMgt: Codeunit "Loan Repayment Mgt.";
begin
    LoanRepaymentMgt.MarkInstallmentPaid(Rec);
    CurrPage.Update(false);
end;
```

## 9.6 Best Practices for Codeunits

- **Single responsibility** — one codeunit per business area (`"Loan
  Repayment Mgt."` shouldn't also contain vendor logic)
- **Keep triggers thin** — a trigger should call a procedure, not
  contain the whole calculation itself
- **Check `xRec` for "what changed"** — never assume `Rec` alone tells
  you the previous state
- **Return simple values with `exit`, mutate records with `var`** —
  don't mix the two patterns in one procedure

## Chapter Summary

- ✅ You learned when logic belongs in a codeunit instead of a trigger
- ✅ You wrote a public procedure and a local helper procedure
- ✅ You found and fixed a real `Rec`/`xRec` bug from Chapter 7
- ✅ You wrote a procedure that generates multiple records in a loop
- ✅ You called a codeunit procedure from a page action

---

## Tasks

These tasks continue the `Loan Repayment Schedule` example from Chapter 7.

1. **Fix Chapter 7.** Go back to your `Loan Repayment Schedule` table's
   `OnModify` trigger and change `if Paid then` to `if xRec.Paid then`.
   Confirm you can now mark an installment paid without the trigger
   rejecting it.
2. **Create the codeunit.** Create
   `Codeunits/LoanRepaymentMgt.Codeunit.al` with ID `50100` and name
   `Loan Repayment Mgt.`.
3. **Add `MarkInstallmentPaid`.** Add the public procedure from 9.2 that
   sets `"Payment Date"` and `Paid`, then calls `Modify(true)`.
4. **Add `GenerateSchedule`.** Add the procedure from 9.4 that inserts
   `NumberOfInstallments` rows for a given loan, spaced one month apart.
5. **Wire it to a page action.** On your `Loan Repayment Schedule` list
   page (from Chapter 8), add an action that calls `MarkInstallmentPaid`
   on the selected record.
6. **Try it yourself.** `GenerateSchedule` doesn't check whether a
   schedule already exists for `LoanNo` before inserting new rows. What
   would happen if someone ran it twice for the same loan? Add whatever
   guard you think is needed.

**Check your work:** compare your codeunit against the reference
solution in `/solutions/chapter9/LoanRepaymentMgt.Codeunit.al` in this
repo.
