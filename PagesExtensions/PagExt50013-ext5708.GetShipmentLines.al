
pageextension 50013 "Get Shipment Lines" extends "Get Shipment Lines"
{

    layout
    {
        // Add changes to page layout here
        addafter("Quantity Invoiced")
        {
            field("Zone No."; "Zone No.") { ApplicationArea = All; }
            field("Delivery Date"; "Delivery Date") { ApplicationArea = All; }
            field("Contract Type"; "Contract Type") { ApplicationArea = All; }
            field("Contract No."; "Contract No.") { ApplicationArea = All; Editable = false; }
            field("Contract Line No."; "Contract Line No.") { ApplicationArea = All; Editable = false; }
            field(Level; Level) { ApplicationArea = All; }
            field("Ship-From Code"; "Ship-From Code") { ApplicationArea = All; }
            field("Ship-to Code"; "Ship-to Code") { ApplicationArea = All; }


            field(Avance; Avance) { ApplicationArea = All; }


        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}