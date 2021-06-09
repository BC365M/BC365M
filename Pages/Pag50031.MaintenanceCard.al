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
                field("validé"; "validé") { ApplicationArea = all; }

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
                    TestField("Date Document");
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
                    res: Record Resource;

                begin
                    TestField(statut, statut::Encours);
                    itemJlLine.SetRange("Journal Template Name", 'ARTICLE');
                    itemJlLine.SetRange("Journal Batch Name", 'MT');
                    itemJlLine.DeleteAll();

                    lines.SetRange(No_Maintenance, rec.No_Maintenance);
                    GmaoHeader.SetRange("Journal Batch Name", "Journal Batch Name", 'Default');

                    if lines.FindFirst() then
                        repeat
                            ManLedgerEntry.Init();
                            ManLedgerEntry.SetCurrentKey(No_Maintenance, "Line No_");
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
                            ManLedgerEntry.Insert(true);
                            // ManLedgerEntry.Modify(true);




                            itemJlLine.Init();
                            itemJlLine.Validate("Journal Template Name", 'ARTICLE');
                            itemJlLine.Validate("Journal Batch Name", 'MT');
                            itemJlLine.Validate("Line No.", lines."Line No_");
                            itemJlLine.Insert(true);
                            itemJlLine.Validate("Posting Date", today);
                            itemJlLine.Validate("Document No.", rec.No_Maintenance);
                            itemJlLine.Validate("Entry Type", itemJlLine."Entry Type"::"Negative Adjmt.");
                            itemJlLine.validate("Item No.", lines."Item No_");
                            itemJlLine.Validate(Quantity, lines."Quantité");
                            itemJlLine.validate("Location Code", lines."Location Code");


                            itemJlLine.Modify();
                        until lines.Next() = 0;

                    TestField(statut, statut::Encours);
                    TestField("Date Document");
                    Validate(statut, statut::"Validée");
                    Validate("validé", true);



                    Modify();

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