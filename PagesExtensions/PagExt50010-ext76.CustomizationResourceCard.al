pageextension 50010 CustomizationResourceCard extends "Resource Card"
{
    Caption = 'Resource';
    layout
    {
        addlast(General)
        {
            field(Matricule; Matricule)
            {
                ApplicationArea = all;

            }
            field("Type de Véhicule"; "Type de Véhicule")
            {
                ApplicationArea = all;

            }
            field("Modéle"; "Modéle")
            {
                ApplicationArea = all;

            }
            field("N° Serie Plateau"; "N° Serie Plateau")
            {
                ApplicationArea = all;

            }
            field(PTAC; PTAC)
            {
                ApplicationArea = all;

            }
            field(PTRA; PTRA)
            {
                ApplicationArea = all;

            }
            field("Poids max arrière"; "Poids max arrière")
            {
                ApplicationArea = all;

            }
            field("Poids max avant"; "Poids max avant")
            {
                ApplicationArea = all;

            }
            field("Date Mise en Circulation"; "Date Mise en Circulation")
            {
                ApplicationArea = all;

            }


        }
        addbefore(Invoicing)
        {
            group(Alerts)
            {
                field("Date Creation Assurance"; "Date Creation Assurance") { ApplicationArea = all; Caption = 'Date Création Assurance'; }
                field("Notice date Assurance"; "Notice date Assurance") { ApplicationArea = all; Caption = 'Date Préavis Assurance'; }
                field("Notice Period Assurance"; "Notice Period Assurance") { ApplicationArea = all; Caption = 'Délai Préavis Assurance'; }
                field("Warning Date Assurance"; "Warning Date Assurance") { ApplicationArea = all; Caption = 'Date Alert Assurance'; }
                field("Warning Period Assurance"; "Warning Period Assurance") { ApplicationArea = all; Caption = 'Délai Alert Assurance'; }
                field("Date Creation V.Technique"; "Date Creation V.Technique") { ApplicationArea = all; Caption = 'Date Création Visite technique'; }
                field("Notice date V.Technique"; "Notice date V.Technique") { ApplicationArea = all; Caption = 'Date Préavis V.Technique'; }
                field("Notice Period V.Technique"; "Notice Period V.Technique") { ApplicationArea = all; Caption = 'Délai Préavis V.Technique'; }
                field("Warning Date V.Technique"; "Warning Date V.Technique") { ApplicationArea = all; Caption = 'Date Alert V.Technique'; }
                field("Warning Period V.Technique"; "Warning Period V.Technique") { ApplicationArea = all; Caption = 'Délai Alert V.Technique'; }
                field("Date 1er Vidange"; "Date 1er Vidange") { ApplicationArea = all; Caption = 'Date 1er Vidange'; }
                field("KLM Depart"; "KLM Depart") { ApplicationArea = all; Caption = 'KLM Depart'; }
                field("Dernier KLM"; "Dernier KLM") { ApplicationArea = all; Caption = 'Dernier KLM'; }
                field("Warnnin KM"; "Warnnin KM") { ApplicationArea = all; Caption = 'KM Alert'; }

            }
        }

    }
}