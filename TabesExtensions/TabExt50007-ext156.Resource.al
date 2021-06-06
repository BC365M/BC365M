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
            // CalcFormula = lookup (Resource."N° IMMO" where ("N° IMMO" =Record.field()));
            //  "FA Depreciation Book"."Acquisition Cost" where ("FA No." = ));
        }
        //  Calcule D'alert 
        field(50040; "Date Creation V.Technique"; Date)
        {
            Caption = 'Date Création Visite technique';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }
        field(50041; "Date Alerte V.Technique"; Date)
        {
            Caption = 'Date Alerte Visite technique';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }

        field(50043; "Warning Period V.Technique"; DateFormula)
        {
            Caption = 'Délai Alert V.Technique';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Warning Period V.Technique") = '' then
                    "Warning Date V.Technique" := 0D
                else
                    "Warning Date V.Technique" := CalcDate("Warning Period V.Technique");
            end;

        }
        field(50044; "Warning Date V.Technique"; Date) { Caption = 'Date Alert V.Technique'; Editable = false; }
        //
        field(50050; "Date Creation Assurance"; Date)
        {
            Caption = 'Date Création Assurance';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }

        field(50053; "Warning Period Assurance"; DateFormula)
        {
            Caption = 'Délai Alert Assurance';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Warning Period Assurance") = '' then
                    "Warning Date Assurance" := 0D
                else
                    "Warning Date Assurance" := CalcDate("Warning Period Assurance");
            end;

        }
        field(50054; "Warning Date Assurance"; Date) { Caption = 'Date Alert Assurance'; Editable = false; }

        /// Alert Vidange
        field(50055; "Warnnin KM"; Decimal)
        {
            Caption = 'KLM Alert';
        }
        field(50056; "Date Creation Vidange"; Date) { Caption = 'Date dérniere Vidange'; }
        field(50057; "Dernier KLM"; code[50]) { caption = 'Dernier KLM'; }
        field(50080; "KLM Depart"; Decimal) { caption = 'KLM Depart'; }
    }

}