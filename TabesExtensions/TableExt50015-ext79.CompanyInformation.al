tableextension 50015 CompanyInformation extends "Company Information"
{
    fields
    {
        field(50010; ICE; Text[50]) { Caption = 'ICE'; }
        field(50012; Patent; Text[50]) { Caption = 'Patent'; }
        field(50014; RC; Code[20]) { Caption = 'RC'; }
        field(50015; "Identifiant Fiscal"; Text[50]) { Caption = 'Identifiant Fiscal'; }
        field(50016; CNSS; Text[50]) { Caption = 'CNSS'; }
        field(50017; "Date Creation"; date) { Caption = 'Date Création'; }
        field(50018; Informations; Text[1024]) { Caption = 'Information'; }

    }
}