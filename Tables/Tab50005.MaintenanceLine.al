table 50005 "Ligne Flotte & Maintenance"
{
    DataClassification = ToBeClassified;

    fields
    {

        field(49; "Type Ecriture"; Option)
        {
            OptionMembers = "","Consommation","Vidange";
        }
        field(50; "Type de Travail"; Code[10])
        {
            TableRelation = "Work Type".Code;
            trigger OnValidate()
            var

            begin
                if "Type de Travail" <> '' then Begin
                    If worktype.Get("Type de Travail") then
                        DesignationMaintenance := worktype.Description;

                End;
            end;

        }
        field(1; No_Maintenance; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Maintenance Header".No_Maintenance;
            Caption = 'N° Maintenance';
        }
        field(2; DesignationMaintenance; Text[50])
        {
            DataClassification = ToBeClassified;
            Caption = 'Designation Intervention';

        }
        field(5; Quantité; Decimal)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                calcDiffSortie();
            end;
        }
        field(6; "Cout Unitaire"; decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(7; Montant; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(10; "Unit of Measure Code"; Code[10])
        {
            TableRelation = "Unit of Measure";
            DataClassification = ToBeClassified;
        }
        field(20; statut; Enum "Status maintenance")
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(15; "Item No_"; code[20])
        {
            TableRelation = Item."No.";
            trigger OnValidate()
            begin

                if "Item No_" <> '' then begin
                    IF item.Get("Item No_") then
                        "Item Description" := item.Description;
                end;

                if "Quantité" <> 0 then begin
                    Montant := "Quantité" * "Cout Unitaire";

                end;

            end;


        }
        field(25; "Location Code"; code[10])
        {
            TableRelation = Location.Code;
            DataClassification = ToBeClassified;
        }
        field(21; "Item Description"; Text[100])
        {
            Caption = 'Designation Article';
            DataClassification = ToBeClassified;
        }
        field(22; StockDispo; Decimal)
        {
            CalcFormula = sum ("Item Ledger Entry".Quantity where ("Item No." = field ("Item No_"), "Location Code" = field ("Location Code")));
            FieldClass = FlowField;
        }
        field(23; Ressource; code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = Resource."No.";

        }
        field(24; No_Bon; code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(26; KM_President; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Kilometrage President';
            trigger OnValidate()

            begin
                calcDiffKM;
                calcDiffSortie;
            end;
        }
        field(27; kM_Actuel; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Kilometrage actuel';
            trigger OnValidate()

            begin
                calcDiffKM();
                calcDiffSortie();

            end;
        }
        field(28; Dif_KLM; Decimal)
        {

            DataClassification = ToBeClassified;
            Caption = 'Difference KLM';
            Editable = false;
            trigger OnValidate()

            begin
                calcDiffKM();

            end;

        }
        field(30; "%GASOIL_S/DIFF_KM"; Decimal)
        {
            caption = '% GASOIL SORTIE/DIFF KM';
        }
        field(8; "Type Maintenance"; enum "Type Maintenance")
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Shortcut Dimension 7 Code"; code[20])
        {
            CaptionClass = '1,2,1';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));
            trigger OnValidate()
            begin

            end;
        }




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
        worktype: Record "Work Type";
        item: Record item;


    trigger OnInsert()
    var

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

    local procedure calcDiffKM()
    var
        myInt: Integer;
    begin
        if KM_President <> kM_Actuel then
            Dif_KLM := (KM_President - kM_Actuel)
        else
            Dif_KLM := 0;

    end;

    local procedure calcDiffSortie()
    var
        myInt: Integer;
    begin
        If Dif_KLM <> "Quantité" then
            "%GASOIL_S/DIFF_KM" := (Dif_KLM / "Quantité")
        else
            "%GASOIL_S/DIFF_KM" := 0;

    end;

    procedure checkStatus()
    var
        maintenanceHeader: Record "Maintenance Header";
    begin
        maintenanceHeader.Get("Type Maintenance", No_Maintenance);
        maintenanceHeader.TestField(statut, maintenanceHeader.statut::Open);
    end;




}