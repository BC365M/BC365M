table 50006 "GMAO Ledger Entry"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; No_Maintenance; code[20]) { DataClassification = CustomerContent; }
        field(2; DesignationMaintenance; Text[50]) { DataClassification = CustomerContent; }
        field(50000; "date Document "; Date) { DataClassification = CustomerContent; }
        field(5; Quantité; Decimal) { DataClassification = CustomerContent; }
        field(6; "Cout Unitaire"; decimal) { DataClassification = CustomerContent; }
        field(7; Montant; Decimal) { DataClassification = CustomerContent; }
        field(8; "Type Maintenance"; enum "Type Maintenance") { DataClassification = CustomerContent; }
        field(10; "Unit of Measure Code"; Code[10]) { DataClassification = CustomerContent; }
        field(20; statut; Enum "Status maintenance") { DataClassification = CustomerContent; }
        field(49; "Type Ecriture"; Option) { OptionMembers = "","Consommation","Vidange"; }
        field(50; "Type de Travail"; Code[10]) { DataClassification = CustomerContent; }
        field(15; "Item No_"; code[20]) { DataClassification = CustomerContent; }
        field(25; "Location Code"; code[10]) { DataClassification = CustomerContent; }
        field(21; "Item Description"; Text[100]) { DataClassification = CustomerContent; }
        field(23; Chauffeur; code[30]) { DataClassification = CustomerContent; }
        field(24; No_Bon; code[10]) { DataClassification = CustomerContent; }
        field(26; KM_President; Decimal) { DataClassification = CustomerContent; }
        field(27; kM_Actuel; Decimal) { DataClassification = CustomerContent; }
        field(28; Dif_KLM; Decimal) { DataClassification = CustomerContent; }
        field(30; "%GASOIL_S/DIFF_KM"; Decimal) { DataClassification = CustomerContent; }

    }


    keys
    {
        key(PK; No_Maintenance)
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}