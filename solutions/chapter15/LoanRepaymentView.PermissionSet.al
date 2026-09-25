permissionset 50103 "Loan Repayment - View"
{
    Assignable = true;
    Caption = 'Loan Repayment (View Only)';

    Permissions =
        table "Loan Repayment Schedule" = R,
        page "Loan Repayment Schedule List" = X;
}
