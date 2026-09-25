# Chapter 15: Security and Compliance

## Objectives

By the end of this chapter you will be able to:

- ✅ Explain what `DataClassification` communicates and why it isn't optional
- ✅ Audit an existing table's fields for correct classification
- ✅ Scope a permission set to the minimum access a role actually needs
- ✅ Distinguish object-level permission from field-level sensitivity
- ✅ Apply security best practices you can defend in a code review

## 15.1 `DataClassification` Is a Compliance Signal, Not Decoration

Every field you've written since Chapter 7 has carried a
`DataClassification`. That property tells Business Central (and anyone
auditing your extension) what kind of data the field holds for privacy
and compliance purposes — `CustomerContent` for business data belonging
to the customer, `EndUserIdentifiableInformation` for anything that
identifies a specific person, `SystemMetadata` for technical
housekeeping fields.

Setting every field to `ToBeClassified` and moving on defeats the
purpose — it's the field-level equivalent of leaving a form blank.

## 15.2 Auditing `Loan Repayment Schedule`

Let's review the fields from Chapter 7 with a compliance eye:

| Field | Classification | Why |
|---|---|---|
| `"Loan No."` | `CustomerContent` | Business data, not personal |
| `"Installment No."` | `CustomerContent` | Business data |
| `"Due Date"` / `"Payment Date"` | `CustomerContent` | Business data |
| `"Principal Amount"` / `"Interest Amount"` / `"Total Amount"` | `CustomerContent` | Financial business data |
| `Paid` | `CustomerContent` | Business data |

None of these fields identify a specific person, so `CustomerContent`
across the board is defensible here. If you later added a `"Borrower
Name"` field directly onto this table (rather than looking it up from a
`Customer` or `Loan` record), that field would need
`EndUserIdentifiableInformation` instead — a good reason, on top of
normalization, to keep personal data on its own table.

> **HINT** — When in doubt, ask: "if this field's value leaked, would it
> identify a real person?" If yes, it's `EndUserIdentifiableInformation`,
> not `CustomerContent`.

## 15.3 Scoping a Permission Set to a Role, Not "Everyone"

Chapter 11 granted `X` (full access) to every object in one permission
set. In practice, different roles need different access:

```al
permissionset 50103 "Loan Repayment - View"
{
    Assignable = true;
    Caption = 'Loan Repayment (View Only)';

    Permissions =
        table "Loan Repayment Schedule" = R,
        page "Loan Repayment Schedule List" = X;
}

permissionset 50104 "Loan Repayment - Full"
{
    Assignable = true;
    Caption = 'Loan Repayment (Full Access)';
    IncludedPermissionSets = "Loan Repayment - View";

    Permissions =
        table "Loan Repayment Schedule" = IMD,
        codeunit "Loan Repayment Mgt." = X;
}
```

> **HINT** — `IncludedPermissionSets` lets the "Full" set build on top of
> "View" instead of repeating its permissions. This also means a future
> change to what "View" grants automatically applies everywhere it's
> included — one thing to update, not several.

## 15.4 Field-Level Considerations

Object-level permissions (table, page, codeunit) control *whether* a
user can open something at all. They don't, on their own, hide specific
sensitive fields from a user who has table access — that requires page
design decisions (leaving a field off a page entirely, or making it
visible only to certain roles via a page extension) on top of correct
`DataClassification`.

## 15.5 Best Practices for Security and Compliance

- **Classify per field, honestly** — not blanket-set on the table, and
  never left at `ToBeClassified` in anything you ship
- **Design permission sets around roles**, not around "give this person
  what they're asking for right now"
- **Build layered permission sets** with `IncludedPermissionSets` rather
  than duplicating the same grants across several sets
- **Remember that permissions and page design are both part of security**
  — a user with table access can still be kept away from a sensitive
  field by how the page is built

## Chapter Summary

- ✅ You understand `DataClassification` as a compliance signal, not boilerplate
- ✅ You audited the Loan Repayment Schedule table's classifications
- ✅ You split one broad permission set into role-scoped ones
- ✅ You know the difference between object-level and field-level security

---

## Tasks

1. **Audit your table.** Go through every field on `Loan Repayment
   Schedule` and confirm its `DataClassification` matches the table in
   15.2. Fix any that don't.
2. **Split the permission set.** Replace the single permission set from
   Chapter 11 with the "View" and "Full" pair from 15.3.
3. **Assign roles.** Decide which of your test users would get "View"
   and which would get "Full," and write one sentence justifying each.
4. **Try it yourself.** Suppose a future chapter adds a `"Borrower Name"`
   field directly onto `Loan Repayment Schedule` (skipping the lookup to
   a `Loan` table). What `DataClassification` would it need, and what
   page-design decision would you make to limit who sees it?

**Check your work:** compare your permission sets against the reference
solution in `/solutions/chapter15/` in this repo.
