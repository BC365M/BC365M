pageextension 50009 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    caption = 'Parametre Vente';
    layout
    {
        // Add changes to page layout here
        addlast("Number Series")
        {
            field("Contract Nos."; "Contract Nos.") { ApplicationArea = All; }
        }
    }
}