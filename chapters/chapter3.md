# Chapter 3: First Steps with AL

## Objectives

By the end of this chapter you will be able to:

- ✅ Create a minimal AL extension with a table, page, and codeunit
- ✅ Explain the role of each object in the extension architecture
- ✅ Publish and test your first end-to-end interaction
- ✅ Use basic debugging to validate behavior before adding complexity

## 3.1 Build a Minimal Vertical Slice

Your first AL project should include one small but complete flow:

- A table for data
- A page to view/edit records
- A codeunit procedure called from the page

This mirrors the architecture used throughout Chapters 7–16 and prevents overloading page triggers with business logic.

## 3.2 Keep Logic Placement Intentional

Use this placement rule from day one:

- **Table trigger** for data integrity constraints
- **Codeunit procedure** for reusable business logic
- **Page action** only as the entry point that calls codeunit logic

That is the same pattern formalized in Chapter 9 and tested in Chapter 14.

## 3.3 Publish, Run, and Inspect

After publishing with F5:

1. Open your page in Business Central.
2. Create sample data.
3. Trigger your page action.
4. Confirm resulting table changes are correct.

If something is wrong, inspect behavior in debugger before editing multiple files.

## 3.4 Basic Debugging Loop

Use a tight debug loop:

1. Reproduce one issue.
2. Place breakpoints at object boundaries (page action → codeunit → table trigger).
3. Inspect `Rec` values before and after procedure calls.
4. Change one thing, retest, repeat.

This habit makes Chapter 9's `Rec` vs `xRec` topic much easier.

## Chapter Summary

- ✅ You built and published a minimal extension slice
- ✅ You practiced correct logic placement across table/page/codeunit
- ✅ You validated behavior through execution, not assumptions
- ✅ You established a repeatable debugging workflow for later chapters

---

## Tasks

1. **Create a starter object set.** Add one table, one page, and one codeunit.
2. **Wire an action.** Add a page action that calls a codeunit procedure.
3. **Validate update flow.** Confirm the called procedure changes data as expected.
4. **Try it yourself.** Record one bug you found with a breakpoint and what value inspection revealed.

**Check your work:** your flow should resemble the Chapter 8→9 pattern where a page action invokes codeunit logic instead of embedding business rules inline.
