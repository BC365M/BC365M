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
                    var
                        res: Record Resource;
                    begin
                        res.Reset();
                        res.SetRange("Prochaine Vidange");
                        page.Run(0, res);
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
                        res.SetRange("Date Alerte V.Technique", 20000101D, Today);

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
                    var
                        emp: Record Employee;
                    begin
                        emp.Reset();
                        emp.SetRange("Date Alerte Permi", 20000101D, Today);
                        page.Run(0, emp);
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
                        emp.Reset();
                        emp.SetRange("Date Alerte V.Medical", 20000101D, Today);
                        page.Run(0, emp);

                    end;
                }
                field(NbrCartProf; NbrCartProf)
                {
                    Caption = 'Echeance Carte profesional';
                    ApplicationArea = Basic, Suite;
                    trigger OnDrillDown()
                    var
                        emp: Record Employee;
                    begin
                        emp.Reset();
                        emp.SetRange("Date Alerte Carte Prof", 20000101D, Today);
                        page.Run(0, emp);

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
        res.SetRange("Date Alerte V.Technique", 20000101D, Today);
        NbreVisite := res.Count;


        res.Reset();
        res.SetRange("Date Alerte Assurance", 20000101D, Today);
        NbreAssurance := res.Count;

        res.Reset();
        res.SetRange("Prochaine Vidange");
        NbreVidange := res.Count;

        emp.Reset();
        emp.SetRange("Date Alerte Carte Prof", 20000101D, Today);
        NbrCartProf := emp.count;

        emp.Reset();
        emp.SetRange("Date Alerte permi", 20000101D, Today);
        NbrCartProf := emp.count;

        emp.Reset();
        emp.SetRange("Date Alerte V.Medical", 20000101D, Today);
        NbrCartProf := emp.count;




    end;

    var
        NbreVisite: Integer;
        NbreVidange: Integer;
        NbreAssurance: Integer;
        NbreVisiteMed: Integer;
        NbrePermis: Integer;
        NbrCartProf: Integer;
}
