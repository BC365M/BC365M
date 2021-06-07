tableextension 50017 Employe extends 5200
{
    fields
    {
        // Add changes to table fields here
        field(50105; "Date Debut V.Medical"; date) { caption = 'Date Debut V.Medical'; }
        field(50106; "Date Fin V.Medical"; date)
        {
            caption = 'Date fin V.Medical';
            trigger OnValidate()
            begin
                if ("Date Fin V.Medical" <> 0D) and (format("Delai Alerte V.Medical") <> '') then
                    Validate("Date Alerte V.Medical", CalcDate("Delai Alerte V.Medical", "Date Fin V.Medical"));
            end;
        }
        field(50107; "Delai Alerte V.Medical"; DateFormula)
        {
            caption = 'Delai Alerte V.Medical';
            trigger OnValidate()
            begin
                if ("Date Fin V.Medical" <> 0D) and (format("Delai Alerte V.Medical") <> '') then
                    Validate("Date Alerte V.Medical", CalcDate("Delai Alerte V.Medical", "Date Fin V.Medical"));
            end;
        }
        field(50108; "Date Alerte V.Medical"; date) { caption = 'Date Alerte V.Medical'; Editable = false; }

        //Calcule Permi
        field(50109; "Date Debut Permi"; date) { caption = 'Date DebutPermi'; }
        field(50110; "Date Fin Permi"; date)
        {
            caption = 'Date fin Permi';
            trigger OnValidate()
            begin
                if ("Date Fin Permi" <> 0D) and (format("Delai Alerte Permi") <> '') then
                    Validate("Date Alerte Permi", CalcDate("Delai Alerte Permi", "Date Fin Permi"));
            end;
        }
        field(50112; "Delai Alerte Permi"; DateFormula)
        {
            caption = 'Delai Alerte Permi';
            trigger OnValidate()
            begin
                if ("Date Fin Permi" <> 0D) and (format("Delai Alerte Permi") <> '') then
                    Validate("Date Alerte Permi", CalcDate("Delai Alerte Permi", "Date Fin Permi"));
            end;
        }
        field(50113; "Date Alerte Permi"; date) { caption = 'Date Alerte Permi'; Editable = false; }
        //Calcule Carte Professionnelle
        field(50114; "Date Debut Carte Prof"; date) { caption = 'Date Carte Prof'; }
        field(50115; "Date Fin Carte Prof"; date)
        {
            caption = 'Date fin Carte Prof';
            trigger OnValidate()
            begin
                if ("Date Fin Carte Prof" <> 0D) and (format("Delai Alerte Carte Prof") <> '') then
                    Validate("Date Alerte Carte Prof", CalcDate("Delai Alerte Carte Prof", "Date Fin Carte Prof"));
            end;
        }
        field(50116; "Delai Alerte Carte Prof"; DateFormula)
        {
            caption = 'Delai Alerte Carte Prof';
            trigger OnValidate()
            begin
                if ("Date Fin Carte Prof" <> 0D) and (format("Delai Alerte Carte Prof") <> '') then
                    Validate("Date Alerte Carte Prof", CalcDate("Delai Alerte Carte Prof", "Date Fin Carte Prof"));
            end;
        }
        field(50117; "Date Alerte Carte Prof"; date) { caption = 'Date Alerte Carte Prof'; Editable = false; }

    }

    var
        myInt: Integer;
}