page 50003 "Contract Lines Slices"
{
    PageType = List;
    SourceTable = "Contract Line Slices";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // field("Contract Type"; "Contract Type") { ApplicationArea = All; }
                // field("Contract No."; "Contract No.") { ApplicationArea = All; }
                field("Contract Line No."; "Contract Line No.") { ApplicationArea = All; Visible = false; Editable = false; }
                field("Line No."; "Line No.") { ApplicationArea = All; Visible = false; }
                field(Level; Level) { ApplicationArea = All; }
                field(Quantity; Quantity) { ApplicationArea = All; }
                field("Unit Price"; "Unit Price") { ApplicationArea = All; Visible = showPrice; }
                field("Discount Amount"; "Discount Amount") { ApplicationArea = All; Visible = showDiscount; }
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

                trigger OnAction();
                begin

                end;
            }
        }
    }

    trigger OnInit()
    begin
        showDiscount := false;
        showPrice := false;
    end;

    trigger OnOpenPage()
    begin
        showDiscount := (GetFilter("Contract Type") = format("Contract Type"::Degressive));
        showPrice := (GetFilter("Contract Type") = format("Contract Type"::"out of Local"));
    end;

    var
        showPrice: Boolean;
        showDiscount: Boolean;
}