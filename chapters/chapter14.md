# Chapter 14: Testing and Debugging

## Objectives

By the end of this chapter you will be able to:

- ✅ Explain what a test codeunit is and how it differs from a normal one
- ✅ Write a test method using the AAA pattern (Arrange, Act, Assert)
- ✅ Use the `Assert` codeunit to verify expected results
- ✅ Set a breakpoint and step through code with the VS Code debugger
- ✅ Apply testing best practices you can defend in a code review

## 14.1 What Is a Test Codeunit?

A test codeunit is a normal codeunit with `Subtype = Test`, containing
methods marked `[Test]`. The test runner calls each `[Test]` method,
and each one either passes silently or fails with a message pointing at
exactly what went wrong — far faster feedback than manually clicking
through the UI after every change.

```al
codeunit 50102 "Loan Repayment Mgt. Tests"
{
    Subtype = Test;

    [Test]
    procedure MarkInstallmentPaidSetsPaymentDate()
    begin
        // test body goes here
    end;
}
```

## 14.2 Arrange, Act, Assert

Every test method follows the same three-part shape: set up the data
you need (**Arrange**), call the code under test (**Act**), then check
the result (**Assert**).

```al
[Test]
procedure MarkInstallmentPaidSetsPaymentDate()
var
    LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    LoanRepaymentMgt: Codeunit "Loan Repayment Mgt.";
begin
    // Arrange
    LoanRepaymentSchedule.Init();
    LoanRepaymentSchedule."Loan No." := 'LOAN0001';
    LoanRepaymentSchedule."Installment No." := 1;
    LoanRepaymentSchedule."Principal Amount" := 1000;
    LoanRepaymentSchedule."Interest Amount" := 50;
    LoanRepaymentSchedule.Insert(true);

    // Act
    LoanRepaymentMgt.MarkInstallmentPaid(LoanRepaymentSchedule);

    // Assert
    Assert.IsTrue(LoanRepaymentSchedule.Paid, 'Installment should be marked paid.');
    Assert.AreEqual(Today, LoanRepaymentSchedule."Payment Date", 'Payment date should be today.');
end;
```

> **HINT** — `Assert.AreEqual` takes the *expected* value first and the
> *actual* value second. Getting this backwards doesn't break the test,
> but it makes failure messages confusing to read later.

## 14.3 Testing the Bug You Fixed in Chapter 9

A regression test is a test written specifically so a fixed bug can
never silently come back. Chapter 9 fixed a trigger that would have
blocked the paid transition — that's worth locking in with a test.

```al
[Test]
procedure MarkingPaidDoesNotTriggerBlockedEditError()
var
    LoanRepaymentSchedule: Record "Loan Repayment Schedule";
    LoanRepaymentMgt: Codeunit "Loan Repayment Mgt.";
begin
    // Arrange
    LoanRepaymentSchedule.Init();
    LoanRepaymentSchedule."Loan No." := 'LOAN0001';
    LoanRepaymentSchedule."Installment No." := 1;
    LoanRepaymentSchedule.Insert(true);

    // Act — this should succeed, not raise the "cannot be changed" error
    LoanRepaymentMgt.MarkInstallmentPaid(LoanRepaymentSchedule);

    // Assert
    Assert.IsTrue(LoanRepaymentSchedule.Paid, 'Marking paid should succeed without error.');
end;
```

> **HINT** — If this test had existed in Chapter 7, it would have failed
> immediately and caught the `Rec`/`xRec` bug before it ever reached a
> user. Writing the test the moment you fix a bug is what keeps it fixed.

## 14.4 Debugging with Breakpoints

Not every problem is worth a written test first — sometimes you just
need to see what's happening. In VS Code, click in the gutter to the
left of a line number to set a breakpoint, then launch with debugging
(F5). Execution pauses at that line, and you can inspect variable values,
step line-by-line (F10), or step into a called procedure (F11).

> **HINT** — Set the breakpoint on the *first* line inside the loop or
> procedure you suspect, not somewhere further down — you want to catch
> the state as early as possible, before it's had a chance to go wrong.

## 14.5 Best Practices for Testing and Debugging

- **One assertion concept per test** — a test named
  `MarkInstallmentPaidSetsPaymentDate` shouldn't also silently check
  three unrelated things
- **Name tests after what they verify**, not after the procedure they
  call — future-you will thank present-you when a test fails
- **Write a regression test the moment you fix a bug**, not "later"
- **Reach for a breakpoint before adding `Message()` calls everywhere**
  — messages linger in code after you're done debugging; breakpoints
  don't

## Chapter Summary

- ✅ You wrote a test codeunit with `Subtype = Test`
- ✅ You structured a test with Arrange, Act, Assert
- ✅ You used `Assert.IsTrue` and `Assert.AreEqual`
- ✅ You wrote a regression test for the Chapter 9 bug fix
- ✅ You know how to set a breakpoint and step through code

---

## Tasks

1. **Create the test codeunit.** Create `Codeunits/LoanRepaymentMgtTests.Codeunit.al` with `Subtype = Test`.
2. **Write the paid-date test.** Add
   `MarkInstallmentPaidSetsPaymentDate` from 14.2.
3. **Write the regression test.** Add
   `MarkingPaidDoesNotTriggerBlockedEditError` from 14.3, and confirm it
   passes against your current (fixed) table.
4. **Break it on purpose.** Temporarily revert your Chapter 9 fix
   (change `xRec.Paid` back to `Paid`), rerun the test, and confirm it
   now fails. Then put the fix back.
5. **Try it yourself.** Write a third test for `GenerateSchedule`: given
   `NumberOfInstallments = 3`, assert that exactly 3 records exist for
   the loan afterward.

**Check your work:** compare your test codeunit against the reference
solution in `/solutions/chapter14/` in this repo.
