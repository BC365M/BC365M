pageextension 50008 "Sales Order" extends "Sales Order"
{
    caption = 'Commande Vente';
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Contract Type"; "Contract Type") { ApplicationArea = All; Caption = 'Type Contrat'; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}