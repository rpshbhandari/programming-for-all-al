# Chapter 2: Setting Up Your AL Development Environment

## Objectives

By the end of this chapter you will be able to:

- ✅ Explain the minimum local prerequisites for AL development
- ✅ Create a new AL project in Visual Studio Code
- ✅ Configure a sandbox connection safely in `launch.json`
- ✅ Validate your environment before writing extension logic

## 2.1 Core Prerequisites

A productive AL setup needs four essentials:

1. **Visual Studio Code**
2. **AL Language extension** (from Microsoft)
3. **Business Central sandbox environment**
4. **User account with permission to publish and debug**

If any one of these is missing, later chapters may fail for reasons unrelated to your AL code.

## 2.2 Create and Initialize a Project

Use **AL: Go!** in the VS Code command palette to scaffold the extension project. This generates baseline files such as `app.json`, `.vscode/launch.json`, and object folders.

After generation, confirm that:

- `app.json` has a unique app ID and sensible name/version.
- Your object ID range matches your intended training objects (see Chapter 11).

## 2.3 Configure and Validate `launch.json`

Point `launch.json` to your sandbox environment and tenant, then run an initial publish with **F5**.

For safer first runs:

- Use a dedicated sandbox, not production.
- Confirm authentication settings are correct.
- Fail fast on connection issues before coding business logic.

## 2.4 Environment Validation Checklist

Before moving to Chapter 3, verify:

- ✅ AL extension is installed and active.
- ✅ Symbols download successfully.
- ✅ Initial publish works without object conflicts.
- ✅ You can set and hit a basic breakpoint.

This avoids chasing "code bugs" that are actually setup issues.

## Chapter Summary

- ✅ You identified required tools, permissions, and environment access
- ✅ You scaffolded an AL project with AL: Go!
- ✅ You configured sandbox launch settings and validated publish/debug basics
- ✅ You established a repeatable pre-coding environment checklist

---

## Tasks

1. **Project bootstrap.** Create a new AL project and verify `app.json` exists.
2. **Connection validation.** Configure `launch.json` and complete one successful publish.
3. **Debug readiness.** Set a breakpoint in any procedure and verify debugger attach works.
4. **Try it yourself.** Document one environment failure you hit and how you resolved it.

**Check your work:** if Chapters 3, 7, and 9 later fail to run, re-run this chapter's checklist before changing business logic.
