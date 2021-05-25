pageextension 50003 "Posted Sales Invoice Subform" extends "Posted Sales Invoice Subform"
{
    Caption = 'Facture Vente Enregistrer';
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
            field("Lieu Livraison"; "Lieu Livraison") { ApplicationArea = All; }
            field(Avance; Avance) { ApplicationArea = All; }
            field(Matricule; Matricule) { ApplicationArea = All; }
            field("Transport Shipment No."; "Transport Shipment No.") { ApplicationArea = All; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}