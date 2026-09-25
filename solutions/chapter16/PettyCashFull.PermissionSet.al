permissionset 50113 "Petty Cash - Full"
{
    Assignable = true;
    Caption = 'Petty Cash (Full Access)';
    IncludedPermissionSets = "Petty Cash - View";

    Permissions =
        table "Petty Cash Log" = IMD,
        codeunit "Petty Cash Mgt." = X;
}
