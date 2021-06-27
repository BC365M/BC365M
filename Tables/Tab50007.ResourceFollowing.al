table 50007 "Resource Following"
{
    DataClassification = ToBeClassified;

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
        }
        field(7; "Replace Every"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
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
        }
        field(11; "Last Mileage Replacement"; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(22; "Total Mileage"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum ("Resource Ledger Entry"."Diff. Mileage" where ("Resource No." = field ("Resource No."), code = field (code)));
        }
        field(30; "Total Cost"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum ("Resource Ledger Entry"."Total Cost" where ("Resource No." = field ("Resource No."), code = field (code)));
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

    end;

    trigger OnRename()
    begin

    end;

}