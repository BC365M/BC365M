table 50004 "Maintenance Header"
{
    DataClassification = ToBeClassified;
    LookupPageId = "Liste Flotte";

    fields
    {
        field(1; No_Maintenance; code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'N° maintenance';
            Editable = false;

        }
        field(2; "Journal Batch Name"; code[10])
        {
            // DataClassification = ToBeClassified;
            TableRelation = "Item Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Journal Batch Name"));
            Enabled = false;

        }

        field(3; "Type Camion"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = "","SOLO","Remorque";
        }
        field(4; "Date Document"; Date)
        {
            DataClassification = ToBeClassified;
        }

        field(6; statut; enum "Status maintenance") { DataClassification = ToBeClassified; Editable = false; }
        field(7; "Date Creation"; DateTime) { DataClassification = ToBeClassified; }
        field(8; "Type Maintenance"; enum "Type Maintenance")
        {
            DataClassification = ToBeClassified;
        }
        field(18; Commentaire; text[1000]) { DataClassification = ToBeClassified; }
        field(20; "No. Series"; Code[20])
        {
            TableRelation = Currency;
        }
        field(50130; validé; Boolean) { DataClassification = ToBeClassified; Editable = false; }

    }

    keys
    {
        key(PK; No_Maintenance, "Type Maintenance")
        {
            Clustered = true;
        }
    }
    var
        DimMgt: Codeunit "DimensionManagement";
        GetSalesSetup: Record "Sales & Receivables Setup";
        NoSerieMgt: Codeunit NoSeriesManagement;

    trigger OnInsert()
    var
        SalesSetup: Record "Sales & Receivables Setup";
        NoSeriesMgt: Codeunit NoSeriesManagement;
    begin
        IF No_Maintenance = '' THEN BEGIN
            SalesSetup.GET;
            SalesSetup.TESTFIELD("maintenance Nos.");
            NoSeriesMgt.InitSeries(SalesSetup."maintenance Nos.", xRec."No. Series", 0D, No_Maintenance, "No. Series");
        END;
    end;

    trigger OnModify()
    begin
        if (statut <> statut::Encours) AND (statut <> statut::Open) then
            TestField(statut, statut::Encours);
    end;

    trigger OnDelete()
    Var
        line: Record "Ligne Flotte & Maintenance";
    begin
        TestField(statut, statut::Open);
        line.SetRange("Type Maintenance", "Type Maintenance");
        line.SetRange(No_Maintenance, No_Maintenance);
        Line.DeleteAll(true);

    end;

    trigger OnRename()
    begin

    end;



}