tableextension 50006 "Sales & Receivables Setup" extends "Sales & Receivables Setup"
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Contract Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }
        field(50001; "maintenance Nos."; Code[20])
        {
            TableRelation = "No. Series";
        }

    }
}