table 50001 "Contract Line"
{
    DataClassification = ToBeClassified;
    fields
    {
        field(1; "Contract Type"; Enum "Contract Type")
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Contract No."; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Customer No."; code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Customer;
        }
        field(5; Type; option)
        {
            Caption = 'Type';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
            trigger OnValidate()
            begin
                if Type <> xRec.Type then begin
                    updateLine();
                end;
            end;
        }
        field(6; "No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = IF (Type = CONST (" ")) "Standard Text"
            ELSE
            IF (Type = CONST ("G/L Account")) "G/L Account" WHERE ("Direct Posting" = CONST (true), "Account Type" = CONST (Posting), Blocked = CONST (false))
            ELSE
            IF (Type = CONST (Resource)) Resource
            ELSE
            IF (Type = CONST ("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST ("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST (Item)) Item WHERE (Blocked = CONST (false));
            ValidateTableRelation = false;
        }
        field(7; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            TableRelation = IF (Type = CONST (Item),
                                "No." = FILTER (<> '')) "Item Unit of Measure".Code WHERE ("Item No." = FIELD ("No."))
            ELSE
            IF (Type = CONST (Resource),
                                         "No." = FILTER (<> '')) "Resource Unit of Measure".Code WHERE ("Resource No." = FIELD ("No."))
            ELSE
            "Unit of Measure";
        }
        field(9; "Zone No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Service Zone";
            ValidateTableRelation = false;
        }
        field(10; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Open,Released,Archived;
        }
        field(11; "Starting Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Ending Date"; date)
        {
            DataClassification = ToBeClassified;
        }
        field(14; Quantity; Decimal)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(15; Level; Integer)
        {
            DataClassification = ToBeClassified;
            BlankZero = true;
        }
        field(20; "Unit Price"; Decimal)
        {
            BlankZero = true;
            AutoFormatType = 2;
            AutoFormatExpression = "Currency Code";
        }
        field(21; "Discount Amount"; Decimal)
        {
            BlankZero = true;
            AutoFormatType = 2;
            AutoFormatExpression = "Currency Code";
        }
        field(32; "Ship-From Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("Customer No."));
            trigger OnValidate()
            BEGIN
                validateShipingCodes();
            END;
        }
        field(33; "Ship-to Code"; Code[10])
        {
            TableRelation = "Ship-to Address".Code WHERE ("Customer No." = FIELD ("Customer No."));
            trigger OnValidate()
            BEGIN
                validateShipingCodes();
            END;
        }
        field(91; "Currency Code"; Code[10])
        {
            Editable = false;
            TableRelation = Currency;
        }
        field(100; "Details Count"; Integer)
        {
            Editable = false;
            BlankZero = true;
            FieldClass = FlowField;
            CalcFormula = count ("Contract Line Slices" where ("Contract No." = field ("Contract No."),
                                                                "Contract Type" = field ("Contract Type"),
                                                                "Contract Line No." = field ("Line No.")));
        }
        field(200; "Date Filter"; Date)
        {
            FieldClass = FlowFilter;
        }
        field(201; "Shipped Qty"; Decimal)
        {
            FieldClass = Flowfield;
            Editable = false;
            BlankZero = true;
            CalcFormula = - Sum ("Item Ledger Entry".Quantity WHERE ("Item No." = FIELD ("No."),
                                                                        //"Posting Date" = FIELD ("Date Filter"),
                                                                        "Delivery Date" = FIELD ("Date Filter"),
                                                                        "Contract Type" = field ("Contract Type"),
                                                                        "Contract No." = field ("Contract No."),
                                                                        "Contract Line No." = field ("Line No.")));
        }
        field(202; "Qty. Shipped"; Decimal)
        {
            FieldClass = Flowfield;
            Editable = false;
            BlankZero = true;
            CalcFormula = Sum ("Sales Shipment Line".Quantity WHERE (Type = field (Type),
                                                                        "No." = FIELD ("No."),
                                                                        //"Posting Date" = FIELD ("Date Filter"),
                                                                        "Delivery Date" = FIELD ("Date Filter"),
                                                                        "Contract Type" = field ("Contract Type"),
                                                                        "Contract No." = field ("Contract No."),
                                                                        "Contract Line No." = field ("Line No.")));
        }
        field(203; "Qty. Invoiced"; Decimal)
        {
            FieldClass = Flowfield;
            Editable = false;
            BlankZero = true;
            CalcFormula = Sum ("Sales Invoice Line".Quantity WHERE (Type = field (Type),
                                                                        "No." = FIELD ("No."),
                                                                        //"Posting Date" = FIELD ("Date Filter"),
                                                                        "Delivery Date" = FIELD ("Date Filter"),
                                                                        "Contract Type" = field ("Contract Type"),
                                                                        "Contract No." = field ("Contract No."),
                                                                        "Contract Line No." = field ("Line No.")));
        }
    }

    keys
    {
        key(PK; "Contract Type", "Contract No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    var
        Slices: Record "Contract Line Slices";
    begin
        TestField(Status, Status::Open);
        Slices.SetRange("Contract Type", "Contract Type");
        Slices.SetRange("Contract No.", "Contract No.");
        Slices.SetRange("Contract Line No.", "Line No.");
        Slices.DeleteAll(true);
    end;

    trigger OnRename()
    begin

    end;

    local procedure updateLine();
    var
        contractHeader: Record "Contract Header";
    begin
        contractHeader.Get("Contract Type", "Contract No.");
        "Currency Code" := contractHeader."Currency Code";
        "Starting Date" := contractHeader."Starting Date";
        "Ending Date" := contractHeader."Ending Date";
        "Customer No." := contractHeader."Customer No.";
        Status := contractHeader.Status;
    end;

    local procedure validateShipingCodes()
    begin
        if ("Ship-to Code" <> '') and ("Ship-From Code" <> '') and ("Ship-From Code" = "Ship-to Code") then
            Error('Ship-from and Ship-to must be different');
        validate("Zone No.", format("Ship-from Code", 10) + format("Ship-to Code", 10));
    end;

}