
pageextension 50019 ListRessource extends 77
{
    layout
    {
        // Add changes to page layout here
        addbefore(Name)
        {
            field(Matricule; Matricule) { Caption = 'Matricule'; }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}