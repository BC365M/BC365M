tableextension 50013 TrackingSpecification extends 336
{
    fields
    {
        // Add changes to table fields here
        // SA JNL SerialLine SerialN° managment
    }

    var
        myInt: Integer;
        // SA JNL SerialLine SerialN° managment
    procedure InitFromItemJnlLine1(ItemJnlResLine: Record "Resource Follow Journal")
    begin
        Init();
        SetItemData1(ItemJnlResLine."Item No.", ItemJnlResLine.Description, ItemJnlResLine."Location Code");

        SetQuantities1(ItemJnlResLine."Quantity (Base)", ItemJnlResLine.Quantity, ItemJnlResLine."Quantity (Base)", ItemJnlResLine.Quantity,
  ItemJnlResLine."Quantity (Base)", 0, 0);

    end;

    procedure SetItemData1(ItemNo: Code[20]; ItemDescription: Text[100]; LocationCode: Code[10])
    begin
        "Item No." := ItemNo;
        Description := ItemDescription;
        "Location Code" := LocationCode;
    end;

    procedure SetQuantities1(QtyBase: Decimal; QtyToHandle: Decimal; QtyToHandleBase: Decimal; QtyToInvoice: Decimal; QtyToInvoiceBase: Decimal; QtyHandledBase: Decimal; QtyInvoicedBase: Decimal)
    begin
        "Quantity (Base)" := QtyBase;
        "Qty. to Handle" := QtyToHandle;
        "Qty. to Handle (Base)" := QtyToHandleBase;
        "Qty. to Invoice" := QtyToInvoice;
        "Qty. to Invoice (Base)" := QtyToInvoiceBase;
        "Quantity Handled (Base)" := QtyHandledBase;
        "Quantity Invoiced (Base)" := QtyInvoicedBase;
    end;

    procedure SetSource1(SourceType: Integer; SourceSubtype: Integer; SourceID: Code[20]; SourceRefNo: Integer)
    begin
        "Source Type" := SourceType;
        "Source Subtype" := SourceSubtype;
        "Source ID" := SourceID;
        "Source Ref. No." := SourceRefNo;
    end;

    // SA JNL SerialLine SerialN° managment
}