page 50037 "Resource Follow Journal"
{
    PageType = Worksheet;
    SourceTable = "Resource Follow Journal";
    AutoSplitKey = true;
    Caption = 'Journal Suivi Ressource';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Date Comtabilisation';
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'N° Document';
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                    Caption = 'N° Ressource';
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                    Caption = 'Code';
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'N°';
                }
                field("Following Type"; "Following Type")
                {
                    ApplicationArea = All;
                    Caption = 'Type Suivie';
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                    Caption = 'Designation';
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                    Caption = 'N° Article';

                }
                // Dev 18/07/2021 sa
                field("N° Serie"; "N° Serie")
                {
                    Caption = 'N° Serie';
                }
                field("Variant Code"; "Variant Code")
                {
                    ApplicationArea = all;
                }
                // Dev 18/07/2021 sa
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                    Caption = 'Code Unité';

                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                    Caption = 'Quantite';
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Coute Unitaire';
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = All;
                    Caption = 'Total Cout';
                    Editable = false;
                }
                field("Mileage Tracking"; "Mileage Tracking")
                {
                    ApplicationArea = All;
                    Caption = 'Suivi du kilométrage';
                }
                field("Last Mileage"; "Last Mileage")
                {
                    ApplicationArea = All;
                    Caption = 'Dernier kilométrage';
                }

                field("Actual Mileage"; "Actual Mileage")
                {
                    ApplicationArea = All;
                    Caption = 'Kilométrage réel';
                }
                field("Diff. Mileage"; "Diff. Mileage")
                {
                    ApplicationArea = All;
                    Caption = 'Diff. Kilométrage';
                }
                field("%GASOIL_S/DIFF_KM"; "%GASOIL_S/DIFF_KM")
                {
                    ApplicationArea = all;
                    Caption = '%GASOIL_S/DIFF_KM';
                }
                field("Location Code"; "Location Code")
                {
                    ApplicationArea = all;
                    Caption = 'Code Magasin';
                }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 7 Code")
                {
                    Caption = 'Chauffeur';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            // SA JNL SerialLine SerialN° managment
            /* action(Lignestracabilite)
             {
                 Caption = 'Tracabilité';
                 ApplicationArea = All;
                 Promoted = true;
                 PromotedIsBig = true;
                 Image = ItemTrackingLines;
                 PromotedCategory = Category6;
                 ToolTip = 'Afficher ou modifier des numéros de série et de lot qui sont affectés à l article sur le document ou la ligne feuille';
                 RunPageMode = Edit;
                 trigger OnAction();
                 var

                 begin
                     OpenItemTrackingLines(false);


                 end;
             }*/
            // SA JNL SerialLine SerialN° managment
            action(Post)
            {
                ApplicationArea = All;
                Image = Post;
                Promoted = true;
                PromotedIsBig = true;

                trigger OnAction();
                var
                    currJournal: Record "Resource Follow Journal";
                    ResLedEntries: Record "Resource Ledger Entry";
                    recResFollowing: Record "Resource Following";
                    recRes: Record Resource;
                    itemJlLine: Record "Item Journal Line";
                    EntryNo: Integer;
                    ItemLedgerEntry: Record "Item Ledger Entry";
                begin
                    if ResLedEntries.FindLast() then
                        EntryNo := ResLedEntries."Entry No.";
                    CurrPage.SetSelectionFilter(currJournal);
                    if currJournal.FindFirst() then begin
                        itemJlLine.SetRange("Journal Template Name", 'ARTICLE');
                        itemJlLine.SetRange("Journal Batch Name", 'MT');
                        itemJlLine.DeleteAll();
                        repeat
                            EntryNo += 1;
                            recRes.Get(currJournal."Resource No.");
                            if currJournal."Mileage Tracking" then begin
                                recRes.CalcFields("Total Mileage");
                                currJournal.testfield("Last Mileage", recRes."Total Mileage");
                            end;
                            recResFollowing.Get(currJournal."Resource No.", currJournal.code, currJournal."No.");

                            if recResFollowing.Type in [recResFollowing.Type::Mileage, recResFollowing.Type::"Mileage/Duration"] then begin
                                recResFollowing.validate("Last Mileage Replacement", currJournal."Actual Mileage");
                            end;

                            if recResFollowing.Type in [recResFollowing.Type::Duration, recResFollowing.Type::"Mileage/Duration"] then begin
                                recResFollowing.validate("Last Date Replacement", currJournal."Posting Date");
                            end;

                            recResFollowing.Modify();

                            ResLedEntries.Init();
                            ResLedEntries."Entry No." := EntryNo;
                            ResLedEntries."Resource No." := currJournal."Resource No.";
                            ResLedEntries."Following Type" := currJournal."Following Type";
                            ResLedEntries.Code := currJournal.code;
                            ResLedEntries."Document No." := currJournal."Document No.";
                            ResLedEntries.Description := currJournal.Description;
                            ResLedEntries."Item No." := currJournal."Item No.";
                            ResLedEntries."Unit of Measure Code" := currJournal."Unit of Measure Code";
                            ResLedEntries.Quantity := currJournal.Quantity;

                            // SA
                            ResLedEntries."N° Serie" := currJournal."N° Serie";

                            //
                            ResLedEntries."Unit Cost" := currJournal."Unit Cost";
                            ResLedEntries."Total Cost" := currJournal."Total Cost";
                            ResLedEntries."Mileage Tracking" := currJournal."Mileage Tracking";
                            ResLedEntries."Last Mileage" := currJournal."Last Mileage";
                            ResLedEntries."Actual Mileage" := currJournal."Actual Mileage";
                            ResLedEntries."Diff. Mileage" := currJournal."Diff. Mileage";
                            ResLedEntries."Posting Date" := currJournal."Posting Date";
                            //SA
                            ResLedEntries."%GASOIL_S/DIFF_KM" := currJournal."%GASOIL_S/DIFF_KM";
                            ResLedEntries.Insert();

                            itemJlLine.Init();
                            itemJlLine.Validate("Journal Template Name", 'ARTICLE');
                            itemJlLine.Validate("Journal Batch Name", 'MT');
                            itemJlLine.Validate("Line No.", EntryNo);
                            //

                            itemJlLine.Insert(true);
                            itemJlLine.Validate("Posting Date", currJournal."Posting Date");
                            itemJlLine.Validate("Document No.", currJournal."Document No.");
                            itemJlLine.Validate("Entry Type", itemJlLine."Entry Type"::"Negative Adjmt.");
                            itemJlLine.validate("Item No.", currJournal."Item No.");
                            itemJlLine.validate("Unit of Measure Code", currJournal."Unit of Measure Code");
                            itemJlLine.Validate(Quantity, currJournal.Quantity);
                            // SA
                            //itemJlLine.Validate(, currJournal."N° Serie");
                            itemJlLine.validate("Serial Number", currJournal."N° Serie");

                            itemJlLine.Modify();
                        until currJournal.Next() = 0;
                        currJournal.DeleteAll();
                        CODEUNIT.RUN(Codeunit::"Item Jnl.-Post", itemJlLine);
                    end;
                end;
            }
        }
    }
}