tableextension 50001 "Sales Shipment Line" extends "Sales Shipment Line"
{
    fields
    {
        field(50001; "Contract Type"; Enum "Document Contract Type")
        {
            DataClassification = ToBeClassified;
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
            TableRelation = "Ship-from/to Address";
        }
        field(50013; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-from/to Address";
        }
        //SA
        field(50020; KMDEP; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50021; KMARR; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(50022; DIFF; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50023; kMREEL; Decimal)
        {
            DataClassification = ToBeClassified;

        }
        field(50025; "Lieu Livraison"; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50026; Matricule; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50030; Avance; Decimal)
        {
            DataClassification = CustomerContent;
        }

        //SA
        field(50031; "Resource Group No."; Code[20])
        {
            TableRelation = "Resource Group";
            Editable = false;
        }
        field(50032; "Transport Shipment No."; Code[20])
        {
            DataClassification = ToBeClassified;
        }
    }
}