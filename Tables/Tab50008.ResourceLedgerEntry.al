table 50008 "Resource Ledger Entry"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Resource Ledger Entry";
    LookupPageId = "Resource Ledger Entry";
    fields
    {
        field(1; "Resource No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource;
        }
        field(2; "Following Type"; Enum "Resource Following Type")
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Following;
        }
        field(4; "Description"; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Item No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = item;
        }
        field(6; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF ("Item No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item No."))
            ELSE
            "Unit of Measure";
        }
        field(7; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(8; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(9; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(11; "Mileage Tracking"; Boolean)
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
        //
        field(50000; "N° Serie"; code[60]) { }
        field(100; "Entry No."; Integer)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(101; "Posting Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(107; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(30; "%GASOIL_S/DIFF_KM"; Decimal) { DataClassification = CustomerContent; }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
        key(PD; "Posting Date")
        {

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
        Error('Vous nous pouvez pas Supprimer Une ressource Avec Des écritures Enregistrer');

    end;

    trigger OnRename()
    begin

    end;

}