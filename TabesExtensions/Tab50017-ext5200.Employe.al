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
        field(50001; "Notice Period V.Medical"; DateFormula)
        {
            Caption = 'Délai Préavis V.Medical';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Notice Period V.Medical") = '' then begin
                    "Notice date V.Medical" := 0D;
                    Evaluate("Warning Period V.Medical", '');
                    "Warning Date V.Medical" := 0D;
                END ELSE BEGIN
                    "Notice date V.Medical" := CalcDate("Notice Period V.Medical", "Date Viste Medical ");
                    if Format("Warning Period V.Medical") <> '' then
                        "Warning Date V.Medical" := CalcDate("Warning Period V.Medical", "Notice date V.Medical");

                END;
            end;

        }

        field(50002; "Notice date V.Medical"; date) { Caption = 'Date Préavis V.Medical'; Editable = false; }
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
                    "Warning Date V.Medical" := CalcDate("Warning Period V.Medical", "Notice date V.Medical");
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
        field(50009; "Notice Period E.Permi"; DateFormula)
        {
            Caption = 'Délai Préavis E.Permi';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Notice Period E.Permi") = '' then begin
                    "Notice date E.Permi" := 0D;
                    Evaluate("Warning Period E.Permi", '');
                    "Warning Date E.Permi" := 0D;
                END ELSE BEGIN
                    "Notice date E.Permi" := CalcDate("Notice Period E.Permi", "Date Creation Permi");
                    if Format("Warning Period E.Permi") <> '' then
                        "Warning Date E.Permi" := CalcDate("Warning Period E.Permi", "Notice date E.Permi");

                END;
            end;

        }

        field(50010; "Notice date E.Permi"; date) { Caption = 'Date Préavis E.Permi'; Editable = false; }
        field(50011; "Warning Period E.Permi"; DateFormula)
        {
            Caption = 'Délai Alert E.Permi';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Warning Period E.Permi") = '' then
                    "Warning Date E.Permi" := 0D
                else
                    "Warning Date E.Permi" := CalcDate("Warning Period E.Permi", "Notice date E.Permi");
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
        field(50014; "Notice Period Carte Prof"; DateFormula)
        {
            Caption = 'Délai Préavis Carte Prof';
            trigger OnValidate()
            var
                myInt: Integer;
            begin
                IF Format("Notice Period Carte Prof") = '' then begin
                    "Notice date Carte Prof" := 0D;
                    Evaluate("Warning Period Carte Prof", '');
                    "Warning Date Carte Prof" := 0D;
                END ELSE BEGIN
                    "Notice date Carte Prof" := CalcDate("Notice Period Carte Prof", "Date Creation Carte Prof");
                    if Format("Warning Period Carte Prof") <> '' then
                        "Warning Date Carte Prof" := CalcDate("Warning Period Carte Prof", "Notice date Carte Prof");

                END;
            end;

        }

        field(50015; "Notice date Carte Prof"; date) { Caption = 'Date Préavis Carte Prof'; Editable = false; }
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
                    "Warning Date Carte Prof" := CalcDate("Warning Period Carte Prof", "Notice date Carte Prof");
            end;

        }
        field(50017; "Warning Date Carte Prof"; Date) { Caption = 'Date Alert Carte Prof'; Editable = false; }
    }

    var
        myInt: Integer;
}