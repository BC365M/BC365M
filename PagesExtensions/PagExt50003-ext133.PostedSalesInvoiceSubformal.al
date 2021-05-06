pageextension 50003 "Posted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
{
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Zone No."; "Zone No.") { ApplicationArea = All; }
            field("Delivery Date"; "Delivery Date") { ApplicationArea = All; }
            field("Contract Type"; "Contract Type") { ApplicationArea = All; }
            field("Contract No."; "Contract No.") { ApplicationArea = All; Editable = false; }
            field("Contract Line No."; "Contract Line No.") { ApplicationArea = All; Editable = false; }
            field(Level; Level) { ApplicationArea = All; }
            field("Ship-From Code"; "Ship-From Code") { ApplicationArea = All; }
            field("Ship-to Code"; "Ship-to Code") { ApplicationArea = All; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}