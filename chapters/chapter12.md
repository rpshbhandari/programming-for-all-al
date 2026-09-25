# Chapter 12: Integration with Other Systems

## Objectives

By the end of this chapter you will be able to:

- ✅ Expose controlled extension functionality through service-enabled procedures
- ✅ Call external APIs with `HttpClient` and robust status handling
- ✅ Parse and validate integration payloads before data changes
- ✅ Apply integration guardrails that align with security and reliability practices

## 12.1 Exposing AL Procedures as Services

Service-enabled procedures can expose extension functionality to external callers.

```al
codeunit 50120 "Loan Integration API"
{
    [ServiceEnabled]
    procedure GetInstallmentStatus(LoanNo: Code[20]; InstallmentNo: Integer): Text
    var
        Installment: Record "Loan Repayment Schedule";
    begin
        if not Installment.Get(LoanNo, InstallmentNo) then
            Error('Installment %1/%2 was not found.', LoanNo, InstallmentNo);

        if Installment.Paid then
            exit('Paid');

        exit('Open');
    end;
}
```

Return stable, simple values that external systems can depend on.

## 12.2 Calling External APIs Safely

```al
procedure GetCreditRiskScore(VendorNo: Code[20]): Decimal
var
    Client: HttpClient;
    Response: HttpResponseMessage;
    Content: Text;
begin
    Client.Get(StrSubstNo('https://api.example.com/vendors/%1/risk', VendorNo), Response);

    if not Response.IsSuccessStatusCode then
        Error('Risk API call failed with status %1.', Response.HttpStatusCode);

    Response.Content.ReadAs(Content);
    exit(EvaluateRiskScore(Content));
end;
```

Avoid showing raw API responses to end users. Convert remote errors into clear domain messages.

## 12.3 Payload Validation and Idempotency

Before writing external data to Business Central:

- Validate required keys and value formats.
- Reject unknown or unsupported status values.
- Prevent duplicate inserts for the same external transaction key.

These checks protect consistency and are test targets in Chapter 14.

## 12.4 Integration Design Practices

- Keep networking code in dedicated integration codeunits.
- Separate parsing/validation from persistence logic.
- Log enough context for support without leaking sensitive data.
- Align permissions and classifications with Chapters 11 and 15.

## Chapter Summary

- ✅ You exposed controlled AL service operations
- ✅ You handled outbound HTTP calls with explicit failure handling
- ✅ You validated external payloads before mutating data
- ✅ You applied durable integration design patterns for production use

---

## Tasks

1. **Service endpoint.** Create one service-enabled procedure that returns installment status.
2. **HTTP robustness.** Implement one outbound API call that checks `IsSuccessStatusCode` and handles failures.
3. **Validation gate.** Add payload validation that rejects missing or invalid required values.
4. **Try it yourself.** Define how you would prevent the same external transaction from being imported twice.

**Check your work:** your integration flow should still honor table constraints from Chapter 7 and business-logic boundaries from Chapter 9.
