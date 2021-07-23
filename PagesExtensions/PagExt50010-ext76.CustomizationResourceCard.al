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
    }
}