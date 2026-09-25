codeunit 50111 "Petty Cash Mgt."
{
    procedure MarkReconciled(var PettyCashLog: Record "Petty Cash Log")
    begin
        PettyCashLog.Reconciled := true;
        PettyCashLog.Modify(true);
    end;
}
