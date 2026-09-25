codeunit 50105 "Loan Repayment Performance"
{
    procedure CountUnpaidInstallments(): Integer
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        UnpaidCount: Integer;
    begin
        LoanRepaymentSchedule.SetRange(Paid, false);
        LoanRepaymentSchedule.SetLoadFields(Paid);

        if LoanRepaymentSchedule.FindSet() then
            repeat
                UnpaidCount += 1;
            until LoanRepaymentSchedule.Next() = 0;

        exit(UnpaidCount);
    end;

    procedure ExplainBorrowerLookupPlacement(): Text
    begin
        exit('If installments are processed for one loan at a time, load borrower data once before the loop and reuse it inside the loop.');
    end;
}
