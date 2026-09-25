# Chapter 16: ERP Case Studies and Examples

## Objectives

By the end of this chapter you will be able to:

- ✅ See how the individual AL objects you built in Chapters 7–15 form one coherent extension
- ✅ Trace a single business event through every layer: table, page, codeunit, permissions, tests
- ✅ Evaluate a second, unfamiliar case study using the same design questions
- ✅ Plan your own small extension from a business problem, not from a list of AL features

## 16.1 Case Study: Loan Repayment Management, End to End

Here's everything you built, in the order a request actually flows
through it:

1. A purchasing or finance user opens the **page** (Chapter 8) built on
   `Loan Repayment Schedule`.
2. The **table** (Chapter 7) enforces that every row has a valid
   `"Vendor No."`-style relation, a composite key of loan + installment,
   and a `"Total Amount"` that's always correct — because the table's
   own triggers calculate it, not the page.
3. Clicking "Mark Paid" runs a **page action** that calls
   `LoanRepaymentMgt.MarkInstallmentPaid` (Chapter 9) — not inline logic
   on the page, so the same rule applies no matter what calls it.
4. That codeunit's logic is protected by a **test** (Chapter 14) that
   would fail loudly if a future change reintroduced the `Rec`/`xRec`
   bug from Chapter 9.
5. Only users holding the right **permission set** (Chapters 11 and 15)
   can open the page or run the codeunit at all — and a "View Only" role
   can see schedules without being able to touch them.
6. Every field on the table carries a **`DataClassification`** (Chapter
   15) that would hold up in a compliance review.

No single chapter's topic — tables, pages, codeunits, tests,
permissions — does the whole job. The extension only works because they
compose.

> **HINT** — This is the test of whether you actually understood a
> chapter's topic, not just copied its code: can you point to the one
> line in a *different* chapter's object that depends on it? If you
> can't, that's worth re-reading before moving on.

## 16.2 A Second Case Study: Petty Cash Log

Here's a new, smaller problem — work through the same design questions
yourself before reading the suggested answers:

> A small office wants to log petty cash disbursements: who received
> cash, how much, for what, and on what date. Someone should be able to
> mark an entry as "reconciled" once it's been checked against a
> physical receipt, and reconciled entries shouldn't be editable.

Ask yourself:

- What table(s) do you need? Is one table enough, or does "who received
  cash" imply a relation to an existing table (like `Employee`)?
- What would the composite or single-field primary key be?
- Which field(s) need a `MinValue`, `NotBlank`, or `TableRelation`?
- What trigger enforces "reconciled entries can't be edited" — and does
  it need the `Rec`/`xRec` lesson from Chapter 9?
- What single procedure in a codeunit should "mark reconciled" call
  through, rather than being written directly on a page action?
- What would a "View Only" vs "Full Access" permission set look like
  for this?

> **Try it yourself** — Before looking at the suggested design below,
> sketch your own table definition for Petty Cash Log on paper or in a
> scratch `.al` file.

**A reasonable design**, for comparison: a `Petty Cash Log` table with
an auto-increment `"Entry No."` primary key (not composite — there's no
natural grouping field the way loans group installments), a
`"Received By"` field with `TableRelation = Employee."No."`, `Amount`,
`Purpose`, `"Entry Date"`, and `Reconciled` (Boolean). The `OnModify`
trigger checks `xRec.Reconciled`, exactly like Chapter 9's fix. A
`"Petty Cash Mgt."` codeunit exposes `MarkReconciled`, called from a
page action — never written inline on the page.

## 16.3 Planning Your Own Extension

The habit worth building from these case studies: start from the
business problem and the questions in 16.2, not from "which AL features
should I use." The table design falls out of the answers, not the other
way around.

## Chapter Summary

- ✅ You traced how every AL object type from Chapters 7–15 contributes
  to one working extension
- ✅ You worked through a second case study using the same design
  questions, before seeing a suggested answer
- ✅ You have a repeatable set of questions to start any new extension
  from a business problem

---

## Tasks

1. **Diagram your extension.** Draw (on paper or in any tool) the six
   steps from 16.1 as boxes and arrows, labeling which AL object handles
   each step.
2. **Build Petty Cash Log.** Implement the table, codeunit, permission
   sets, and at least one test for the case study in 16.2, using
   Chapters 7–15 as your reference — but write the code yourself.
3. **Try it yourself.** Petty Cash Log's suggested design uses a single
   auto-increment key instead of a composite one like Loan Repayment
   Schedule. Write one sentence explaining why a composite key wasn't
   the right choice here.

**Check your work:** compare your Petty Cash Log objects against the
reference solution in `/solutions/chapter16/` in this repo.
