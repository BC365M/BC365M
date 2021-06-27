page 50033 "Resource Following"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Resource Following";
    CardPageId = "Resource Following Card";
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                }
                field(Formula; Formula)
                {
                    ApplicationArea = All;
                }
                field("Last Date Replacement"; "Last Date Replacement")
                {
                    ApplicationArea = All;
                }
                field("Next Date Replacement"; "Next Date Replacement")
                {
                    ApplicationArea = All;
                }
                field("Replace Every"; "Replace Every")
                {
                    ApplicationArea = All;
                }
                field("Last Mileage Replacement"; "Last Mileage Replacement")
                {
                    ApplicationArea = All;
                }
                field("Next Mileage Replacement"; "Next Mileage Replacement")
                {
                    ApplicationArea = All;
                }
                field("Total Mileage"; "Total Mileage")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; "Total Cost")
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