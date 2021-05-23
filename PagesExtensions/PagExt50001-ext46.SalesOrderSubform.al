pageextension 50001 "Sales Order Subform" extends "Sales Order Subform"
{
    Caption = 'Commande Vente ';
    layout
    {
        // Add changes to page layout here
        addafter(Description)
        {
            field("Delivery Date"; "Delivery Date") { ApplicationArea = All; }
            field("Contract Type"; "Contract Type") { ApplicationArea = All; Visible = false; }
            field("Contract No."; "Contract No.") { ApplicationArea = All; Editable = false; }
            field("Contract Line No."; "Contract Line No.") { ApplicationArea = All; Editable = false; }
            field(Level; Level) { ApplicationArea = All; Editable = false; }
            field("Zone No."; "Zone No.") { ApplicationArea = All; }
            field("Ship-From Code"; "Ship-From Code") { ApplicationArea = All; }
            field("Ship-to Code"; "Ship-to Code") { ApplicationArea = All; }
            //SA
            field(KMDEP; KMDEP) { ApplicationArea = All; }
            field(KMARR; KMARR) { ApplicationArea = All; }
            field(DIFF; DIFF) { ApplicationArea = All; Editable = false; }
            field(kMREEL; kMREEL) { ApplicationArea = All; Editable = false; }
            field("Lieu Livraison"; "Lieu Livraison") { ApplicationArea = All; }
            field(Matricule; Matricule) { ApplicationArea = All; }
            field(Avance; Avance) { ApplicationArea = All; }



            //SA

        }
    }
}