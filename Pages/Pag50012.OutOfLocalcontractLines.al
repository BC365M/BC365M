page 50012 "Out Of Local Contract Lines"
{
    PageType = ListPart;
    SourceTable = "Contract Line";
    SourceTableView = where ("Contract Type" = const ("out of Local"));
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                // field("Contract Type"; "Contract Type") { ApplicationArea = All; }
                // field("Contract No."; "Contract No.") { ApplicationArea = All; }
                field("Line No."; "Line No.") { ApplicationArea = All; Visible = false; }
                field("Customer No."; "Customer No.") { ApplicationArea = All;Visible = false; }
                field(Type; Rec.Type)
                {
                    ToolTip = 'Specifies the value of the Type field';
                    ApplicationArea = All;
                }
                field("Resource Group No."; "Resource Group No.") { ApplicationArea = All; }
                field("No."; "No.") { ApplicationArea = All; }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ToolTip = 'Specifies the value of the Unit of Measure Code field';
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field';
                    ApplicationArea = All;
                    //Visible = false;
                }
                field("Zone No."; "Zone No.") { ApplicationArea = All; Editable = false; }
                field("Ship-From Code"; "Ship-From Code") { ApplicationArea = All; }
                field("Ship-to Code"; "Ship-to Code") { ApplicationArea = All; }
                field("Starting Date"; "Starting Date") { ApplicationArea = All; }
                field("Ending Date"; "Ending Date") { ApplicationArea = All; }
                field(Level; Level) { ApplicationArea = All; Visible = false; }
                field(Quantity; Quantity) { ApplicationArea = All; Visible = false; }
                field("Unit Price"; "Unit Price") { ApplicationArea = All; Visible = false; }
                field("Discount Amount"; "Discount Amount") { ApplicationArea = All; Visible = false; }
                field("Details Count"; "Details Count") { ApplicationArea = All; }
                field("Shipped Qty"; "Shipped Qty") { ApplicationArea = All; }
                field("Qty. Shipped"; "Qty. Shipped") { ApplicationArea = All; }
                field("Qty. Invoiced"; "Qty. Invoiced") { ApplicationArea = All; }
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
}