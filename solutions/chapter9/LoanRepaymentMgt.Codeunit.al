codeunit 50100 "Loan Repayment Mgt."
{
    procedure MarkInstallmentPaid(var LoanRepaymentSchedule: Record "Loan Repayment Schedule")
    begin
        LoanRepaymentSchedule."Payment Date" := Today;
        LoanRepaymentSchedule.Paid := true;
        LoanRepaymentSchedule.Modify(true);
    end;

    procedure GenerateSchedule(LoanNo: Code[20]; NumberOfInstallments: Integer; PrincipalPerInstallment: Decimal; InterestPerInstallment: Decimal; FirstDueDate: Date; VendorNo: Code[20])
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        i: Integer;
    begin
        LoanRepaymentSchedule.SetRange("Loan No.", LoanNo);
        if LoanRepaymentSchedule.FindFirst() then
            Error('A schedule already exists for loan %1.', LoanNo);

        for i := 1 to NumberOfInstallments do begin
            LoanRepaymentSchedule.Init();
            LoanRepaymentSchedule."Loan No." := LoanNo;
            LoanRepaymentSchedule."Installment No." := i;
            LoanRepaymentSchedule."Vendor No." := VendorNo;
            LoanRepaymentSchedule."Due Date" := CalcDate(StrSubstNo('<+%1M>', i - 1), FirstDueDate);
            LoanRepaymentSchedule."Principal Amount" := PrincipalPerInstallment;
            LoanRepaymentSchedule."Interest Amount" := InterestPerInstallment;
            LoanRepaymentSchedule.Insert(true);
        end;
    end;
}
