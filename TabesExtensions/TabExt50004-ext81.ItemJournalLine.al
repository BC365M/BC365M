tableextension 50004 "Item Journal Line" extends "Item Journal Line"
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
        field(50004; "Contract Level"; Integer)
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
        }
        field(50013; "Ship-to Code"; Code[10])
        {
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
        field(50026; Matricule; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50030; Avance; Decimal)
        {
            DataClassification = CustomerContent;
        }

        //SA
        //Maintenance
        /*
        field(50031; "Type Maintenance"; enum "Type Maintenance") { DataClassification = CustomerContent; }
        field(50032; "Type Ecriture"; Option) { OptionMembers = "","Consommation","Vidange"; }
        field(50033; "Type de Travail"; Code[10]) { DataClassification = CustomerContent; }
        field(50034; Chauffeur; code[30]) { DataClassification = CustomerContent; }
        field(50035; No_Bon; code[10]) { DataClassification = CustomerContent; }
        field(50036; KM_President; Decimal) { DataClassification = CustomerContent; }
        field(50037; kM_Actuel; Decimal) { DataClassification = CustomerContent; }
        field(50038; Dif_KLM; Decimal) { DataClassification = CustomerContent; }
        field(50039; "%GASOIL_S/DIFF_KM"; Decimal) { DataClassification = CustomerContent; }
        field(50040; "Line No_"; Integer) { DataClassification = ToBeClassified; }
        field(50041; No_Maintenance; Code[20]) { DataClassification = ToBeClassified; }
        */

    }
}