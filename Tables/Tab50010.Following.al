table 50010 "Following"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Following List";
    DrillDownPageId = "Following List";

    fields
    {
        field(1; Code; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Description; text[100])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Following Type"; Enum "Resource Following Type")
        {
            DataClassification = ToBeClassified;
        }
        field(5; "Mileage Tracking"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Notify"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Following Count"; Integer)
        {
            FieldClass = FlowField;
            CalcFormula = count ("Resource Following" where (code = field (code)));
            BlankZero = true;
        }
    }


    keys
    {
        key(PK; code)
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; code, Description, "Following Type")
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

    end;

    trigger OnRename()
    begin

    end;

}