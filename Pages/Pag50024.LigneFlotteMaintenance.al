page 50024 "Ligne Flotte Maintenance"
{
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = "Ligne Flotte & Maintenance";
    // AutoSplitKey = true;
    PopulateAllFields = true;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field(No; No_Maintenance) { ApplicationArea = all; caption = 'N° maintenance'; }
                field("Type Ecriture"; "Type Ecriture") { ApplicationArea = all; Caption = 'Type écriture'; }
                field("Type de Travail"; "Type de Travail")
                {
                    ApplicationArea = all;
                    Caption = 'Type de travail';

                }
                field(Designation; DesignationMaintenance) { ApplicationArea = All; Caption = 'Description Maintenance'; }
                field(Ressource; Ressource) { ApplicationArea = all; Caption = 'Ressource'; }
                field(No_Bon; No_Bon) { ApplicationArea = all; Caption = 'N° BON'; }
                field("Item No_"; "Item No_") { ApplicationArea = all; caption = 'No Article'; }

                field("Item Description"; "Item Description") { ApplicationArea = all; Caption = 'Description Article'; }
                field("Location Code"; "Location Code") { ApplicationArea = all; Caption = 'Code Magasin'; }
                field("Quantité"; "Quantité") { ApplicationArea = all; Caption = 'Quantité'; }
                field(KM_President; KM_President) { ApplicationArea = all; Caption = 'KM President'; }
                field(kM_Actuel; kM_Actuel) { ApplicationArea = all; Caption = 'KM Actuel'; }
                field(Dif_KLM; Dif_KLM) { ApplicationArea = all; caption = 'Difference KLM'; }
                field(StockDispo; StockDispo)
                {
                    ApplicationArea = all;
                    Caption = 'Stock';

                }
                field("%GASOIL_S/DIFF_KM"; "%GASOIL_S/DIFF_KM") { ApplicationArea = all; Caption = '% Gasoil S/DIF'; }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                    ApplicationArea = all;
                    Caption = 'Chauffeur';

                }


            }
        }
    }



    var


}