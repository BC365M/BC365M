pageextension 50020 "Company Information" extends "Company Information"
{
    layout
    {
        addlast(Communication)
        {
            field(RC; RC) { Caption = 'RC'; }
            field(idfi; "Identifiant Fiscal") { Caption = 'Identifiant Fiscal'; }
            field(ICE; ICE) { Caption = 'ICE'; }
            field(Patent; Patent) { Caption = 'patente'; }
            field(CNSS; CNSS) { Caption = 'CNSS'; }
            field("Date Creation"; "Date Creation") { Caption = 'date Création'; }
            field(Informations; Informations) { Caption = 'Information'; }

        }

    }
}