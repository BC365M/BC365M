page 50005 "Contract List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract Header";

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Contract Type"; "Contract Type") { ApplicationArea = All; }
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
        area(Navigation)
        {
            action(Card)
            {
                ApplicationArea = All;
                Image = EditLines;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    PageManagement: Codeunit "Page Management";
                begin
                    PageManagement.PageRun(Rec);
                end;
            }
        }
    }
}