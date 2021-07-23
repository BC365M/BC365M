page 50036 "Resource Following Card"
{
    PageType = Card;
    SourceTable = "Resource Following";
    Caption = 'Ressource Suivi';

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Resource No."; "Resource No.")
                {
                    ApplicationArea = All;
                }
                field(Code; Code)
                {
                    ApplicationArea = All;
                }
                field("No. AsP"; "No. As")
                {
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field(Type; Type)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    begin
                        setGrVisibility();
                    end;
                }
                field(Blocked; Blocked)
                {
                    ApplicationArea = All;
                }
                field("Total Mileage"; "Total Mileage")
                {
                    ApplicationArea = All;
                }
                field("Total Cost"; "Total Cost")
                {
                    ApplicationArea = All;
                }
            }
            group(grDuration)
            {
                // ShowCaption = false;
                Caption = 'Duration';
                Visible = durationVisible;
                field(Formula; Formula)
                {
                    ApplicationArea = All;
                }
                field("Last Date Replacement"; "Last Date Replacement")
                {
                    ApplicationArea = All;
                }
                field("Next Date Replacement"; "Next Date Replacement")
                {
                    ApplicationArea = All;
                }
                field("Notify Date Before"; "Notify Date Before")
                {
                    ApplicationArea = All;
                }
                field("Notify Date Replacement"; "Notify Date Replacement")
                {
                    ApplicationArea = All;
                }
            }
            group(grMileage)
            {
                //ShowCaption = false;
                Caption = 'Mileage';
                Visible = mileageVisible;
                field("Replace Every"; "Replace Every")
                {
                    ApplicationArea = All;
                }
                field("Last Mileage Replacement"; "Last Mileage Replacement")
                {
                    ApplicationArea = All;
                }
                field("Next Mileage Replacement"; "Next Mileage Replacement")
                {
                    ApplicationArea = All;
                }
                field("Notify Mileage Before"; "Notify Mileage Before")
                {
                    ApplicationArea = All;
                }
                field("Notify Mileage Replacement"; "Notify Mileage Replacement")
                {
                    ApplicationArea = All;
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
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        setGrVisibility();
    end;

    local procedure setGrVisibility()
    var
        myInt: Integer;
    begin
        durationVisible := (Type in [Type::Duration, Type::"Mileage/Duration"]);
        mileageVisible := (Type in [Type::Mileage, Type::"Mileage/Duration"]);
    end;

    var
        myInt: Integer;
        mileageVisible: Boolean;
        durationVisible: Boolean;

}