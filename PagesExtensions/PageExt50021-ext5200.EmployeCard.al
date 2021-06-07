pageextension 50021 Employe extends 5200
{
    layout
    {
        // Add changes to page layout here
        addbefore(Administration)
        {
            group(Alerts)
            {
                field("Date Debut V.Medical"; "Date Debut V.Medical") { ApplicationArea = all; }
                field("Date Fin V.Medical"; "Date Fin V.Medical") { ApplicationArea = all; }
                field("Delai Alerte V.Medical"; "Delai Alerte V.Medical") { ApplicationArea = all; }
                field("Date Alerte V.Medical"; "Date Alerte V.Medical") { ApplicationArea = all; }
                field("Date Debut Carte Prof"; "Date Debut Carte Prof") { ApplicationArea = all; }
                field("Date Fin Carte Prof"; "Date Fin Carte Prof") { ApplicationArea = all; }
                field("Delai Alerte Carte Prof"; "Delai Alerte Carte Prof") { ApplicationArea = all; }
                field("Date Alerte Carte Prof"; "Date Alerte Carte Prof") { ApplicationArea = all; }

                field("Date Debut Permi"; "Date Debut Permi") { ApplicationArea = all; }
                field("Date Fin Permi"; "Date Fin Permi") { ApplicationArea = all; }
                field("Delai Alerte Permi"; "Delai Alerte Permi") { ApplicationArea = all; }
                field("Date Alerte Permi"; "Date Alerte Permi") { ApplicationArea = all; }



            }

        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}