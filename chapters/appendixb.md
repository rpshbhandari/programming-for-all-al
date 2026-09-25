# Appendix B: Troubleshooting and FAQs

## Objectives

By the end of this appendix you will be able to:

- ✅ Diagnose common AL development failures faster
- ✅ Use a repeatable debug checklist before changing code
- ✅ Classify errors by layer (environment, compile, runtime, data)
- ✅ Apply issue-resolution habits that improve contribution quality

## B.1 Debug Checklist (Use in Order)

1. **Environment check**: VS Code AL extension installed, symbols downloaded, sandbox reachable.
2. **Compile check**: resolve first error in output before chasing downstream errors.
3. **Repro check**: reproduce with minimum steps and known sample data.
4. **Boundary check**: inspect page action → codeunit → table trigger transitions.
5. **Data check**: verify key fields and prior state (`xRec`) assumptions.
6. **Regression check**: add or run tests for the fixed behavior (Chapter 14).

## B.2 Common Error Catalog

| Error symptom | Likely cause | First fix step |
|---|---|---|
| `Table ... not found` | Missing symbol reference or wrong object ID/range | Re-download symbols and verify object metadata |
| `The record already exists` | Duplicate key on insert | Validate key design and duplicate guards |
| `You do not have permission ...` | Missing permission set grants | Review Chapter 11/15 permission setup |
| Runtime `cannot be changed` unexpectedly | Trigger checks current state (`Rec`) instead of prior state (`xRec`) | Correct trigger logic and add regression test |
| API call fails with non-success status | Remote endpoint/auth/contract mismatch | Log status code and validate request contract |

## B.3 FAQ

### How do I know whether logic belongs in a page trigger or codeunit?

Put reusable business rules in a codeunit and call from page actions. Keep page code thin (Chapter 8 and 9).

### Why does my trigger block valid edits?

Check whether your rule needs pre-change state (`xRec`) instead of current state (`Rec`) in `OnModify`.

### When should I add tests?

Immediately after adding or fixing business logic, especially bug fixes that could regress (Chapter 14).

## B.4 Escalation Notes for Contributors

When opening an issue or PR:

- include minimal repro steps,
- include observed vs expected behavior,
- link affected chapter/object,
- include validation evidence.

## Appendix Summary

- ✅ You now have a practical troubleshooting sequence
- ✅ You can map common errors to likely causes quickly
- ✅ You can package technical findings clearly for collaboration

---

## Tasks

1. **Checklist run.** Apply B.1 to one recent issue you encountered.
2. **Error mapping.** Add one new row to the error catalog from your own experience.
3. **Try it yourself.** Write a minimal repro template for future chapter bugs.

**Check your work:** your troubleshooting notes should be detailed enough for another contributor to reproduce and validate your fix.
