pageextension 50010 CustomizationResourceCard extends "Resource Card"
{
    Caption = 'Resource';
    layout
    {
        addlast(General)
        {
            field(Matricule; Matricule) { ApplicationArea = all; }
            field("Type de Véhicule"; "Type de Véhicule") { ApplicationArea = all; }
            field("Modéle"; "Modéle") { ApplicationArea = all; }
            field("N° Serie Plateau"; "N° Serie Plateau") { ApplicationArea = all; }
            field(PTAC; PTAC) { ApplicationArea = all; }
            field(PTRA; PTRA) { ApplicationArea = all; }
            field("Poids max arrière"; "Poids max arrière") { ApplicationArea = all; }
            field("Poids max avant"; "Poids max avant") { ApplicationArea = all; }

            field("Date Mise en Circulation"; "Date Mise en Circulation")
            {
                ApplicationArea = all;

            }


        }
        addbefore(Invoicing)
        {
            group(Alerts)
            {
                field("Date Debut Assurance"; "Date Debut Assurance") { ApplicationArea = all; }
                field("Date fin Assurance"; "Date fin Assurance") { ApplicationArea = all; }
                field("Delai Alerte Assurance"; "Delai Alerte Assurance") { ApplicationArea = all; }
                field("Date Alerte Assurance"; "Date Alerte Assurance") { ApplicationArea = all; }
                field("Date Debut V.Technique"; "Date Debut V.Technique") { ApplicationArea = all; }
                field("Date Fin V.Technique"; "Date Fin V.Technique") { ApplicationArea = all; }
                field("Delai Alerte V.Technique"; "Delai Alerte V.Technique") { ApplicationArea = all; }
                field("Date Alerte V.Technique"; "Date Alerte V.Technique") { ApplicationArea = all; }
                field("KLM Depart"; "KLM Depart") { ApplicationArea = all; }
                field("Dernier KLM"; "Dernier KLM") { ApplicationArea = all; }
                field("Warnnin KM"; "Warnnin KM") { ApplicationArea = all; }
                field("Date Prochaine Vidange"; "Date Prochaine Vidange") { ApplicationArea = all; }
            }
        }

    }
}