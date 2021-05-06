report 50000 "Contract Copy"
{
    UsageCategory = Administration;
    ApplicationArea = All;
    ProcessingOnly = true;

    dataset
    {

    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(GroupName)
                {
                    field(FromContractType; FromContractType)
                    {
                        ApplicationArea = All;

                    }
                    field(FromContractNo; FromContractNo)
                    {
                        ApplicationArea = All;
                        trigger OnLookup(var Text: Text): Boolean
                        var
                            contract: Record "Contract Header";
                        begin
                            contract.SetRange("Contract Type", FromContractType);
                            if page.RunModal(0, contract) = Action::LookupOK then begin
                                FromContractNo := contract."No.";
                            end;
                        end;

                    }
                    field(ToContractType; ToContractType)
                    {
                        ApplicationArea = All;

                    }
                    field(ToContractNo; ToContractNo)
                    {
                        ApplicationArea = All;

                    }

                }
            }
        }

        actions
        {
            area(processing)
            {
                action(ActionName)
                {
                    ApplicationArea = All;

                }
            }
        }
    }

    trigger OnPostReport()
    var
        fromContract: Record "Contract Header";
        fromContractLine: Record "Contract Line";
        fromContractSlice: Record "Contract Line Slices";
        toContract: Record "Contract Header";
        toContractLine: Record "Contract Line";
        toContractSlice: Record "Contract Line Slices";
    begin
        fromContract.SetRange("Contract Type", FromContractType);
        fromContract.SetRange("No.", FromContractNo);
        if fromContract.FindFirst() then begin
            toContract.Init();
            toContract.TransferFields(fromContract);
            toContract."Contract Type" := ToContractType;
            toContract."No." := ToContractNo;
            toContract.Insert(true);
            fromContractLine.SetRange("Contract Type", fromContract."Contract Type");
            fromContractLine.SetRange("Contract No.", fromContract."No.");
            if fromContractLine.FindFirst() then
                repeat
                    toContractLine.Init();
                    toContractLine.TransferFields(fromContractLine);
                    toContractLine."Contract Type" := ToContractType;
                    toContractLine."Contract No." := ToContractNo;
                    toContractLine.Insert(true);
                until fromContractLine.Next() = 0;

            fromContractSlice.SetRange("Contract Type", fromContract."Contract Type");
            fromContractSlice.SetRange("Contract No.", fromContract."No.");
            if fromContractSlice.FindFirst() then
                repeat
                    toContractSlice.Init();
                    toContractSlice.TransferFields(fromContractSlice);
                    toContractSlice."Contract Type" := ToContractType;
                    toContractSlice."Contract No." := ToContractNo;
                    toContractSlice.Insert(true);
                until fromContractSlice.Next() = 0;
        end;
    end;

    var
        FromContractType: Option Degressive,Package,Local,"out of Local";
        ToContractType: Option Degressive,Package,Local,"out of Local";
        FromContractNo: Code[20];
        ToContractNo: Code[20];

}