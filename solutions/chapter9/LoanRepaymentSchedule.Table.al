table 50100 "Loan Repayment Schedule"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Loan No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Installment No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(3; "Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = Vendor."No.";
        }
        field(4; "Due Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(5; "Payment Date"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(6; "Principal Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(7; "Interest Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(8; "Total Amount"; Decimal)
        {
            DataClassification = CustomerContent;
        }
        field(9; Paid; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Loan No.", "Installment No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        "Total Amount" := "Principal Amount" + "Interest Amount";
    end;

    trigger OnModify()
    begin
        if xRec.Paid then
            Error('A paid installment cannot be changed.');
        "Total Amount" := "Principal Amount" + "Interest Amount";
    end;
}
