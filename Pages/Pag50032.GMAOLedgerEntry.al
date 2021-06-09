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