pageextension 50004 "Item Ledger Entries" extends "Item Ledger Entries"
{
    Caption = 'Ecritures Comptable Article';
    layout
    {
        // Add changes to page layout here
        addafter("Entry No.")
        {
            field("Zone No."; "Zone No.") { ApplicationArea = All; }
            field("Delivery Date"; "Delivery Date") { ApplicationArea = All; }
            field("Contract Type"; "Contract Type") { ApplicationArea = All; }
            field("Contract No."; "Contract No.") { ApplicationArea = All; Editable = false; }
            field("Contract Line No."; "Contract Line No.") { ApplicationArea = All; Editable = false; }
            field(Level; Level) { ApplicationArea = All; }
            field("Lieu Livraison"; "Lieu Livraison") { ApplicationArea = All; }
            field(Avance; Avance) { ApplicationArea = All; }
            field(Matricule; Matricule) { ApplicationArea = All; }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}