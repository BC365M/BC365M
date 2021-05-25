page 50006 "Contract Line List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Contract Line";
    //Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Contract Type"; "Contract Type") { ApplicationArea = All; }
                field("Contract No."; "Contract No.") { ApplicationArea = All; }
                field("Line No."; "Line No.") { ApplicationArea = All; }
                field("Customer No."; "Customer No.") { ApplicationArea = All; }
                field(Status; Status) { ApplicationArea = All; }
                field("Starting Date"; "Starting Date") { ApplicationArea = All; }
                field("Ending Date"; "Ending Date") { ApplicationArea = All; }
                field(Type; Type) { ApplicationArea = All; }
                field("Resource Group No."; "Resource Group No.") { ApplicationArea = All; }
                field("No."; "No.") { ApplicationArea = All; }

            }
        }
    }
}