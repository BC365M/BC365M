pageextension 50011 "Sales Invoice" extends "Sales Invoice"
{
    caption = 'Facture Vente';
    layout
    {
        // Add changes to page layout here
        addlast(General)
        {
            field("Contract Type"; "Contract Type") { ApplicationArea = All; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}