codeunit 50000 "Contract Managment"

{

    trigger OnRun()
    begin

    end;

    procedure Release(var contract: Record "Contract Header")
    var
        lines: Record "Contract Line";
    begin
        if contract.Status <> contract.Status::Open then exit;
        contract.Status := contract.Status::Released;
        contract.Modify();
        Lines.SetRange("Contract Type", contract."Contract Type");
        Lines.SetRange("Contract No.", contract."No.");
        Lines.ModifyAll(Status, contract.Status);
    end;
    //Maintenance Release
    procedure Release1(var Maintenance: Record "Maintenance Header")
    var
        Lines: Record "Ligne Flotte & Maintenance";
    begin
        if Maintenance.statut <> Maintenance.statut::Open then exit;
        Maintenance.statut := Maintenance.statut::Encours;
        Maintenance.Modify();
        Lines.SetRange(No_Maintenance, Maintenance.No_Maintenance);
        Lines.ModifyAll(statut, Maintenance.statut);

    end;

    procedure Open1(var Maintenance: Record "Maintenance Header")
    var
        Lines: Record "Ligne Flotte & Maintenance";
    begin
        if Maintenance.statut <> Maintenance.statut::Encours then exit;
        Maintenance.statut := Maintenance.statut::Open;
        Maintenance.Modify();
        Lines.SetRange(No_Maintenance, Maintenance.No_Maintenance);
        Lines.ModifyAll(statut, Maintenance.statut);

    end;
    //Maintenance Release

    procedure Open(var contract: Record "Contract Header")
    var
        lines: Record "Contract Line";
    begin
        if contract.Status <> contract.Status::Released then exit;
        contract.Status := contract.Status::Open;
        contract.Modify();
        Lines.SetRange("Contract Type", contract."Contract Type");
        Lines.SetRange("Contract No.", contract."No.");
        Lines.ModifyAll(Status, contract.Status);
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnAfterAssignResourceValues', '', true, true)]
    local procedure OnAfterAssignResourceValues(Resource: Record Resource; var SalesLine: Record "Sales Line")
    begin
        SalesLine."Resource Group No." := Resource."Resource Group No.";
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnValidateNoOnBeforeInitRec', '', true, true)]
    local procedure OnValidateNoOnBeforeInitRec(var SalesLine: Record "Sales Line")
    begin
        SalesLine."Resource Group No." := '';
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptLineInsert', '', true, true)]
    local procedure OnBeforeSalesShptLineInsert(var SalesShptLine: Record "Sales Shipment Line")
    begin
        if (SalesShptLine."Contract Type" <> "Document Contract Type"::" ") and (SalesShptLine.Quantity <> 0) then
            SalesShptLine.TestField("Transport Shipment No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostSalesDoc', '', true, true)]
    local procedure OnBeforePostSalesDoc(var SalesHeader: Record "Sales Header")
    begin
        // if (SalesHeader."Document Type" = SalesHeader."Document Type"::Order) and (SalesHeader."Contract Type" <> "Document Contract Type"::" ") then
        //     SalesHeader.TestField("External Document No.");
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Get Shipment", 'OnRunAfterFilterSalesShpLine', '', true, true)]
    local procedure OnRunAfterFilterSalesShpLine(SalesHeader: Record "Sales Header"; var SalesShptLine: Record "Sales Shipment Line")
    begin
        SalesShptLine.SetRange("Contract Type", SalesHeader."Contract Type");
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Shipment Line", 'OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine', '', true, true)]
    local procedure OnBeforeInsertInvLineFromShptLineBeforeInsertTextLine(var SalesShptLine: Record "Sales Shipment Line"; var SalesLine: Record "Sales Line")
    var
        InvHeader: Record "Sales Header";
    begin
        InvHeader.Get(SalesLine."Document Type", SalesLine."Document No.");
        if (InvHeader."Contract Type" = "Document Contract Type"::" ") AND (SalesShptLine."Contract Type" <> "Document Contract Type"::" ") then begin
            InvHeader."Contract Type" := SalesShptLine."Contract Type";
            InvHeader.Modify();
        end;
        if (InvHeader."Contract Type" <> SalesShptLine."Contract Type") then
            Error('The Contract Type must be the same');
        SalesLine."Contract Type" := SalesShptLine."Contract Type";
        SalesLine."Contract No." := SalesShptLine."Contract No.";
        SalesLine."Contract Line No." := SalesShptLine."Contract Line No.";
        SalesLine.Level := SalesShptLine.Level;
        SalesLine."Delivery Date" := SalesShptLine."Delivery Date";
    end;

    [EventSubscriber(ObjectType::Table, database::"Item Journal Line", 'OnAfterCopyItemJnlLineFromSalesLine', '', true, true)]
    local procedure OnAfterCopyItemJnlLineFromSalesLine(SalesLine: Record "Sales Line"; var ItemJnlLine: Record "Item Journal Line")
    begin
        ItemJnlLine."Contract Type" := SalesLine."Contract Type";
        ItemJnlLine."Contract No." := SalesLine."Contract No.";
        ItemJnlLine."Contract Line No." := SalesLine."Contract Line No.";
        ItemJnlLine."Contract Level" := SalesLine.Level;
        ItemJnlLine."Delivery Date" := SalesLine."Delivery Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', true, true)]
    local procedure OnBeforeInsertItemLedgEntry(ItemJournalLine: Record "Item Journal Line"; var ItemLedgerEntry: Record "Item Ledger Entry")
    begin
        ItemLedgerEntry."Contract Type" := ItemJournalLine."Contract Type";
        ItemLedgerEntry."Contract No." := ItemJournalLine."Contract No.";
        ItemLedgerEntry."Contract Line No." := ItemJournalLine."Contract Line No.";
        ItemLedgerEntry.Level := ItemJournalLine."Contract Level";
        ItemLedgerEntry."Delivery Date" := ItemJournalLine."Delivery Date";
    end;

    [EventSubscriber(ObjectType::Codeunit, 700, 'OnConditionalCardPageIDNotFound', '', true, true)]
    local procedure OnConditionalCardPageIDNotFound(RecordRef: RecordRef; var CardPageID: Integer);
    var
        contract: Record "Contract Header";
    begin
        RecordRef.SETTABLE(Contract);
        case contract."Contract Type" of
            contract."Contract Type"::Degressive:
                CardPageID := page::"Degressive Contract";
            contract."Contract Type"::"out of Local":
                CardPageID := page::"Out Of Local Contract";
            contract."Contract Type"::Package:
                CardPageID := page::"Package Contract";
            contract."Contract Type"::"Local":
                CardPageID := page::"Local Contract";
        end;
    end;

    [EventSubscriber(ObjectType::Table, database::"Sales Line", 'OnBeforeValidateEvent', 'Quantity', true, true)]
    local procedure OnBeforeValidateEventQuantity(var Rec: Record "Sales Line"; var xRec: Record "Sales Line"; CurrFieldNo: Integer)
    var
        salesHeader: Record "Sales Header";
        CalledByFieldNo: Integer;
        IsHandled: Boolean;
    begin
        if (Rec."Document Type" = rec."Document Type"::Order) AND (Rec.Quantity <> xRec.Quantity) AND (Rec.Type = Rec.Type::Resource) AND (Rec."No." <> '') then begin
            salesHeader.Get(Rec."Document Type", Rec."Document No.");
            CalcSalesLinePrice(Rec, SalesHeader, CalledByFieldNo, IsHandled);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, 7000, 'OnBeforeFindSalesLinePrice', '', true, true)]
    local procedure OnBeforeFindSalesLinePrice(VAR SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CalledByFieldNo: Integer; VAR IsHandled: Boolean)
    begin
        CalcSalesLinePrice(SalesLine, SalesHeader, CalledByFieldNo, IsHandled);
    end;

    local procedure CalcSalesLinePrice(VAR SalesLine: Record "Sales Line"; SalesHeader: Record "Sales Header"; CalledByFieldNo: Integer; VAR IsHandled: Boolean)
    var
        ContractPriceLine: Record "Contract Line";
        ContractPriceLineSlices: Record "Contract Line Slices";
        OtherSalesLines: Record "Sales Line";
        levelInt: Integer;
        OrderSumQty: Decimal;
        ContSumQty: Decimal;
        CurrSumQty: Decimal;
        RemainedQty: Decimal;
        lineFound: Boolean;
    begin
        WITH SalesLine DO BEGIN
            IF ("Document Type" = "Document Type"::Order) AND ("Delivery Date" <> 0D) AND ("Zone No." <> '') AND (SalesHeader."Contract Type" <> SalesHeader."Contract Type"::" ") THEN BEGIN //AND ("Contract No." = '')
                case SalesHeader."Contract Type" of
                    SalesHeader."Contract Type"::Degressive:
                        begin
                            contractPriceLine.SetRange("Contract Type", ContractPriceLine."Contract Type"::Degressive);
                            ContractPriceLine.SETRANGE("Zone No.", "Zone No.");
                        end;
                    SalesHeader."Contract Type"::Local:
                        begin
                            ContractPriceLine.SETRANGE("Zone No.", "Zone No.");
                            contractPriceLine.SetRange("Contract Type", ContractPriceLine."Contract Type"::Local);
                        end;
                    SalesHeader."Contract Type"::"out of Local":
                        contractPriceLine.SetRange("Contract Type", ContractPriceLine."Contract Type"::"out of Local");
                    SalesHeader."Contract Type"::Package:
                        begin
                            ContractPriceLine.SETRANGE("Zone No.", "Zone No.");
                            contractPriceLine.SetRange("Contract Type", ContractPriceLine."Contract Type"::Package);
                        end;
                end;
                ContractPriceLine.SETRANGE("Customer No.", SalesHeader."Sell-to Customer No.");
                ContractPriceLine.SETRANGE(Status, ContractPriceLine.Status::Released);
                ContractPriceLine.SetRange(Type, Type);
                //ContractPriceLine.SetRange("No.", "No.");
                ContractPriceLine.SetRange("Resource Group No.", "Resource Group No.");
                ContractPriceLine.SETRANGE("Starting Date", 0D, "Delivery Date");
                ContractPriceLine.SETRANGE("Ending Date", "Delivery Date", 99991231D);
                ContractPriceLine.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                IF ContractPriceLine.FINDFIRST THEN BEGIN
                    CASE ContractPriceLine."Contract Type" OF
                        ContractPriceLine."Contract Type"::Degressive:
                            BEGIN
                                ContractPriceLineSlices.SetRange("Contract Type", ContractPriceLine."Contract Type");
                                ContractPriceLineSlices.SetRange("Contract No.", ContractPriceLine."Contract No.");
                                ContractPriceLineSlices.SetRange("Contract Line No.", ContractPriceLine."Line No.");
                                ContractPriceLineSlices.CalcSums(Quantity);
                                ContSumQty := ContractPriceLineSlices.Quantity;
                                if ContSumQty <= 0 then Error('Error in contract definition');

                                OtherSalesLines.SETRANGE("Document Type", "Document Type");
                                OtherSalesLines.SETRANGE("Document No.", "Document No.");
                                OtherSalesLines.SETRANGE(Type, Type);
                                //OtherSalesLines.SETRANGE("No.", "No.");
                                OtherSalesLines.SetRange("Resource Group No.", "Resource Group No.");
                                OtherSalesLines.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                OtherSalesLines.SETRANGE("Zone No.", "Zone No.");
                                OtherSalesLines.SETRANGE("Delivery Date", "Delivery Date");
                                OtherSalesLines.SETFILTER("Line No.", STRSUBSTNO('<>%1', "Line No."));
                                OtherSalesLines.CalcSums("Outstanding Quantity");
                                OrderSumQty := OtherSalesLines."Outstanding Quantity";
                                OrderSumQty += Quantity;

                                Linefound := false;
                                ContractPriceLineSlices.FindFirst();
                                CurrSumQty := 0;
                                repeat
                                    CurrSumQty += ContractPriceLineSlices.Quantity;
                                    if CurrSumQty >= OrderSumQty then
                                        lineFound := true
                                    else
                                        lineFound := (ContractPriceLineSlices.Next() = 0)
                                until Linefound;


                                "Unit Price" := ContractPriceLine."Unit Price" - ContractPriceLineSlices."Discount Amount";
                                Level := ContractPriceLineSlices.Level;

                                "Contract Type" := "Document Contract Type"::Degressive;
                                "Contract No." := ContractPriceLine."Contract No.";
                                "Contract Line No." := ContractPriceLine."Line No.";
                                IsHandled := TRUE;
                            END;
                        ContractPriceLine."Contract Type"::"out of Local":
                            BEGIN
                                ContractPriceLine.SetRange("Date Filter", CalcDate('<-CM>', "Delivery Date"), CalcDate('<CM>', "Delivery Date"));
                                ContractPriceLine.CalcFields("Qty. Shipped");
                                //Message('%1', ContractPriceLine."Qty. Shipped");
                                OtherSalesLines.SETRANGE("Document Type", "Document Type");
                                OtherSalesLines.SETRANGE("Document No.", "Document No.");
                                OtherSalesLines.SETRANGE(Type, Type);
                                //OtherSalesLines.SETRANGE("No.", "No.");
                                OtherSalesLines.SetRange("Resource Group No.", "Resource Group No.");
                                OtherSalesLines.SETRANGE("Unit of Measure Code", "Unit of Measure Code");
                                //OtherSalesLines.SETRANGE("Zone No.", "Zone No.");
                                OtherSalesLines.SETRANGE("Delivery Date", CalcDate('<-CM>', "Delivery Date"), CalcDate('<CM>', "Delivery Date"));
                                OtherSalesLines.SETFILTER("Line No.", STRSUBSTNO('<>%1', "Line No."));
                                OtherSalesLines.CalcSums("Outstanding Quantity");
                                OrderSumQty := OtherSalesLines."Outstanding Quantity";
                                OrderSumQty += ContractPriceLine."Qty. Shipped";
                                //OrderSumQty += Quantity;

                                ContractPriceLineSlices.SetRange("Contract Type", ContractPriceLine."Contract Type");
                                ContractPriceLineSlices.SetRange("Contract No.", ContractPriceLine."Contract No.");
                                ContractPriceLineSlices.SetRange("Contract Line No.", ContractPriceLine."Line No.");

                                Linefound := false;
                                ContractPriceLineSlices.FindFirst();
                                RemainedQty := 0;
                                repeat
                                    if OrderSumQty < ContractPriceLineSlices.Quantity then begin
                                        lineFound := true;
                                        RemainedQty := ContractPriceLineSlices.Quantity - OrderSumQty;
                                    end else begin
                                        OrderSumQty -= ContractPriceLineSlices.Quantity;
                                        lineFound := (ContractPriceLineSlices.Next() = 0);
                                    end;
                                until Linefound;
                                if (RemainedQty > 0) AND (RemainedQty < Quantity) then
                                    Error('Quantity must be splitted %1', RemainedQty);

                                //if (ContractPriceLineSlices.Quantity = 0) and (OrderSumQty > 0) then
                                "Unit Price" := ContractPriceLineSlices."Unit Price";

                                Level := ContractPriceLineSlices.Level;

                                "Contract Type" := "Document Contract Type"::"out of Local";
                                "Contract No." := ContractPriceLine."Contract No.";
                                "Contract Line No." := ContractPriceLine."Line No.";
                                IsHandled := TRUE;
                            END;
                        ContractPriceLine."Contract Type"::Local:
                            begin
                                "Contract Type" := "Document Contract Type"::Local;
                                "Contract No." := ContractPriceLine."Contract No.";
                                "Contract Line No." := ContractPriceLine."Line No.";
                                "Unit Price" := ContractPriceLine."Unit Price";
                                IsHandled := TRUE;
                            end;
                        ContractPriceLine."Contract Type"::Package:
                            begin
                                "Contract Type" := "Document Contract Type"::Package;
                                "Contract No." := ContractPriceLine."Contract No.";
                                "Contract Line No." := ContractPriceLine."Line No.";
                                "Unit Price" := ContractPriceLine."Unit Price";
                                IsHandled := TRUE;
                            end;
                    END;
                END;
            END;
        END;
    end;
}