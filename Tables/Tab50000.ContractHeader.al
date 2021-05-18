table 50000 "Contract Header"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Contract List";
    fields


    {
        field(1; "Contract Type"; Enum "Contract Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; Description; Text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released,Archived;
            Editable = false;
        }
        field(8; "Starting Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Ending Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(32; "Currency Code"; Code[10])
        {
            TableRelation = Currency;
        }
        field(107; "No. Series"; Code[20])
        {
            TableRelation = Currency;
        }
    }
    keys
    {
        key(PK; "Contract Type", "No.")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        IF "No." = '' THEN BEGIN
            SalesSetup.GET;
            SalesSetup.TESTFIELD("Contract Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."Contract Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        END;
    end;

    trigger OnDelete()
    var
        Lines: Record "Contract Line";
    begin
        TestField(Status, Status::Open);
        Lines.SetRange("Contract Type", "Contract Type");
        Lines.SetRange("Contract No.", "No.");
        Lines.DeleteAll(true);
    end;
}