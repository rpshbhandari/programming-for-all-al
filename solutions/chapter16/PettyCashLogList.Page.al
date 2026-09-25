page 50110 "Petty Cash Log List"
{
    PageType = List;
    SourceTable = "Petty Cash Log";
    ApplicationArea = All;
    UsageCategory = Lists;
    Caption = 'Petty Cash Log';

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Received By"; "Received By")
                {
                    ApplicationArea = All;
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field(Purpose; Purpose)
                {
                    ApplicationArea = All;
                }
                field("Entry Date"; "Entry Date")
                {
                    ApplicationArea = All;
                }
                field(Reconciled; Reconciled)
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
            action(MarkReconciled)
            {
                ApplicationArea = All;
                Caption = 'Mark Reconciled';
                Image = Approve;

                trigger OnAction()
                var
                    PettyCashMgt: Codeunit "Petty Cash Mgt.";
                begin
                    PettyCashMgt.MarkReconciled(Rec);
                    CurrPage.Update(false);
                end;
            }
        }
    }
}
