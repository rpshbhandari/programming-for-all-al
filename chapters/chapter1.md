# Chapter 1: Understanding Application Language (AL)

## Objectives

By the end of this chapter you will be able to:

- ✅ Explain what AL is and where it runs in Business Central
- ✅ Describe why extensions replaced direct base-application edits
- ✅ Identify the main AL object types and what each one is responsible for
- ✅ Trace how this book's loan-repayment example will evolve across later chapters

## 1.1 What Is AL?

Application Language (AL) is Microsoft's language for building and extending Dynamics 365 Business Central. AL is not a general-purpose desktop language; it is designed for ERP workflows, data validation, and process automation inside Business Central.

In practical terms, AL is how you define:

- **Data structures** (tables)
- **User experiences** (pages)
- **Business rules** (codeunits and triggers)
- **Output and integration surfaces** (reports, APIs, events)

## 1.2 From C/AL to AL: Why the Model Changed

Earlier Dynamics products used C/AL and direct customization of base objects. AL introduced an extension-first model so your custom logic is packaged separately from Microsoft's base app.

This matters because extensions:

- isolate your changes from core product code,
- reduce upgrade risk,
- support clean deployment and versioning,
- enable safer collaboration between multiple partners on one tenant.

Chapter 11 will revisit this with `app.json`, package metadata, and permission sets.

## 1.3 AL Object Types and Responsibilities

A common beginner mistake is putting all logic in one object. In this book, each object has a clear job:

- **Table**: schema and integrity rules
- **Page**: data entry and user actions
- **Codeunit**: reusable business procedures
- **Permission set**: who can do what
- **Test codeunit**: automated verification

That separation is central to the case-study flow explained in Chapter 16.

## 1.4 The Running Example for This Book

From Chapters 7–16, you'll build a **Loan Repayment Management** extension. The journey is intentional:

1. Create table structure and constraints (Chapter 7)
2. Add a list page and actions (Chapter 8)
3. Move logic into codeunits (Chapter 9)
4. Package and secure the extension (Chapters 11 and 15)
5. Protect behavior with tests (Chapter 14)

This chapter's goal is not to write code yet; it's to understand why that architecture is the right one.

## Chapter Summary

- ✅ AL is Business Central's extension language for ERP data and workflows
- ✅ Extension packaging replaced direct base-code customization for upgrade safety
- ✅ Object responsibilities must be separated (table/page/codeunit/security/tests)
- ✅ Later chapters build one coherent loan-repayment extension end-to-end

---

## Tasks

1. **Architecture mapping.** Write one sentence each for what belongs in a table, page, and codeunit.
2. **Upgrade reasoning.** Explain why extension packaging is safer than editing base objects directly.
3. **Continuity checkpoint.** List the first three chapters where the Loan Repayment example is implemented (by chapter number and purpose).

**Check your work:** your answers should align with the object separation used in Chapters 7–9 and the end-to-end flow in Chapter 16.
