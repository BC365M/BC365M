page 50037 "Resource Follow Journal"
{
    PageType = Worksheet;
    SourceTable = "Resource Follow Journal";
    AutoSplitKey = true;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field("Following Type"; "Following Type")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Item No."; "Item No.")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; "Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field(Quantity; Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; "Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = All;
                }
                field("Mileage Tracking"; "Mileage Tracking")
                {
                    ApplicationArea = All;
                }
                field("Last Mileage"; "Last Mileage")
                {
                    ApplicationArea = All;
                }

                field("Actual Mileage"; "Actual Mileage")
                {
                    ApplicationArea = All;
                }
                field("Diff. Mileage"; "Diff. Mileage")
                {
                    ApplicationArea = All;
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
                            ResLedEntries."Unit Cost" := currJournal."Unit Cost";
                            ResLedEntries."Total Cost" := currJournal."Total Cost";
                            ResLedEntries."Mileage Tracking" := currJournal."Mileage Tracking";
                            ResLedEntries."Last Mileage" := currJournal."Last Mileage";
                            ResLedEntries."Actual Mileage" := currJournal."Actual Mileage";
                            ResLedEntries."Diff. Mileage" := currJournal."Diff. Mileage";
                            ResLedEntries."Posting Date" := currJournal."Posting Date";
                            ResLedEntries.Insert();

                            itemJlLine.Init();
                            itemJlLine.Validate("Journal Template Name", 'ARTICLE');
                            itemJlLine.Validate("Journal Batch Name", 'MT');
                            itemJlLine.Validate("Line No.", EntryNo);
                            itemJlLine.Insert(true);
                            itemJlLine.Validate("Posting Date", currJournal."Posting Date");
                            itemJlLine.Validate("Document No.", currJournal."Document No.");
                            itemJlLine.Validate("Entry Type", itemJlLine."Entry Type"::"Negative Adjmt.");
                            itemJlLine.validate("Item No.", currJournal."Item No.");
                            itemJlLine.validate("Unit of Measure Code", currJournal."Unit of Measure Code");
                            itemJlLine.Validate(Quantity, currJournal.Quantity);
                            //itemJlLine.validate("Location Code");
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