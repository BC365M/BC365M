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
            column(No_; "No.") { }
            column(Name; Name) { }
            column(Sales__Cost_; "Sales (Cost)") { }
            column(Sales__Price_; "Sales (Price)") { }
            column(Total_Cost; "Total Cost") { }
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