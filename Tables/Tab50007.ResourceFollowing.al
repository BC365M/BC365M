table 50007 "Resource Following"
{
    DataClassification = ToBeClassified;
    DrillDownPageId = "Resource Following";
    LookupPageId = "Resource Following";
    fields
    {
        field(1; "Resource No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource;

        }
        field(2; "Code"; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Following;
        }
        field(3; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF ("No. As" = CONST (item)) Item;
        }
        field(4; Description; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(5; Type; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Mileage,Duration,"Mileage/Duration";
        }
        field(6; Formula; DateFormula)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateNextDate();
            end;
        }
        field(7; "Replace Every"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            trigger OnValidate()
            begin
                if "Replace Every" <> 0 then
                    UpdateMileage();
            end;
        }
        field(8; "Next Date Replacement"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Next Mileage Replacement"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(10; "Last Date Replacement"; Date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateNextDate();
            end;
        }
        field(11; "Last Mileage Replacement"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            trigger OnValidate()
            begin
                UpdateMileage();
            end;
        }
        field(12; "Notify Date Before"; DateFormula)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                UpdateNotifyDate();
            end;
        }
        field(13; "Notify Mileage Before"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
            trigger OnValidate()
            begin
                UpdateNotifyMileage();
            end;
        }
        field(14; "Notify Date Replacement"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(15; "Notify Mileage Replacement"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(20; "No. As"; option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Item,"Serial No.";
        }
        field(22; "Total Mileage"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum ("Resource Ledger Entry"."Diff. Mileage" where ("Resource No." = field ("Resource No.")));
            Editable = false;
        }
        field(30; "Total Cost"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum ("Resource Ledger Entry"."Total Cost" where ("Resource No." = field ("Resource No."), code = field (code)));
            Editable = false;
        }

        field(40; Blocked; Boolean)
        {

        }
    }

    keys
    {
        key(PK; "Resource No.", code, "No.")
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
        If ("Total Cost" <> 0) And ("Total Mileage" <> 0) then
            Error('Vous nous pouvez pas Supprimer Une ressource Avec Des écritures Enregistrer');
    end;

    trigger OnRename()
    begin
        If ("Total Cost" <> 0) And ("Total Mileage" <> 0) then
            Error('Vous nous pouvez pas Supprimer Une ressource Avec Des écritures Enregistrer');
    end;

    local procedure UpdateNextDate()
    var
        myInt: Integer;
    begin
        TestField(Formula);
        if "Last Date Replacement" <> 0D then begin
            "Next Date Replacement" := CalcDate(Formula, "Last Date Replacement");
            "Notify Date Replacement" := CalcDate("Notify Date Before", "Next Date Replacement");
        end;
    end;

    local procedure UpdateMileage()
    var
        myInt: Integer;
    begin
        TestField("Replace Every");
        if "Last Mileage Replacement" = 0 then exit;
        "Next Mileage Replacement" := "Last Mileage Replacement" + "Replace Every";
        "Notify Mileage Replacement" := "Next Mileage Replacement" + "Notify Mileage Before";
    end;

    local procedure UpdateNotifyDate()
    begin
        TestField("Notify Date Before");
        if "Next Date Replacement" <> 0D then
            "Notify Date Replacement" := CalcDate("Notify Date Before", "Next Date Replacement");
    end;

    local procedure UpdateNotifyMileage()
    begin
        if "Next Mileage Replacement" > 0 then
            "Notify Mileage Replacement" := "Next Mileage Replacement" + "Notify Mileage Before";
    end;

}