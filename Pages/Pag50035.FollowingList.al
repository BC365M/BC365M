page 50035 "Following List"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = Following;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Following Type"; "Following Type")
                {
                    ApplicationArea = All;
                }
                field("Mileage Tracking"; "Mileage Tracking")
                {
                    ApplicationArea = All;
                }
                field(Notify; Notify)
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}

page 50038 "Following Notification"
{
    PageType = ListPart;
    SourceTable = Following;
    SourceTableView = where (Notify = const (true));
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {
                field(code; code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Following Count"; "Following Count")
                {
                    ApplicationArea = All;
                }
                field("Mileage Notify"; "Mileage Notify Count")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        FollwRecords: Record "Resource Following";
                    begin
                        FollwRecords.MarkedOnly(false);
                        FollwRecords.SetRange(Blocked, false);
                        FollwRecords.SetRange(code, code);
                        if FollwRecords.FindFirst() then
                            repeat
                                FollwRecords.CalcFields("Total Mileage");
                                if (FollwRecords."Total Mileage" >= FollwRecords."Notify Mileage Replacement") and (FollwRecords."Notify Mileage Replacement" > 0) then
                                    FollwRecords.Mark(true);
                            until FollwRecords.Next() = 0;
                        FollwRecords.SetRange(code);
                        FollwRecords.SetRange(Blocked);
                        FollwRecords.MarkedOnly(true);
                        page.RunModal(0, FollwRecords);
                    end;
                }
                field("Duration Notify"; "Duration Notify Count")
                {
                    ApplicationArea = All;
                    BlankZero = true;
                    Editable = false;

                    trigger OnDrillDown()
                    var
                        FollwRecords: Record "Resource Following";
                    begin
                        FollwRecords.MarkedOnly(false);
                        FollwRecords.SetRange(code, code);
                        FollwRecords.SetRange(Blocked, false);
                        if FollwRecords.FindFirst() then
                            repeat
                                if (FollwRecords."Notify Date Replacement" <> 0D) and (FollwRecords."Notify Date Replacement" <= Today) then
                                    FollwRecords.Mark(true);
                            until FollwRecords.Next() = 0;
                        FollwRecords.SetRange(code);
                        FollwRecords.SetRange(Blocked);
                        FollwRecords.MarkedOnly(true);
                        page.RunModal(0, FollwRecords);
                    end;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(Journal)
            {
                ApplicationArea = All;
                Image = Journal;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = page "Resource Follow Journal";
            }
            action("Resource Stat")
            {
                ApplicationArea = All;
                Image = Report;
                Promoted = true;
                PromotedIsBig = true;
                RunObject = Report "Resource Stat";
            }
        }
    }

    trigger OnAfterGetRecord()
    var
        FollwRecords: Record "Resource Following";
    begin
        "Duration Notify Count" := 0;
        "Mileage Notify Count" := 0;
        FollwRecords.SetRange(Blocked, false);
        FollwRecords.SetRange(code, code);
        if FollwRecords.FindFirst() then
            repeat
                FollwRecords.CalcFields("Total Mileage");
                if (FollwRecords."Total Mileage" >= FollwRecords."Notify Mileage Replacement") AND (FollwRecords."Notify Mileage Replacement" > 0) then
                    "Mileage Notify Count" += 1;
                if (FollwRecords."Notify Date Replacement" <> 0D) and (FollwRecords."Notify Date Replacement" <= Today) then
                    "Duration Notify Count" += 1;
            until FollwRecords.Next() = 0;
    end;

    var
        [InDataSet]
        "Mileage Notify Count": Integer;
        [InDataSet]
        "Duration Notify Count": Integer;


}