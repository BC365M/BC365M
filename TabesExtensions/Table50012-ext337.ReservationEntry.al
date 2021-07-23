tableextension 50012 reserventry extends 337
{
    procedure SetTrackingFilterFromItemJnlLine1(ItemJnlResLine: Record "Resource Follow Journal")
    begin
        SetRange("Serial No.", ItemJnlResLine."N° Serie");
        SetRange("Lot No.", ItemJnlResLine."Lot No.");
    end;


}