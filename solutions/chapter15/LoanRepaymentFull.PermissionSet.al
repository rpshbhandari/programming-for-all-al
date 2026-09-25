permissionset 50104 "Loan Repayment - Full"
{
    Assignable = true;
    Caption = 'Loan Repayment (Full Access)';
    IncludedPermissionSets = "Loan Repayment - View";

    Permissions =
        table "Loan Repayment Schedule" = IMD,
        codeunit "Loan Repayment Mgt." = X;
}
