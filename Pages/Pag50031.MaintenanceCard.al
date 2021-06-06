page 50031 "Gestion des Flottes"
{
    PageType = Card;
    SourceTable = "Maintenance Header";
    UsageCategory = Administration;
    DataCaptionFields = "Journal Batch Name";

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
                field("Journal Batch Name"; "Journal Batch Name") { ApplicationArea = all; Caption = 'Nom feuille'; }
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
                    IF statut = statut::"Validée" then
                        Message(('Ecriture Validé , vous nous pouvez pas Modifier'));
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

                    itemJlLine: Record "Item Journal Line";
                    lines: Record "Ligne Flotte & Maintenance";
                    ManLedgerEntry: Record "GMAO Ledger Entry";
                    GmaoHeader: Record "Maintenance Header";

                begin
                    TestField(statut, statut::Encours);

                    lines.SetRange(No_Maintenance, rec.No_Maintenance);
                    GmaoHeader.SetRange("Journal Batch Name", "Journal Batch Name", 'Default');

                    if lines.FindFirst() then
                        repeat
                            ManLedgerEntry.Init();
                            ManLedgerEntry.Validate("Line No_", lines."Line No_");
                            ManLedgerEntry.Validate("Item No_", lines."Item No_");
                            ManLedgerEntry.Validate(DesignationMaintenance, lines.DesignationMaintenance);
                            ManLedgerEntry.Validate(kM_Actuel, lines.kM_Actuel);
                            ManLedgerEntry.Validate(KM_President, lines.KM_President);
                            ManLedgerEntry.Validate("%GASOIL_S/DIFF_KM", lines."%GASOIL_S/DIFF_KM");
                            ManLedgerEntry.Validate(Dif_KLM, lines.Dif_KLM);
                            ManLedgerEntry.Validate(Chauffeur, lines."Shortcut Dimension 7 Code");
                            ManLedgerEntry.Validate("Item Description", lines."Item Description");
                            ManLedgerEntry.Validate("Quantité", lines."Quantité");
                            ManLedgerEntry.Validate("date Document ", lines."Date Document");
                            ManLedgerEntry.Validate("Type de Travail", lines."Type de Travail");
                            ManLedgerEntry.Validate("Type Ecriture", lines."Type Ecriture");
                            ManLedgerEntry.Validate("Type Maintenance", lines."Type Maintenance");
                            ManLedgerEntry.Validate(No_Bon, lines.No_Bon);
                            ManLedgerEntry.Validate(statut, lines.statut);
                            //   until lines.Next() = 0;


                            itemJlLine.Init();
                            itemJlLine.validate("Item No.", lines."Item No_");
                            itemJlLine.Validate(Quantity, lines."Quantité");
                            itemJlLine.validate("Location Code", lines."Location Code");
                            itemJlLine.validate(kM_Actuel, lines.kM_Actuel);
                            itemJlLine.validate(KM_President, lines.KM_President);
                            itemJlLine.validate(Dif_KLM, lines.Dif_KLM);
                            itemJlLine.validate("%GASOIL_S/DIFF_KM", lines."%GASOIL_S/DIFF_KM");
                            itemJlLine.validate("Type Ecriture", lines."Type Ecriture");
                            itemJlLine.Validate("Type de Travail", lines."Type de Travail");
                            itemJlLine.Validate("Type Maintenance", lines."Type Maintenance");
                            itemJlLine.validate(No_Bon, lines.No_Bon);
                            itemJlLine.validate(No_Maintenance, lines.No_Maintenance);
                            itemJlLine.Validate("Line No_", lines."Line No_");
                            itemJlLine.Validate("Posting Date", lines."Date Document");



                        until lines.Next() = 0;


                    CODEUNIT.RUN(Codeunit::"Item Jnl.-Post", itemJlLine);

                    //CurrentJnlBatchName := GETRANGEMAX("Journal Batch Name");
                    CurrPage.UPDATE(false);


                end;

            }

        }
    }

    var
        myInt: Integer;
        CurrentJnlBatchName: code[10];
}