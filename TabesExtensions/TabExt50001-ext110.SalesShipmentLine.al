tableextension 50001 "Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(50001; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Degressive,Package,Local,"out of Local";
        }
        field(50002; "Contract No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Contract Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Level; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Zone No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Zone";
        }
        field(50008; "Delivery Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(50012; "Ship-From Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("Sell-to Customer No."));
        }
        field(50013; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("Sell-to Customer No."));
        }
        //SA
        field(50020; KMDEP; Code[15])
        {
            DataClassification = ToBeClassified;

        }
        field(50021; KMARR; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; DIFF; Code[15])
        {
            DataClassification = ToBeClassified;

        }
        field(50023; kMREEL; Code[15])
        {
            DataClassification = ToBeClassified;

        }

        //SA
    }
}