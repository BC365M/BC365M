tableextension 50007 "Resource" extends Resource
{
    fields
    {
        field(50000; Matricule; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50001; "N° Serie Plateau"; Text[40])
        {
            DataClassification = CustomerContent;
        }
        field(50003; "Gamme"; Text[40])
        {
            DataClassification = CustomerContent;
        }
        field(50004; Modéle; Text[50])
        {
            DataClassification = CustomerContent;
        }
        field(50005; "Type de Véhicule"; Enum "Type De Véhicule")
        {
            DataClassification = CustomerContent;
        }
        field(50010; PTAC; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50011; PTRA; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50012; "Poids max avant"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50014; "Poids max arrière"; code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50015; "Date Mise en Circulation"; Date)
        {
            DataClassification = CustomerContent;
        }
        field(50016; "Date 1er Visite Technique"; Date)
        {
            DataClassification = CustomerContent;
        }
    }

}