tableextension 50005 "Sales Header" extends "Sales Header"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = " ",Degressive,Package,Local,"out of Local";
        }
    }
}