page 50100 "Loan Repayment Schedule List"
{
    PageType = List;
    SourceTable = "Loan Repayment Schedule";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Loan Repayment Schedule';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Loan No."; "Loan No.")
                {
                    ApplicationArea = All;
                }
                field("Installment No."; "Installment No.")
                {
                    ApplicationArea = All;
                }
                field("Vendor No."; "Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Due Date"; "Due Date")
                {
                    ApplicationArea = All;
                }
                field("Payment Date"; "Payment Date")
                {
                    ApplicationArea = All;
                }
                field("Principal Amount"; "Principal Amount")
                {
                    ApplicationArea = All;
                }
                field("Interest Amount"; "Interest Amount")
                {
                    ApplicationArea = All;
                }
                field("Total Amount"; "Total Amount")
                {
                    ApplicationArea = All;
                }
                field(Paid; Paid)
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(MarkPaid)
            {
                ApplicationArea = All;
                Caption = 'Mark Paid';
                Image = Approve;

                trigger OnAction()
                var
                    LoanRepaymentMgt: Codeunit "Loan Repayment Mgt.";
                begin
                    LoanRepaymentMgt.MarkInstallmentPaid(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
