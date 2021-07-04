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
        field(7; "Document No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Resource Following"."No." where ("Resource No." = field ("Resource No."), "Code" = field ("Code"));

            trigger OnValidate()
            var
                resFol: Record "Resource Following";
            begin
                resFol.get("Resource No.", code, "No.");
                if resFol."No. As" = resFol."No. As"::Item then
                    validate("Item No.", "No.");
            end;
        }
        field(10; "Resource No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource;
        }
        field(11; "Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Following".Code;
            trigger OnValidate()
            var
                recFollowing: Record Following;
            begin
                recFollowing.Get(code);
                "Following Type" := recFollowing."Following Type";
                validate("Mileage Tracking",recFollowing."Mileage Tracking");
                if (Description = '') then
                    Description := recFollowing.Description;
            end;
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
            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(16; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            trigger OnValidate()
            begin
                UpdateAmount();
            end;
        }
        field(17; "Total Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(19; "Mileage Tracking"; Boolean)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                recRes: Record Resource;
            begin
                if "Mileage Tracking" then begin
                    recRes.Get("Resource No.");
                    recRes.CalcFields("Total Mileage");
                    "Last Mileage" := recRes."Total Mileage";
                    UpdateMileage();
                end else begin
                    "Actual Mileage" := 0;
                    "Last Mileage" := 0;
                    "Diff. Mileage" := 0;
                end;
            end;
        }
        field(20; "Last Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            trigger OnValidate()
            begin
                UpdateMileage();
            end;
        }
        field(21; "Actual Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            trigger OnValidate()
            begin
                UpdateMileage();
            end;
        }
        field(22; "Diff. Mileage"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            Editable = false;
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

    procedure UpdateAmount()
    begin
        "Total Cost" := Quantity * "Unit Cost";
    end;

    procedure UpdateMileage()
    begin
        Testfield("Mileage Tracking");
        if "Actual Mileage" > "Last Mileage" then
            "Diff. Mileage" := "Actual Mileage" - "Last Mileage"
        else
            "Diff. Mileage" := 0;
    end;

}