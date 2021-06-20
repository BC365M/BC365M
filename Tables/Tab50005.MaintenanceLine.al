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
            Editable = false;
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
                    "Unit of Measure Code" := item."Base Unit of Measure";
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
            trigger OnValidate()
            var
                itemledgerENtry: Record "Ligne Flotte & Maintenance";
                res: Record Resource;
            begin
                res.SetRange("No.", itemledgerENtry.Ressource);
                if res.FindFirst() then
                    repeat
                        res.get(itemledgerENtry."Ressource");
                        res."KLM Depart" := itemledgerENtry.KM_President;
                        res.Modify(true);
                    until itemledgerENtry.Next() = 0;
            end;
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
        field(50000; "Date Document"; date)
        {

            Caption = 'Date Document';
            FieldClass = FlowField;
            CalcFormula = lookup ("Maintenance Header"."Date Document" where ("Type Maintenance" = field ("Type Maintenance"), No_Maintenance = field (No_Maintenance)));
            Editable = false;


        }
        field(50001; "Line No_"; Integer) { DataClassification = ToBeClassified; }
        field(50130; validé; Boolean) { DataClassification = ToBeClassified; Editable = false; }
        field(30; "%GASOIL_S/DIFF_KM"; Decimal)
        {
            caption = '% GASOIL SORTIE/DIFF KM';
            Editable = false;
        }
        field(8; "Type Maintenance"; enum "Type Maintenance")
        {
            DataClassification = ToBeClassified;
        }
        field(55; "Shortcut Dimension 7 Code"; code[20])
        {
            CaptionClass = 'Chauffeur';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));
            trigger OnValidate()
            begin

            end;
        }
        field(100; "Shortcut Dimension 1 Code"; Code[20]) { }
        field(101; "Shortcut Dimension 2 Code"; Code[20]) { }
        field(102; "Dimension Setr ID"; Integer) { }




    }

    keys
    {
        key(PK; No_Maintenance, "Type Maintenance", "Line No_")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;
        worktype: Record "Work Type";
        item: Record item;
        DimMgt: Codeunit DimensionManagement;

        ManiLine: Record "Ligne Flotte & Maintenance";


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
            "%GASOIL_S/DIFF_KM" := (Dif_KLM / "Quantité" * 100)
        else
            "%GASOIL_S/DIFF_KM" := 0;

    end;

    procedure ShowDoc()
    var
        OldDimSetID: Integer;
    begin
        OldDimSetID := "Dimension Setr ID";
        //   "Dimension Setr ID" := DimMgt.EditDimensionSet2("Dimension Setr ID", StrSubstNo('%1 %2 %3', "Type Maintenance", No_Maintenance, "Line No_"),
        //   "Shortcut Dimension 1 Code");

        if OldDimSetID <> "Dimension Setr ID" THEN begin
            Modify();
            if maintenancelineExit then
                updateAllLineDim("Dimension Setr ID", OldDimSetID);
        END;

    end;

    local procedure maintenancelineExit(): Boolean
    var
    begin
        ManiLine.Reset();
        ManiLine.SetRange("Type Maintenance", "Type Maintenance");
        ManiLine.SetRange(No_Maintenance, No_Maintenance);
        exit(ManiLine.Find('-'));
    end;

    local procedure updateAllLineDim(NewParentDimSetID: Integer; OldParentDimSetID: Integer)
    var
        NewDimSetID: Integer;
    begin
        if NewParentDimSetID = OldParentDimSetID then
            exit;
        if not Confirm('vous avez probabelment modifier un axe analytique') Then
            exit;
        ManiLine.Reset();
        ManiLine.SetRange("Type Maintenance", "Type Maintenance");
        ManiLine.SetRange(No_Maintenance, No_Maintenance);
        ManiLine.LockTable();
        if ManiLine.find('-') then
            repeat
                NewDimSetID := DimMgt.GetDeltaDimSetID(ManiLine."Dimension Setr ID", NewParentDimSetID, OldParentDimSetID);
                if ManiLine."Dimension Setr ID" <> NewDimSetID then begin
                    ManiLine."Dimension Setr ID" := NewDimSetID;
                    DimMgt.UpdateGlobalDimFromDimSetID(
                        ManiLine."Dimension Setr ID", ManiLine."Shortcut Dimension 1 Code", ManiLine."Shortcut Dimension 2 Code");
                    ManiLine.Modify();
                end;
            until ManiLine.Next = 0;


    end;

    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])

    var

    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Setr ID");
    end;

    procedure checkStatus()
    var
        maintenanceHeader: Record "Maintenance Header";
    begin
        maintenanceHeader.Get("Type Maintenance", No_Maintenance);
        maintenanceHeader.TestField(statut, maintenanceHeader.statut::Open);
    end;




}