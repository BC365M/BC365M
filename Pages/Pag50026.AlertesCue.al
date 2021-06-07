page 50026 "Maintenance Activities"
{
    Caption = 'Maintenance';
    PageType = CardPart;
    RefreshOnActivate = true;
    SourceTable = Integer;
    SourceTableTemporary = true;

    layout
    {
        area(content)
        {
            cuegroup("Resource")
            {
                Caption = 'Resource';
                CueGroupLayout = Wide;
                field(NbreVidange; NbreVidange)
                {
                    Caption = 'Vidange';
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    begin

                    end;
                }
                field(NbreVisite; NbreVisite)
                {
                    Caption = 'Visite technique';
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        res: Record Resource;
                    begin
                        res.Reset();
                        res.SetRange("Date Alerte V.Technique", 0D, Today);

                        page.Run(0, res);
                    end;
                }
                field(NbreAssurance; NbreAssurance)
                {
                    Caption = 'Assurance';
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        res: Record Resource;
                    begin
                        res.Reset();
                        res.SetRange("Date Alerte Assurance", 20000101D, Today);
                        page.Run(0, res);
                    end;
                }
            }
            cuegroup("Employee")
            {
                Caption = 'Chauffeur';
                CueGroupLayout = Wide;
                field(NbrePermis; NbrePermis)
                {
                    Caption = 'Permis';
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    begin

                    end;
                }
                field(NbreVisiteMed; NbreVisiteMed)
                {
                    Caption = 'Visite Médicale';
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        emp: Record Employee;
                    begin

                    end;
                }
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
    end;

    trigger OnAfterGetRecord()
    begin
        CalculateValues();
    end;

    trigger OnOpenPage()
    begin
        Reset;
        if not Get then begin
            Init;
            Insert;
        end;

    end;

    local procedure CalculateValues()
    var
        res: Record Resource;
        emp: Record Employee;
    begin
        res.Reset();
        res.SetRange("Date Alerte V.Technique", Today);
        NbreVisite := res.Count;


        res.Reset();
        res.SetRange("Date Alerte Assurance", 20000101D, Today);
        NbreAssurance := res.Count;

    end;

    var
        NbreVisite: Integer;
        NbreVidange: Integer;
        NbreAssurance: Integer;
        NbreVisiteMed: Integer;
        NbrePermis: Integer;
}
