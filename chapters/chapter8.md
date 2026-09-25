# Chapter 8: Designing Pages and User Interfaces

## Objectives

By the end of this chapter you will be able to:

- ✅ Choose suitable page types for common AL scenarios
- ✅ Build a list page over your Chapter 7 table
- ✅ Add actions that delegate logic to codeunits
- ✅ Keep UI code thin and maintainable

## 8.1 Page Types and Responsibilities

Common page types:

- **Card**: one record at a time
- **List**: many records in a grid
- **Document**: header/lines transactional workflows

For loan installments, a **List** page is the natural first UI.

## 8.2 Building a List Page

```al
page 50100 "Loan Repayment Schedule List"
{
    PageType = List;
    SourceTable = "Loan Repayment Schedule";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Loan No."; "Loan No.") { ApplicationArea = All; }
                field("Installment No."; "Installment No.") { ApplicationArea = All; }
                field("Due Date"; "Due Date") { ApplicationArea = All; }
                field(Paid; Paid) { ApplicationArea = All; }
            }
        }
    }
}
```

## 8.3 Actions and Separation of Concerns

Actions should call procedures, not embed core rules.

```al
action(MarkPaid)
{
    ApplicationArea = All;
    Caption = 'Mark Paid';

    trigger OnAction()
    var
        LoanRepaymentMgt: Codeunit "Loan Repayment Mgt.";
    begin
        LoanRepaymentMgt.MarkInstallmentPaid(Rec);
        CurrPage.Update(false);
    end;
}
```

This keeps the page aligned with Chapter 9's business-logic boundary.

## 8.4 UI Quality Practices

- Expose fields users need now; avoid clutter.
- Keep captions explicit and business-friendly.
- Do not duplicate table validation rules in the page unless UX requires earlier feedback.

## Chapter Summary

- ✅ You selected page types by business use, not habit
- ✅ You implemented a list page over Chapter 7 data
- ✅ You added thin actions that call codeunit logic
- ✅ You prepared the UI layer for reuse and testability

---

## Tasks

1. **Create the list page.** Build a page for `Loan Repayment Schedule`.
2. **Add a business action.** Add `Mark Paid` wired to a codeunit call.
3. **Review field set.** Keep only fields required for day-to-day installment operations.
4. **Try it yourself.** Add one UX improvement (sorting, grouping, or action placement) and justify it.

**Check your work:** your page action should remain thin and delegate business logic to Chapter 9 codeunit procedures.
