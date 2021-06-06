tableextension 50017 Employe extends 5200
{
    fields
    {
        // Add changes to table fields here
        field(50000; "Date Viste Medical "; Date)
        {
            Caption = 'Date V.Medical';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }

        field(50003; "Warning Period V.Medical"; DateFormula)
        {
            Caption = 'Délai Alert V.Medical';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Warning Period V.Medical") = '' then
                    "Warning Date V.Medical" := 0D
                else
                    "Warning Date V.Medical" := CalcDate("Warning Period V.Medical");
            end;

        }
        field(50004; "Warning Date V.Medical"; Date) { Caption = 'Date Alert V.Medical'; Editable = false; }
        // Calc Expiration Date Permi
        field(50008; "Date Creation Permi"; Date)
        {
            Caption = 'Date Création Permi';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }

        field(50011; "Warning Period E.Permi"; DateFormula)
        {
            Caption = 'Délai Préavie E.Permi';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Warning Period E.Permi") = '' then
                    "Warning Date E.Permi" := 0D
                else
                    "Warning Date E.Permi" := CalcDate("Warning Period E.Permi");
            end;

        }
        field(50012; "Warning Date E.Permi"; Date) { Caption = 'Date Alert E.Permi'; Editable = false; }
        // Calcule Date Expiration Carte Professionnelle
        field(50013; "Date Creation Carte Prof"; Date)
        {
            Caption = 'Date Création Carte Profesionnel';
            DataClassification = ToBeClassified;
            trigger OnValidate()
            var
                myInt: Integer;
            begin

            end;
        }

        field(50016; "Warning Period Carte Prof"; DateFormula)
        {
            Caption = 'Délai Alert Carte Prof';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Warning Period Carte Prof") = '' then
                    "Warning Date Carte Prof" := 0D
                else
                    "Warning Date Carte Prof" := CalcDate("Warning Period Carte Prof");
            end;

        }
        field(50017; "Warning Date Carte Prof"; Date) { Caption = 'Date Alert Carte Prof'; Editable = false; }
    }

    var
        myInt: Integer;
}