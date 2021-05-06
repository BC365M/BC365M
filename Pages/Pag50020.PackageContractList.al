page 50020 "Package Contract List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract Header";
    SourceTableView = where ("Contract Type" = const (Package));
    CardPageId = "Package Contract";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field("Customer No."; "Customer No.") { ApplicationArea = All; }
                field(Status; Status) { ApplicationArea = All; }
                field("Starting Date"; "Starting Date") { ApplicationArea = All; }
                field("Ending Date"; "Ending Date") { ApplicationArea = All; }
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