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

            field("Total Mileage"; "Total Mileage")
            {
                ApplicationArea = all;
            }
            field("Total Cost"; "Total Cost")
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
                field("Prochaine Vidange"; "Prochaine Vidange") { ApplicationArea = all; }
            }

        }
        addbefore(Alerts)

        {
            group("Gestion De Pneu Devant")
            {
                field(Pdevant_Gauche; Pdevant_Gauche) { Caption = 'DG1'; }
                field(Pdevant_Gauche2; Pdevant_Gauche2) { caption = 'DG2'; }

                field("D_Kilometrage Echange"; "D_Kilometrage Echange") { caption = 'Kilometrage echange Pneu devant'; }
                field("D_Date echeange"; "D_Date echeange") { caption = 'Date d&echeange'; }
                field(D_Kilometrage; D_Kilometrage) { caption = 'Kilometrage Pneu devant'; }
                field(DNo_Serie; DNo_Serie) { caption = 'N° serie P devant'; }
                field(Pdevant_Secours1; Pdevant_Secours1) { caption = 'Emplacement Secours 1'; }
                field(Pdevant_Secours2; Pdevant_Secours2) { Caption = 'Emplacement Secours 2'; }
                field(Pdevant_Droit1; Pdevant_Droit1) { Caption = 'Devant Droit 1'; }
                field(Pdevant_Droit2; Pdevant_Droit2) { caption = 'Devant Droit 2'; }

            }
            group("Gestion De Pneu Arriere")
            {
                // field(){ }
            }

        }
    }
}