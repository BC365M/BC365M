page 50032 "GMAO Ledger Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "GMAO Ledger Entry";
    Editable = false;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(No_Maintenance; No_Maintenance) { ApplicationArea = All; }
                field("Line No_"; "Line No_") { ApplicationArea = All; }
                field(DesignationMaintenance; DesignationMaintenance) { ApplicationArea = All; }
                field("Quantité"; "Quantité") { ApplicationArea = All; }
                field(Ressource; Ressource) { ApplicationArea = all; }
                field(Chauffeur; Chauffeur) { ApplicationArea = all; }
                field("Type Ecriture"; "Type Ecriture") { ApplicationArea = all; }
                field("Type de Travail"; "Type de Travail") { ApplicationArea = all; }
                field("Type Maintenance"; "Type Maintenance") { ApplicationArea = all; }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}