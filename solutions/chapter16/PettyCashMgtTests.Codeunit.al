codeunit 50114 "Petty Cash Mgt. Tests"
{
    Subtype = Test;

    [Test]
    procedure MarkReconciledSetsFlag()
    var
        PettyCashLog: Record "Petty Cash Log";
        PettyCashMgt: Codeunit "Petty Cash Mgt.";
        Assert: Codeunit Assert;
    begin
        PettyCashLog.Init();
        PettyCashLog."Received By" := 'E0001';
        PettyCashLog.Amount := 20;
        PettyCashLog.Purpose := 'Office supplies';
        PettyCashLog."Entry Date" := Today;
        PettyCashLog.Insert(true);

        PettyCashMgt.MarkReconciled(PettyCashLog);

        Assert.IsTrue(PettyCashLog.Reconciled, 'Entry should be marked reconciled.');
    end;
}
