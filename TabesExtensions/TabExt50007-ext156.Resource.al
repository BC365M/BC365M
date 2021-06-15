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

    }

}