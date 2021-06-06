page 50031 "Gestion des Flottes"
{
    PageType = Card;
    SourceTable = "Maintenance Header";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group("Gestion Des Flotte & Maintenance")
            {
                field(No_; Rec.No_Maintenance)
                {
                    ApplicationArea = All;
                    Caption = 'N° Maintenance';

                }
                field("Date Document"; "Date Document") { ApplicationArea = all; Caption = 'Date Document'; }

                field("Type Maintenance"; "Type Maintenance")
                {
                    ApplicationArea = all;
                }


                field(statut; statut)
                {
                    ApplicationArea = all;

                }
                field(Commentaire; Commentaire)
                {
                    ApplicationArea = all;
                }
                field("Type Camion"; "Type Camion")
                {
                    caption = 'Type Camion';

                }
            }
            part(line; "Ligne Flotte Maintenance")
            {
                ApplicationArea = All;
                SubPageLink = No_Maintenance = field (No_Maintenance), "Type Maintenance" = field ("Type Maintenance");
                SubPageView = sorting (No_Maintenance);

            }

        }
    }

    actions
    {
        area(Processing)
        {
            action(Release)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = ReleaseDoc;
                trigger OnAction()
                var
                    Rel: Codeunit "Contract Managment";
                begin
                    rel.Release1(Rec);
                end;


            }
            action(Ropen)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = ReleaseDoc;
                trigger OnAction()
                var
                    Reo: Codeunit "Contract Managment";
                begin
                    Reo.Open1(Rec);
                end;

            }
            action(Post)
            {
                ApplicationArea = All;
                Promoted = true;
                PromotedIsBig = true;
                Image = PostOrder;
                Caption = 'Valider';
                ShortcutKey = F9;

                trigger OnAction()
                var
                    CurrentJnlBatchName: code[10];

                begin
                    TestField(statut, statut::Encours);
                    CODEUNIT.RUN(Codeunit::"Item Jnl.-Post", Rec);
                    CurrPage.UPDATE(false);


                end;

            }

        }
    }

    var
        myInt: Integer;
}