tableextension 50009 "Sales Shipment Header" extends "Sales Shipment Header"
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