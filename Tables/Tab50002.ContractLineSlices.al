table 50002 "Contract Line Slices"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Contract Lines Slices";
    LookupPageId = "Contract Lines Slices";
    fields
    {
        field(1; "Contract Type"; Enum "Contract Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Contract No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Contract Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(15; Level; Integer)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(20; "Unit Price"; Decimal)
        {
            BlankZero = true;
            AutoFormatType = 2;
            AutoFormatExpression = "Currency Code";
        }
        field(21; "Discount Amount"; Decimal)
        {
            BlankZero = true;
            AutoFormatType = 2;
            AutoFormatExpression = "Currency Code";
        }
        field(91; "Currency Code"; Code[10])
        {
            Editable = false;
            TableRelation = Currency;
        }
    }

    keys
    {
        key(PK; "Contract Type", "Contract No.", "Contract Line No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin
        checkStatus();
    end;

    trigger OnModify()
    begin
        checkStatus();
    end;

    trigger OnDelete()
    begin
        checkStatus();
    end;

    trigger OnRename()
    begin

    end;

    procedure checkStatus()
    var
        contractHeader: Record "Contract Header";
    begin
        contractHeader.Get("Contract Type", "Contract No.");
        contractHeader.TestField(Status, contractHeader.Status::Open);
    end;
}