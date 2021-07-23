page 50034 "Resource Ledger Entry"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Resource Ledger Entry";
    Caption = 'Ecritures Comptable Ressource';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Entry No."; "Entry No.")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Following Type"; "Following Type")
                {
                    ApplicationArea = All;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Last Mileage"; "Last Mileage")
                {
                    ApplicationArea = All;
                }
                field("N° Serie"; "N° Serie")
                {
                    ApplicationArea = all;
                }
                field("Actual Mileage"; "Actual Mileage")
                {
                    ApplicationArea = All;
                }
                field("Mileage Tracking"; "Mileage Tracking")
                {
                    ApplicationArea = All;
                }
                field("Diff. Mileage"; "Diff. Mileage")
                {
                    ApplicationArea = All;
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