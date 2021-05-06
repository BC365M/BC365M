pageextension 50015 "Posted Sales Invoice" extends "Posted Sales Invoice"
{
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Contract Type"; "Contract Type") { ApplicationArea = All; Editable = false;}
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}