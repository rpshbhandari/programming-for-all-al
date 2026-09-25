# Chapter 13: Performance Optimization

## Objectives

By the end of this chapter you will be able to:

- ✅ Explain why performance habits matter more in a multi-tenant SaaS system than they might in other software
- ✅ Filter records before looping instead of after
- ✅ Use `SetLoadFields` to avoid pulling columns you don't need
- ✅ Recognize and avoid database calls inside a loop
- ✅ Apply performance best practices you can defend in a code review

## 13.1 Why Performance Habits Matter

Business Central is a SaaS product — your extension's code runs
alongside every other extension in the same tenant, sharing the same
database resources. A loop that's "fine" on a test company with 50
records can time out on a customer's production company with 500,000.
Performance isn't a late-stage optimization pass here; it's a habit you
build into the first draft.

## 13.2 Filter Before You Loop

The single most common mistake is reading every record and then
checking a condition in AL code, instead of asking the database to
filter first.

```al
// Slow: reads every row, checks Paid in AL for each one
LoanRepaymentSchedule.FindSet();
repeat
    if not LoanRepaymentSchedule.Paid then
        // ...
until LoanRepaymentSchedule.Next() = 0;
```

```al
// Fast: the database only returns unpaid rows
LoanRepaymentSchedule.SetRange(Paid, false);
if LoanRepaymentSchedule.FindSet() then
    repeat
        // ...
    until LoanRepaymentSchedule.Next() = 0;
```

> **HINT** — `SetRange`/`SetFilter` always go *before* `FindSet`. Calling
> them after has no effect on a find that already ran.

## 13.3 `SetLoadFields`: Only Ask for What You Use

By default, AL loads every field of a record even if your code only
reads two of them. On a wide table, that's wasted work on every single
row.

```al
LoanRepaymentSchedule.SetLoadFields("Loan No.", "Due Date", Paid);
LoanRepaymentSchedule.SetRange(Paid, false);
if LoanRepaymentSchedule.FindSet() then
    repeat
        // only "Loan No.", "Due Date", and Paid are populated here
    until LoanRepaymentSchedule.Next() = 0;
```

> **HINT** — If you call `SetLoadFields` and then reference a field you
> didn't list, AL either loads it lazily (small extra cost) or in some
> contexts returns a blank value — always list every field your loop
> body actually touches.

## 13.4 Don't Call the Database Inside a Loop

A `Get()`, `.Insert()`, or another record's `FindSet()` inside a loop
multiplies your database round-trips by the number of iterations.

```al
// Slow: one database read per installment, inside the loop
LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
if LoanRepaymentSchedule.FindSet() then
    repeat
        Loan.Get(LoanRepaymentSchedule."Loan No.");  // repeated, but Loan No. never changes here
        // ...
    until LoanRepaymentSchedule.Next() = 0;
```

```al
// Fast: read the loan once, outside the loop
Loan.Get(LoanNo);
LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
if LoanRepaymentSchedule.FindSet() then
    repeat
        // Loan is already available here
    until LoanRepaymentSchedule.Next() = 0;
```

## 13.5 Best Practices for Performance

- **Filter first, always** — `SetRange`/`SetFilter` before `FindSet`,
  never a condition-then-skip inside the loop
- **`SetLoadFields` on any loop over a table with more than a handful of
  fields** — especially reports and background jobs over large tables
- **Hoist anything constant across iterations outside the loop** — a
  `Get()` that doesn't depend on the loop variable doesn't belong inside it
- **Test against realistic data volumes**, not just your five-row demo
  company, before calling something "done"

## Chapter Summary

- ✅ You learned why SaaS multi-tenancy raises the stakes on performance habits
- ✅ You filter with `SetRange`/`SetFilter` before looping, not after
- ✅ You use `SetLoadFields` to avoid loading unused columns
- ✅ You know to hoist unchanging lookups outside a loop

---

## Tasks

1. **Filter `GenerateSchedule`'s caller.** Write a procedure that loops
   over all unpaid installments across every loan and prints a count.
   Use `SetRange(Paid, false)` before `FindSet`, not an `if` inside the
   loop.
2. **Add `SetLoadFields`.** To the procedure from task 1, add
   `SetLoadFields` listing only the fields you actually read.
3. **Find the hoist.** Imagine a procedure that, for every installment,
   looks up the loan's borrower name from a `Loan` header table. If the
   procedure only ever processes installments from a single loan at a
   time, where should that lookup happen — inside or outside the loop?
   Rewrite the pseudocode to put it in the right place.
4. **Try it yourself.** `GenerateSchedule` from Chapter 9 inserts records
   one at a time with `Insert(true)`. For very large installment counts,
   would you change anything about how it writes records? What would
   you check before deciding that's worth doing?

**Check your work:** compare your procedures against the reference
solution in `/solutions/chapter13/` in this repo.
