permissionset 50112 "Petty Cash - View"
{
    Assignable = true;
    Caption = 'Petty Cash (View Only)';

    Permissions =
        table "Petty Cash Log" = R,
        page "Petty Cash Log List" = X;
}
