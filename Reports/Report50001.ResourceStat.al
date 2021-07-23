report 50001 "Resource Stat"
{
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Reports/Report50001.ResourceStat.rdl';
    dataset
    {
        dataitem(Resource; Resource)
        {
            RequestFilterFields = "No.", "Resource Group No.", "Date Filter";
            PrintOnlyIfDetail = true;
            column(No_; "No.") { }
            column(Name; Name) { }
            column(Sales__Cost_; "Sales (Cost)") { }
            column(Sales__Price_; "Sales (Price)") { }
            column(Total_Cost; "Total Cost") { }

            dataitem("Resource Following"; "Resource Following")
            {
                DataItemLink = "Resource No." = FIELD ("No.");
                DataItemTableView = sorting ("Resource No.");
                PrintOnlyIfDetail = true;
                column(followCode; code) { Caption = 'Code Suivi'; }
                column(followNo; "No.") { Caption = 'No'; }
                column(followDesc; description) { Caption = 'Designation'; }
                dataitem("Resource Ledger Entry"; "Resource Ledger Entry")
                {
                    DataItemLink = "Resource No." = FIELD ("Resource No."), "Code" = FIELD ("Code");
                    DataItemTableView = sorting ("posting Date");

                    column(Entry_No_; "Entry No.") { }
                    column(Posting_Date; format("Posting Date")) { }
                    column(Item_No_; "Item No.") { }
                    column(RLEDesc; description) { }
                    column(RLETotal_Cost; "Total Cost") { }
                    column(GASOIL_S_DIFF_KM; "%GASOIL_S/DIFF_KM")
                    {

                    }
                    trigger OnPreDataItem()
                    begin
                        if Resource.GetFilter("Date Filter") <> '' then
                            SetFilter("Posting Date", Resource.GetFilter("Date Filter"));
                    end;
                }
            }
        }
    }
    // requestpage
    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    var
        myInt: Integer;
}