page 50001 "Degressive Contract"
{
    PageType = Card;
    SourceTable = "Contract Header";
    SourceTableView = where ("Contract Type" = const (Degressive));

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
            part(lines; "Degressive Contract Lines")
            {
                ApplicationArea = All;
                SubPageLink = "Contract No." = field ("No.");
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Release)
            {
                ApplicationArea = All;
                Image = ReleaseDoc;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    cu: Codeunit "Contract Managment";
                begin
                    cu.Release(rec);
                end;
            }
            action(Reopen)
            {
                ApplicationArea = All;
                Image = ReOpen;
                Promoted = true;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    cu: Codeunit "Contract Managment";
                begin
                    cu.Open(rec);
                end;
            }
        }
    }
}