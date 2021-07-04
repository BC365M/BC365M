tableextension 50007 "Resource" extends Resource
{
    fields
    {
        field(50000; Matricule; Code[20]) { DataClassification = CustomerContent; }
        field(50001; "N° Serie Plateau"; Text[40]) { DataClassification = CustomerContent; }
        field(50003; "Gamme"; Text[40]) { DataClassification = CustomerContent; }
        field(50004; Modéle; Text[50]) { DataClassification = CustomerContent; }
        field(50005; "Type de Véhicule"; Enum "Type De Véhicule") { DataClassification = CustomerContent; }
        field(50010; PTAC; code[20]) { DataClassification = CustomerContent; }
        field(50011; PTRA; code[20]) { DataClassification = CustomerContent; }
        field(50012; "Poids max avant"; code[20]) { DataClassification = CustomerContent; }
        field(50014; "Poids max arrière"; code[20]) { DataClassification = CustomerContent; }
        field(50015; "Date Mise en Circulation"; Date) { DataClassification = CustomerContent; }
        field(50019; "N° IMMO"; Code[10]) { TableRelation = "Fixed Asset"."No."; }
        field(50020; "Coute D'aquisition"; Code[10])
        {
            FieldClass = FlowField;
        }
        //  Calcule D'alert        
        field(50100; "Date Debut Assurance"; date) { caption = 'Date début Assurance'; }
        field(50101; "Date Fin Assurance"; date)
        {
            caption = 'Date fin Assurance';
            trigger OnValidate()
            begin
                if ("Date Fin Assurance" <> 0D) and (format("Delai Alerte Assurance") <> '') then
                    Validate("Date Alerte Assurance", CalcDate("Delai Alerte Assurance", "Date Fin Assurance"));
            end;
        }
        field(50102; "Delai Alerte Assurance"; DateFormula)
        {
            caption = 'Delai Alerte Assurance';
            trigger OnValidate()
            begin
                if ("Date Fin Assurance" <> 0D) and (format("Delai Alerte Assurance") <> '') then
                    Validate("Date Alerte Assurance", CalcDate("Delai Alerte Assurance", "Date Fin Assurance"));
            end;
        }
        field(50103; "Date Alerte Assurance"; date) { caption = 'Date Alerte Assurance'; Editable = false; }
        // Calcule La date echeance Visite Technique
        field(50105; "Date Debut V.Technique"; date) { caption = 'Date Debut V.Technique'; }
        field(50106; "Date Fin V.Technique"; date)
        {
            caption = 'Date fin V.Technique';
            trigger OnValidate()
            begin
                if ("Date Fin V.Technique" <> 0D) and (format("Delai Alerte V.Technique") <> '') then
                    Validate("Date Alerte V.Technique", CalcDate("Delai Alerte V.Technique", "Date Fin V.Technique"));
            end;
        }
        field(50107; "Delai Alerte V.Technique"; DateFormula)
        {
            caption = 'Delai Alerte V.Technique';

            trigger OnValidate()
            begin
                if ("Date Fin V.Technique" <> 0D) and (format("Delai Alerte V.Technique") <> '') then
                    Validate("Date Alerte V.Technique", CalcDate("Delai Alerte V.Technique", "Date Fin V.Technique"));
            end;
        }
        field(50108; "Date Alerte V.Technique"; date) { caption = 'Date Alerte V.Technique'; Editable = false; }
        //Calcule De Date Prochaine Vidange
        /// Alert Vidange
        field(50055; "Warnnin KM"; Decimal)
        {
            Caption = 'KLM Alert';

        }
        field(50056; "Prochaine Vidange"; Decimal)
        {
            Caption = 'Prochaine Vidange';

        }
        field(50057; "Dernier KLM"; Decimal)
        {
            caption = 'Dernier KLM';
            trigger OnValidate()
            begin
                if ("Dernier KLM" <> 0) AND (FORMAT("Warnnin KM") <> '') then
                    "Prochaine Vidange" := (("Dernier KLM") - ("warnnin KM"));

            end;
        }
        field(50080; "KLM Depart"; Decimal)
        {
            caption = 'KLM Depart';
            // 
        }
        /// Gestion des Pneus

        field(50051; Pdevant_Gauche; Option)
        {
            Caption = 'Devant Gauche 1';
            OptionMembers = ,DG1;
        }
        field(50063; Pdevant_Gauche2; Option) { Caption = 'Devant Gauche 2'; OptionMembers = ,DG2; }
        field(50052; Pdevant_Droit1; Option)
        {
            Caption = 'Devant Droit 1';
            OptionMembers = ,DD1;
        }
        field(50064; Pdevant_Droit2; Option) { Caption = 'Devant Droit 2'; OptionMembers = ,DD2; }
        field(50053; Pdevant_Secours1; Option)
        {
            Caption = 'Emplacement Secours 1';
            OptionMembers = ,DS1;
        }
        field(50062; Pdevant_Secours2; Option) { caption = 'Emplacement Secours 2'; OptionMembers = ,DS2; }
        field(50054; DNo_Serie; Integer)
        {
            Caption = 'N° serie P devant';
        }
        field(50059; "D_Date echeange"; Date)
        {
            Caption = 'Date d&echeange';
        }
        field(50060; "D_Kilometrage"; Decimal)
        {
            Caption = 'Kilometrage Pneu devant';
        }
        field(50061; "D_Kilometrage Echange"; Decimal)
        {
            Caption = 'Kilometrage echange Pneu devant';
        }

        field(50122; "Total Mileage"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum ("Resource Ledger Entry"."Diff. Mileage" where ("Resource No." = field ("No.")));
            Editable = false;
        }
        field(50130; "Total Cost"; Decimal)
        {
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = sum ("Resource Ledger Entry"."Total Cost" where ("Resource No." = field ("No."), "Posting Date" = field ("Date Filter")));
            Editable = false;
        }

    }

}