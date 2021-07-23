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
                validate("Mileage Tracking", recFollowing."Mileage Tracking");
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
            trigger OnValidate()

            begin
                item.get("Item No.");
                item.TestField(Blocked, false);
                "Unit Cost" := item."Unit Cost";
                "Unit Cost" := item."Last Direct Cost";


            end;
        }
        field(50000; "N° Serie"; code[20])
        {
            Caption = 'N° serie';

        }
        field(5005; "Variant Code"; code[10])
        {
            TableRelation = "Item Variant".Code WHERE ("Item No." = FIELD ("Item No."));
        }
        field(50001; "Lot No."; code[50])
        {
            Editable = false;
        }
        field(50002; "Quantity (Base)"; Decimal)
        {

        }
        field(50003; "Invoiced Qty. (Base)"; Decimal)
        {
            trigger OnValidate()
            begin
                // TestField("Qty. per Unit of Measure", 1);
                // Validate(Quantity, "Quantity (Base)");
            end;
        }
        field(50004; "Qty. per Unit of Measure"; Decimal)
        {

        }

        field(14; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF ("Item No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("Item No."))
            ELSE
            "Unit of Measure";
        }
        field(25; "Location Code"; code[10])
        {
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;

        }
        field(15; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            trigger OnValidate()

            begin
                UpdateAmount();
                calcDiffSortie();


            end;
        }
        field(16; "Unit Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            trigger OnValidate()

            begin
                TestField("Item No.");

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
            trigger OnValidate()
            begin
                calcDiffSortie();
            end;
        }
        field(30; "%GASOIL_S/DIFF_KM"; Decimal)
        {
            DataClassification = CustomerContent;
            Editable = false;
        }
        field(31; StockDispo; Decimal)
        {
            CalcFormula = sum ("Item Ledger Entry".Quantity where ("Item No." = field ("Item No."), "Location Code" = field ("Location Code")));
            FieldClass = FlowField;
        }
        field(55; "Shortcut Dimension 7 Code"; code[20])
        {
            CaptionClass = 'Chauffeur';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));
            trigger OnValidate()
            begin

            end;
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
        item: Record Item;
        UOMMgt: Codeunit "Unit of Measure Management";
        ReserveItemJnlLine: Codeunit 50000;
        ItemTrackingMgt: Codeunit "Item Tracking Management";
        serialNumber: Record "Serial No. Information";


    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin
        if rec."Entry No." <> xRec."Entry No." then
            Error('Vous nous pouvez pas Supprimer Une ressource Avec Des écritures Enregistrer');

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
    // Dev 18/07/2021 sa



    local procedure calcDiffSortie()
    var
        myInt: Integer;
        Folowres: Record 50009;
    begin
        If ("Diff. Mileage" <> Quantity) AND (Folowres.Code = 'VIDANGE') then
            "%GASOIL_S/DIFF_KM" := ("Diff. Mileage" / Quantity * 100)
        else
            "%GASOIL_S/DIFF_KM" := 0;

    end;

}