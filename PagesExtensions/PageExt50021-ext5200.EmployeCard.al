pageextension 50021 Employe extends 5200
{
    layout
    {
        // Add changes to page layout here
        addbefore(Administration)
        {
            group(Alerts)
            {
                field("Date Viste Medical "; "Date Viste Medical ") { ApplicationArea = all; Caption = 'Date Visite Medical'; }
                field("Warning Period V.Medical"; "Warning Period V.Medical") { ApplicationArea = all; caption = 'Date Alert V.Medical'; }
                field("Warning Date V.Medical"; "Warning Date V.Medical") { ApplicationArea = all; Caption = 'Délai Alert V.Medical'; }
                //
                field("Date Creation Permi"; "Date Creation Permi") { ApplicationArea = all; Caption = 'Date Création Permi'; }
                field("Warning Date E.Permi"; "Warning Date E.Permi") { ApplicationArea = all; Caption = 'Délai Alert E.Permi'; }
                field("Warning Period E.Permi"; "Warning Period E.Permi") { ApplicationArea = all; caption = 'Date Alert E.Permi'; }
                //
                field("Date Creation Carte Prof"; "Date Creation Carte Prof") { ApplicationArea = all; caption = 'Date Création Carte Profesionnel'; }
                field("Warning Date Carte Prof"; "Warning Date Carte Prof") { ApplicationArea = all; caption = 'Délai Alert Carte Prof'; }
                field("Warning Period Carte Prof"; "Warning Period Carte Prof") { ApplicationArea = all; Caption = 'Date Alert Carte Prof'; }
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