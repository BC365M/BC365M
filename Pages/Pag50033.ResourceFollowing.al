page 50033 "Resource Following"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Resource Following";
    CardPageId = "Resource Following Card";
    Caption = 'Suivi des Ressources';
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                    Caption = 'N° Ressource';
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'Article N°';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Designation';
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    Caption = 'Type';
                }
                field(Formula; Formula)
                {
                    ApplicationArea = All;
                    Caption = 'Formule';
                }
                field("Last Date Replacement"; "Last Date Replacement")
                {
                    ApplicationArea = All;
                    Caption = 'Derniere Date Remplacemnent';
                }
                field("Next Date Replacement"; "Next Date Replacement")
                {
                    ApplicationArea = All;
                    Caption = 'Prochaine Date Remplacement';
                }
                field("Notify Date Before"; "Notify Date Before")
                {
                    ApplicationArea = All;
                    caption = 'Date Avant Notification';
                }
                field("Notify Date Replacement"; "Notify Date Replacement")
                {
                    ApplicationArea = All;
                    Caption = 'Date Remplacement Notifié';
                }
                field("Replace Every"; "Replace Every")
                {
                    ApplicationArea = All;
                    Caption = 'Quand Remplacer';
                }
                field("Last Mileage Replacement"; "Last Mileage Replacement")
                {
                    ApplicationArea = All;
                    Caption = 'Derniere Kilométrage remplacement';
                }
                field("Next Mileage Replacement"; "Next Mileage Replacement")
                {
                    ApplicationArea = All;
                    Caption = 'Prochaine Kilometrage Remplacement';
                }
                field("Notify Mileage Before"; "Notify Mileage Before")
                {
                    ApplicationArea = All;
                    Caption = 'Kilométrage Avant Notification';
                }
                field("Notify Mileage Replacement"; "Notify Mileage Replacement")
                {
                    ApplicationArea = All;
                    caption = 'Kilométrage remplacement Notifié';
                }
                field("Total Mileage"; "Total Mileage")
                {
                    ApplicationArea = All;
                    Caption = 'Totale Kilometrage';
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Totale Cout';
                }
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
            action(Journal)
            {
                ApplicationArea = All;
                Image = Journal;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "Resource Follow Journal";
            }
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