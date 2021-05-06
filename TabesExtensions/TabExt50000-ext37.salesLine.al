tableextension 50000 "Sales Line" extends "Sales Line"
{
    fields
    {
        // Add changes to table fields here
        field(50001; "Contract Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Degressive,Package,Local,"out of Local";
        }
        field(50002; "Contract No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50003; "Contract Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50004; Level; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(50007; "Zone No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Zone";
            ValidateTableRelation = false;
            trigger OnValidate()
            begin
                "Contract No." := '';
                "Contract Line No." := 0;
                UpdateUnitPrice(50007);
            end;
        }
        field(50008; "Delivery Date"; date)
        {
            DataClassification = ToBeClassified;
            trigger OnValidate()
            begin
                "Contract No." := '';
                "Contract Line No." := 0;
                UpdateUnitPrice(50008);
            end;
        }
        field(50012; "Ship-From Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("Sell-to Customer No."));
            trigger OnValidate()
            BEGIN
                validateShipingCodes();
            END;
        }
        field(50013; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("Sell-to Customer No."));
            trigger OnValidate()
            BEGIN
                validateShipingCodes();
            END;
        }
        //SA
        field(50020; KMDEP; Code[15])
        {
            DataClassification = ToBeClassified;

        }
        field(50021; KMARR; Code[15])
        {
            DataClassification = ToBeClassified;
        }
        field(50022; DIFF; Code[15])
        {
            DataClassification = ToBeClassified;

        }
        field(50023; kMREEL; Code[15])
        {
            DataClassification = ToBeClassified;

        }

        //SA

    }
    local procedure validateShipingCodes()
    begin
        if ("Ship-to Code" <> '') and ("Ship-From Code" <> '') and ("Ship-From Code" = "Ship-to Code") then
            Error('Ship-from and Ship-to must be different');
        validate("Zone No.", format("Ship-from Code", 10) + format("Ship-to Code", 10));
    end;
}