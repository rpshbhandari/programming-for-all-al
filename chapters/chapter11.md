# Chapter 11: Extensions and Customizations

## Objectives

By the end of this chapter you will be able to:

- ✅ Explain what an AL extension is and why it's preferred over modifying base code
- ✅ Read and edit the key fields in `app.json`
- ✅ Create a permission set that grants access to your own objects
- ✅ Extend standard behavior with an event subscriber instead of changing base code
- ✅ Apply extension-packaging best practices you can defend in a code review

## 11.1 What Is an Extension?

Business Central customizations used to mean editing Microsoft's own
source code directly — risky, and painful to upgrade. An **extension**
is a separate package of AL objects (tables, pages, codeunits, and so
on) that adds or modifies behavior without touching the base
application's code. Everything you've built so far — the `Loan
Repayment Schedule` table, its page, and the `Loan Repayment Mgt.`
codeunit — already lives inside an extension; this chapter is about
packaging it properly and extending *other* objects safely.

## 11.2 Anatomy of `app.json`

Every extension has an `app.json` manifest describing what it is and
what it depends on.

```json
{
  "id": "b1f0c1a2-1234-4a1b-9c3d-1a2b3c4d5e6f",
  "name": "Loan Repayment Management",
  "publisher": "Your Company",
  "version": "1.0.0.0",
  "brief": "Track loan installments and repayment status.",
  "idRanges": [
    {
      "from": 50100,
      "to": 50149
    }
  ],
  "dependencies": [],
  "runtime": "12.0"
}
```

> **HINT** — `idRanges` isn't decoration: if an object ID falls outside
> the declared range, the extension won't compile. Reserve a range
> early and keep every object you create inside it.

## 11.3 Permission Sets

Creating a table doesn't automatically let anyone use it — Business
Central is deny-by-default. A permission set grants access to your
objects as a named bundle you can assign to users or roles.

```al
permissionset 50100 "Loan Repayment"
{
    Assignable = true;
    Caption = 'Loan Repayment Management';

    Permissions =
        table "Loan Repayment Schedule" = X,
        page "Loan Repayment Schedule List" = X,
        codeunit "Loan Repayment Mgt." = X;
}
```

> **HINT** — `X` grants full CRUD-plus-execute. For a read-only reporting
> role, use `R` instead. Don't default everything to `X` just because
> it's less to think about — that's exactly the kind of blanket grant a
> security review will flag.

## 11.4 Extending Without Modifying: Event Subscribers

Sometimes you want to react to something happening in a *standard*
object without touching it. Microsoft publishes events for this — you
write a subscriber, not a modification.

```al
codeunit 50101 "Loan Repayment Event Subscribers"
{
    [EventSubscriber(ObjectType::Table, Database::Vendor, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertVendor(var Rec: Record Vendor)
    begin
        Message('New vendor %1 created — remember to check for outstanding loans.', Rec."No.");
    end;
}
```

> **HINT** — A `Message` here is just for learning; in real extensions,
> a subscriber usually does something quieter — writes a log entry,
> creates a related record, or sets a default. Popping a dialog on every
> vendor insert would annoy every user in the company.

## 11.5 Best Practices for Extensions

- **Reserve your ID range once, and stick to it** — mixing ranges across
  extensions is a common source of deployment conflicts
- **Grant the minimum permission needed** — `R` where read-only is
  enough, `X` only where it isn't
- **Prefer event subscribers over any form of base-object modification**
  — subscribers survive Microsoft's updates; modifications don't
- **Name things so a permission set's purpose is obvious from its
  caption alone** — "Loan Repayment Management," not "Custom Perms 1"

## Chapter Summary

- ✅ You learned why extensions replaced direct base-code modification
- ✅ You read and understand the key fields of `app.json`
- ✅ You created a permission set granting access to your own objects
- ✅ You wrote an event subscriber that reacts to a standard table
  without modifying it

---

## Tasks

1. **Write your `app.json`.** Create one for the Loan Repayment
   extension with an `idRanges` block covering `50100`–`50149`, and
   confirm every object you built in Chapters 7–9 falls inside it.
2. **Create the permission set.** Add `permissionset 50100 "Loan
   Repayment"` granting `X` on your table, page, and codeunit.
3. **Add an event subscriber.** Subscribe to `Vendor`'s
   `OnAfterInsertEvent` (or another standard table's insert event) and
   log or message something relevant to your extension.
4. **Try it yourself.** Your permission set currently grants `X` on
   everything. If you wanted a "read-only auditor" role that could view
   loan data but never change it, what would you change?

**Check your work:** compare your files against the reference solution
in `/solutions/chapter11/` in this repo.
