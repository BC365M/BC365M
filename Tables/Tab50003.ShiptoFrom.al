table 50003 "Ship-from/to Address"
{
    DrillDownPageId = "Ship-from/to Address";
    LookupPageId = "Ship-from/to Address";
    fields
    {
        field(1; Code; Code[10])
        {
        }
        field(3; Name; Text[100])
        {
        }
    }

    keys
    {
        key(PK; code)
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