tableextension 50005 "Sales Header" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Contract Type"; Enum "Document Contract Type")
        {
            DataClassification = ToBeClassified;
        }
    }
}