pageextension 50016 "Customer Card" extends "Customer Card"
{
    layout
    {
        addlast(General)
        {
            field(ICE; ICE) { ApplicationArea = All; }
            field("IF"; "Identifiant Fiscal") { ApplicationArea = All; }
            field(RC; RC) { ApplicationArea = All; }
            field(Patent; Patent) { ApplicationArea = All; }

        }
    }
}