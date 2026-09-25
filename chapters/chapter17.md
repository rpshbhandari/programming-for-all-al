# Chapter 17: Advanced AL Features

## Objectives

By the end of this chapter you will be able to:

- ✅ Implement publisher/subscriber event patterns with clear responsibility boundaries
- ✅ Design extensibility points without hard-coding dependencies
- ✅ Use interfaces and dependency inversion for testable, modular AL code
- ✅ Evaluate advanced patterns against maintainability and upgrade safety

## 17.1 Eventing with Publishers and Subscribers

Events let you extend behavior without editing base logic directly.

```al
codeunit 50130 "Loan Events"
{
    [IntegrationEvent(false, false)]
    procedure OnInstallmentMarkedPaid(LoanNo: Code[20]; InstallmentNo: Integer)
    begin
    end;
}
```

```al
codeunit 50131 "Loan Notifications"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Loan Events", 'OnInstallmentMarkedPaid', '', false, false)]
    local procedure HandleInstallmentMarkedPaid(LoanNo: Code[20]; InstallmentNo: Integer)
    begin
        // Send notification, write telemetry, or enqueue follow-up work
    end;
}
```

This pattern is a production-safe evolution of the extension concepts introduced in Chapter 11.

## 17.2 Interfaces and Dependency Inversion

Use interfaces when multiple implementations are possible.

```al
interface "IRiskScoringProvider"
{
    procedure GetRiskScore(VendorNo: Code[20]): Decimal;
}
```

```al
codeunit 50132 "Default Risk Scoring Provider" implements "IRiskScoringProvider"
{
    procedure GetRiskScore(VendorNo: Code[20]): Decimal
    begin
        exit(0);
    end;
}
```

This keeps calling code stable while implementations evolve.

## 17.3 Advanced Pattern Selection Criteria

Use advanced features only when they solve a real problem:

- Event subscribers for extension and decoupling
- Interfaces for replaceable strategies
- Single-instance codeunits only when shared in-session state is truly required

Overusing advanced patterns in simple scenarios adds maintenance cost.

## 17.4 Testing Advanced Behavior

Advanced patterns still need tests:

- Verify subscribers run only on intended events.
- Validate interface implementations with consistent contracts.
- Ensure fallback behavior exists when optional integrations are unavailable.

This aligns with Chapter 14's regression mindset.

## Chapter Summary

- ✅ You implemented event-driven extension points with safe decoupling
- ✅ You applied interface-based design for replaceable behaviors
- ✅ You evaluated when advanced AL patterns are justified
- ✅ You tied advanced design back to testability and upgrade resilience

---

## Tasks

1. **Publish an event.** Add an integration event to your loan-management flow.
2. **Subscribe responsibly.** Create one subscriber codeunit that reacts without duplicating core logic.
3. **Introduce an interface.** Define one interface and one implementation for a replaceable service.
4. **Try it yourself.** Explain one case where a simple direct call is better than an event + subscriber chain.

**Check your work:** advanced patterns should extend Chapter 9 logic and Chapter 11 packaging without weakening clarity or testability.
