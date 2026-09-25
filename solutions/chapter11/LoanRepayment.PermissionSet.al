permissionset 50100 "Loan Repayment"
{
    Assignable = true;
    Caption = 'Loan Repayment Management';

    Permissions =
        table "Loan Repayment Schedule" = X,
        page "Loan Repayment Schedule List" = X,
        codeunit "Loan Repayment Mgt." = X;
}
