page 50030 "Liste Flotte"
{
    PageType = ListPart;
    SourceTable = "Maintenance Header";
    CardPageId = "Gestion des Flottes";
    Caption = 'Liste des maintenance';

    layout
    {
        area(Content)
        {
            repeater("Liste Des Flotte & Maintenance")
            {
                field(No_; No_Maintenance)
                {
                    ApplicationArea = All;

                }
                field("Ressource No"; "Ressource No")
                {
                    ApplicationArea = All;

                }
                field("Type Camion"; "Type Camion")
                {
                    ApplicationArea = All;

                }
                field("Date Document"; "Date Document")
                {
                    ApplicationArea = All;

                }
                field("Type Maintenance"; "Type Maintenance")
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}