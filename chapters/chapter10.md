# Chapter 10: Reports and Data Analysis

## Objectives

By the end of this chapter you will be able to:

- ✅ Build AL reports with correctly scoped data items
- ✅ Link parent/child data items safely
- ✅ Apply practical filtering for useful report output
- ✅ Design report logic that complements table/codeunit architecture

## 10.1 Report Structure in AL

A report has two core parts:

- **Dataset** (`dataitem` hierarchy)
- **Layout** (RDLC or Word)

Start by getting dataset correctness right; layout comes second.

```al
report 50110 "Loan Installment Summary"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    dataset
    {
        dataitem(Installment; "Loan Repayment Schedule")
        {
            DataItemTableView = sorting("Loan No.", "Installment No.");
            column(LoanNo; "Loan No.") { }
            column(InstallmentNo; "Installment No.") { }
            column(DueDate; "Due Date") { }
            column(TotalAmount; "Total Amount") { }
            column(Paid; Paid) { }
        }
    }
}
```

## 10.2 Working with Data Items and Filters

Use filters to avoid generating oversized or irrelevant reports.

- Filter by loan number, date range, or paid status.
- Sort by business reading order.
- Keep dataitem links explicit when nesting.

This follows Chapter 13's "filter first" performance principle.

## 10.3 Layout and Output Guidance

- RDLC is stronger for pixel-perfect operational reports.
- Word layouts can be easier for document-style outputs.
- Keep business calculations in AL dataset logic, not ad-hoc layout formulas.

## 10.4 Reporting Accuracy and Maintainability

- Reuse calculated fields already enforced in tables when possible.
- Avoid re-deriving logic differently in report-only code.
- Validate sample outputs against source records before release.

## Chapter Summary

- ✅ You built a report dataset with clear business columns
- ✅ You applied useful filters and sorting patterns
- ✅ You aligned reporting logic with earlier data and codeunit rules
- ✅ You used layout choices intentionally for business outcomes

---

## Tasks

1. **Create a report.** Build a report over `Loan Repayment Schedule` showing due date and total amount.
2. **Add filters.** Add at least one request filter (for example, `Loan No.` or `Paid`).
3. **Validate totals.** Confirm reported `Total Amount` matches table-calculated values.
4. **Try it yourself.** Add one grouped or summarized output (for example, total unpaid amount per loan).

**Check your work:** ensure your report reads the same business truth enforced by Chapters 7 and 9, not a duplicate formula.
