table 50110 "Petty Cash Log"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = SystemMetadata;
            AutoIncrement = true;
        }
        field(2; "Received By"; Code[20])
        {
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = Employee."No.";
        }
        field(3; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            MinValue = 0.01;
        }
        field(4; Purpose; Text[100])
        {
            DataClassification = CustomerContent;
            NotBlank = true;
        }
        field(5; "Entry Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; Reconciled; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    trigger OnModify()
    begin
        if xRec.Reconciled then
            Error('A reconciled petty cash entry cannot be changed.');
    end;
}
