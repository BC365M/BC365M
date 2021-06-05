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
                field("Type Maintenance"; "Type Maintenance") { ApplicationArea = all; Visible = false; }
                field("Type Planification"; "Type Ecriture") { ApplicationArea = all; caption = 'Type Ecriture'; }
                field(Designation; DesignationMaintenance) { ApplicationArea = All; Caption = 'Description Maintenance'; }
                field(Chauffeur; Chauffeur) { ApplicationArea = all; Caption = 'Chauffeur'; }
                field(No_Bon; No_Bon) { ApplicationArea = all; Caption = 'N° BON'; }
                field("Item No_"; "Item No_") { ApplicationArea = all; caption = 'No Article'; }
                field("Item Description"; "Item Description") { ApplicationArea = all; Caption = 'Description Article'; }
                field("Cout Unitaire"; "Cout Unitaire") { ApplicationArea = all; caption = 'Cout Unitaire'; }
                field(KM_President; KM_President) { ApplicationArea = all; Caption = 'KM President'; }
                field(kM_Actuel; kM_Actuel) { ApplicationArea = all; Caption = 'KM Actuel'; }
                field(Dif_KLM; Dif_KLM) { ApplicationArea = all; caption = 'Difference KLM'; }
                field(StockDispo; StockDispo) { ApplicationArea = all; Caption = 'Stock'; }
                field("%GASOIL_S/DIFF_KM"; "%GASOIL_S/DIFF_KM") { ApplicationArea = all; Caption = '% Gasoil S/DIF'; }



            }
        }
    }



    var
        myInt: Integer;
}