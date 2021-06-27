table 50009 "Resource Follow Journal"
{
    DataClassification = ToBeClassified;
    //DrillDownPageId = "Resource Ledger Entry";
    //LookupPageId = "Resource Ledger Entry";
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(2; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Following Type"; Enum "Resource Following Type")
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Resource No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource;
        }
        field(11; "Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Following;
        }
        field(12; "Description"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(13; "Item No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = item;
        }
        field(14; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF ("Item No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item No."))
            ELSE
            "Unit of Measure";
        }
        field(15; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(16; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(17; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(19; "Mileage Tracking"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(20; "Last Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(21; "Actual Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(22; "Diff. Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}