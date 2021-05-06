page 50011 "Out Of Local Contract"
{
    PageType = Card;
    SourceTable = "Contract Header";
    SourceTableView = where("Contract Type" = const("out of Local"));

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; "No.") { ApplicationArea = All; }
                field("Customer No."; "Customer No.") { ApplicationArea = All; }
                field(Status; Status) { ApplicationArea = All; }
                field("Starting Date"; "Starting Date") { ApplicationArea = All; }
                field("Ending Date"; "Ending Date") { ApplicationArea = All; }
            }
            part(lines; "Out Of Local Contract Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Contract No." = field("No.");
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