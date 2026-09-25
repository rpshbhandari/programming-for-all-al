codeunit 50102 "Loan Repayment Mgt. Tests"
{
    Subtype = Test;

    [Test]
    procedure MarkInstallmentPaidSetsPaymentDate()
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanRepaymentMgt: Codeunit "Loan Repayment Mgt.";
        Assert: Codeunit Assert;
    begin
        LoanRepaymentSchedule.Init();
        LoanRepaymentSchedule."Loan No." := 'LOAN0001';
        LoanRepaymentSchedule."Installment No." := 1;
        LoanRepaymentSchedule."Vendor No." := '10000';
        LoanRepaymentSchedule."Principal Amount" := 1000;
        LoanRepaymentSchedule."Interest Amount" := 50;
        LoanRepaymentSchedule.Insert(true);

        LoanRepaymentMgt.MarkInstallmentPaid(LoanRepaymentSchedule);

        Assert.IsTrue(LoanRepaymentSchedule.Paid, 'Installment should be marked paid.');
        Assert.AreEqual(Today, LoanRepaymentSchedule."Payment Date", 'Payment date should be today.');
    end;

    [Test]
    procedure MarkingPaidDoesNotTriggerBlockedEditError()
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanRepaymentMgt: Codeunit "Loan Repayment Mgt.";
        Assert: Codeunit Assert;
    begin
        LoanRepaymentSchedule.Init();
        LoanRepaymentSchedule."Loan No." := 'LOAN0002';
        LoanRepaymentSchedule."Installment No." := 1;
        LoanRepaymentSchedule."Vendor No." := '10000';
        LoanRepaymentSchedule.Insert(true);

        LoanRepaymentMgt.MarkInstallmentPaid(LoanRepaymentSchedule);

        Assert.IsTrue(LoanRepaymentSchedule.Paid, 'Marking paid should succeed without error.');
    end;

    [Test]
    procedure GenerateScheduleCreatesThreeRows()
    var
        LoanRepaymentSchedule: Record "Loan Repayment Schedule";
        LoanRepaymentMgt: Codeunit "Loan Repayment Mgt.";
        Assert: Codeunit Assert;
    begin
        LoanRepaymentSchedule.SetRange("Loan No.", 'LOAN0003');
        LoanRepaymentSchedule.DeleteAll(true);

        LoanRepaymentMgt.GenerateSchedule('LOAN0003', 3, 1000, 100, Today, '10000');

        LoanRepaymentSchedule.SetRange("Loan No.", 'LOAN0003');
        Assert.AreEqual(3, LoanRepaymentSchedule.Count(), 'Exactly 3 installments should be generated.');
    end;
}
