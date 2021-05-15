codeunit 50001 "Montant Toute Lettre - Mgt"
{
    // Meg01.00 CM (17-08-12): new codeunit.(ALINT-000014)
    // Meg02.00 RZ (02-08-18): BF for existing and new currencies.(ALPTY-000033)


    trigger OnRun()
    begin
    end;

    var
        million: Text[250];
        mille: Text[250];
        cent: Text[250];
        entiere: Integer;
        decimal: Integer;
        nbre: Integer;
        nbre1: Integer;
        j: Integer;
        "Chèque": Report Check;
        chaine1: Text[30];
        VarDeviseEntiere: Text[30];
        VarDeviseDecimal: Text[30];
        GCurrencyCode: Code[20];

    [Scope('Internal')]
    procedure "Montant en texte"(var strprix: Text[250]; prix: Decimal)
    var
        RecLGLSetup: Record "General Ledger Setup";
        GCurrencyCodeTxt: Text;
    begin

        RecLGLSetup.Get;

        entiere := Round(prix, 1, '<');
        decimal := Round((prix - entiere) * 100, 1, '=');
        nbre := entiere;
        million := '';
        mille := '';
        cent := '';
        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;
        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        //>> DELTA AK
        if GCurrencyCode <> '' then begin
            if entiere > 1 then
                strprix := strprix + ' ' + GCurrencyCode;
            if entiere = 1 then
                strprix := strprix + ' ' + GCurrencyCode;
        end else begin
            if entiere > 1 then
                strprix := strprix + ' ' + RecLGLSetup."LCY Code";
            if entiere = 1 then
                strprix := strprix + ' ' + RecLGLSetup."LCY Code";
        end;
        //<< DELTA AK

        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if GCurrencyCode <> '' then begin
                GCurrencyCodeTxt := Format(GCurrencyCode);
                QuelleDevise(GCurrencyCodeTxt, 0)
            end else begin
                GCurrencyCodeTxt := Format(RecLGLSetup."LCY Code");
                QuelleDevise(GCurrencyCodeTxt, 0);
            end;
            if decimal = 1 then
                strprix := strprix + ' ' + VarDeviseDecimal//RecLGLSetup."LCY decimal desc."
            else
                strprix := strprix + ' ' + VarDeviseDecimal//RecLGLSetup."LCY decimal desc.";
        end;

        strprix := UpperCase(strprix);
    end;

    [Scope('Internal')]
    procedure Centaine(var chaine: Text[250]; i: Integer)
    var
        k: Integer;
    begin
        k := i div 100;
        chaine := '';
        case k of
            1:
                chaine := 'cent';
            2:
                chaine := 'deux cent';
            3:
                chaine := 'trois cent';
            4:
                chaine := 'quatre cent';
            5:
                chaine := 'cinq cent';
            6:
                chaine := 'six cent';
            7:
                chaine := 'sept cent';
            8:
                chaine := 'huit cent';
            9:
                chaine := 'neuf cent';
        end;
        k := i mod 100;
        Dizaine(chaine, k);
    end;

    [Scope('Internal')]
    procedure Dizaine(var chaine: Text[250]; i: Integer)
    var
        k: Integer;
        l: Integer;
    begin
        if i > 16 then begin
            k := i div 10;
            chaine1 := '';
            case k of
                1:
                    chaine1 := 'dix';
                2:
                    chaine1 := 'vingt';
                3:
                    chaine1 := 'trente';
                4:
                    chaine1 := 'quarante';
                5:
                    chaine1 := 'cinquante';
                6:
                    chaine1 := 'soixante';
                7:
                    chaine1 := 'soixante';
                8:
                    chaine1 := 'quatre vingt';
                9:
                    chaine1 := 'quatre vingt';
            end;
            if ((chaine1 <> '') and (chaine <> '')) then
                chaine1 := ' ' + chaine1;
            chaine := chaine + chaine1;
            l := k;
            if ((k = 7) or (k = 9)) then
                k := (i mod 10) + 10
            else
                k := (i mod 10);
        end
        else
            k := i;

        if ((l <> 8) and (l <> 0) and ((k = 1) or (k = 11))) then
            chaine := chaine + ' et';
        if (((k = 0) or (k > 16)) and ((l = 7) or (l = 9))) then begin
            chaine := chaine + ' dix';
            if k > 16 then
                k := k - 10;
        end;

        Unité(chaine, k);
    end;

    [Scope('Internal')]
    procedure "Unité"(var chaine: Text[250]; i: Integer)
    begin
        chaine1 := '';
        case i of
            1:
                chaine1 := 'un';
            2:
                chaine1 := 'deux';
            3:
                chaine1 := 'trois';
            4:
                chaine1 := 'quatre';
            5:
                chaine1 := 'cinq';
            6:
                chaine1 := 'six';
            7:
                chaine1 := 'sept';
            8:
                chaine1 := 'huit';
            9:
                chaine1 := 'neuf';
            10:
                chaine1 := 'dix';
            11:
                chaine1 := 'onze';
            12:
                chaine1 := 'douze';
            13:
                chaine1 := 'treize';
            14:
                chaine1 := 'quatorze';
            15:
                chaine1 := 'quinze';
            16:
                chaine1 := 'seize';
        end;
        if ((chaine1 <> '') and (chaine <> '')) then
            chaine1 := ' ' + chaine1;
        chaine := chaine + chaine1;
    end;

    [Scope('Internal')]
    procedure "Montant en texte sans millimes"(var strprix: Text[250]; prix: Decimal)
    begin
        entiere := Round(prix, 1, '<');
        decimal := Round((prix - entiere) * 1000, 1, '<');

        nbre := entiere;
        //Chèque.FormatNumTexte(strprix,nbre);

        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' FCFA';
        if entiere = 1 then
            strprix := strprix + ' FCFA';

        if decimal <> 0 then begin
            if strprix <> '' then
                strprix := strprix + ' ' + Format(decimal)
            else
                strprix := strprix + Format(decimal);
            if decimal = 1 then
                strprix := strprix + ' centime'
            else
                strprix := strprix + ' centimes';
        end;

        strprix := UpperCase(strprix);
    end;

    [Scope('Internal')]
    procedure "Montant en texteDevise"(var strprix: Text[250]; prix: Decimal; Devise: Text[30])
    begin
        QuelleDevise(Devise, 0);
        entiere := Round(prix, 1, '<');
        decimal := Round((prix - entiere) * 100, 1, '<');
        nbre := entiere;
        million := '';
        mille := '';
        cent := '';
        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            Centaine(million, nbre1);
            million := million + ' million';
        end;
        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            Centaine(mille, nbre1);
            if mille <> 'un' then
                mille := mille + ' mille'
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            Centaine(cent, nbre);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;
        //<<MBY 23/05/2013
        /*
        IF entiere > 1 THEN
          strprix := strprix + ' ' + VarDeviseEntiere;
        IF entiere = 1 THEN
         strprix := strprix + ' ' + VarDeviseEntiere;
        */
        if entiere > 1 then
            strprix := VarDeviseEntiere + ' ' + strprix;
        if entiere = 1 then
            strprix := VarDeviseEntiere + ' ' + strprix;
        //>>MBY 23/05/2013
        cent := '';
        if decimal <> 0 then begin
            Centaine(cent, decimal);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' ' + VarDeviseDecimal
            else
                strprix := strprix + ' ' + VarDeviseDecimal;
        end
        //<<MBY 23/05/2013
        else
            strprix := strprix + ' ' + VarDeviseDecimal;
        //>>MBY 23/05/2013
        strprix := UpperCase(strprix);

    end;

    [Scope('Internal')]
    procedure QuelleDevise(var StrDevise: Text[30]; lng: Integer)
    begin
        /*
        IF StrDevise = 'USD' THEN
          CASE lng OF
            1033 : BEGIN
                    VarDeviseEntiere := 'US Dollars :';
                    VarDeviseDecimal := 'Cents';
                   END;
            ELSE   BEGIN
                    VarDeviseEntiere := '';
                    VarDeviseDecimal := 'Cents';
                   END;
          END;
        
        IF StrDevise = 'EUR' THEN
          CASE lng OF
            1033 : BEGIN
                    VarDeviseEntiere := 'Euro :';
                    VarDeviseDecimal := 'EuroCents';
                   END;
            ELSE   BEGIN
                    VarDeviseEntiere := 'Euro :';
                    VarDeviseDecimal := 'Centimes';
                   END;
          END;
        
        IF StrDevise = 'GBP' THEN
          CASE lng OF
            1033 : BEGIN
                    VarDeviseEntiere := 'Pounds :';
                    VarDeviseDecimal := 'Cents';
                   END;
            ELSE   BEGIN
                    VarDeviseEntiere := 'Livres Sterling :';
                    VarDeviseDecimal := 'Cents';
                   END;
          END;
        IF StrDevise = 'SYP' THEN
          CASE lng OF
            1033 : BEGIN
                    VarDeviseEntiere := 'Syrian Pounds :';
                    VarDeviseDecimal := 'Cents';
                   END;
            ELSE   BEGIN
                    VarDeviseEntiere := 'Syrian Pounds :';
                    VarDeviseDecimal := 'Cents';
                   END;
          END;
        //<<MBY 23/05/2013
        IF StrDevise = 'QAR' THEN
          CASE lng OF
            1033 : BEGIN
                    VarDeviseEntiere := 'Qatari Riyals :';
                    VarDeviseDecimal := 'Only';
                   END;
            ELSE   BEGIN
                    VarDeviseEntiere := 'Qatari Riyals :';
                    VarDeviseDecimal := 'Only';
                   END;
          END;
          //VarDeviseDecimal := 'Only';
           CASE lng OF
            1033 : BEGIN
                   VarDeviseDecimal := 'Only';
                   END;
            ELSE   BEGIN
                     VarDeviseDecimal := 'DOLLARS';
        
                   END;
         END;
        //>>MBY 23/05/2013
        //>> MT 09/07/2013
        IF StrDevise = 'AED' THEN
          CASE lng OF
            1033 : BEGIN
                    VarDeviseEntiere := 'Arab Emirates Dirham :';
                    VarDeviseDecimal := 'Only';
                   END;
            ELSE   BEGIN
                    VarDeviseEntiere := 'Arab Emirates Dirham :';
                    VarDeviseDecimal := 'Only';
                   END;
          END;
        //<< MT 09/07/2013
        //VarDeviseEntiere := StrDevise;
        
        */



        if StrDevise = 'USD' then
            case lng of
                1033:
                    begin
                        //  VarDeviseEntiere := 'US Dollars :';
                        // VarDeviseDecimal := 'Cents';
                        VarDeviseEntiere := '';
                        VarDeviseDecimal := 'Dollars';
                    end;
                else begin
                        VarDeviseEntiere := '';
                        VarDeviseDecimal := 'Dollars';
                        //VarDeviseEntiere := 'Dollars US :';
                        // VarDeviseDecimal := 'Cents';
                    end;
            end;

        if StrDevise = 'MAD' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Dirham';
                        VarDeviseDecimal := 'Cent';
                    end;
                else begin
                        VarDeviseEntiere := 'Dirham';
                        VarDeviseDecimal := 'Centimes';
                    end;
            end;
        if StrDevise = 'EUR' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Euro';
                        VarDeviseDecimal := 'EuroCents';
                        //VarDeviseEntiere := '';
                        //VarDeviseDecimal := 'Euro';
                    end;
                else begin
                        VarDeviseEntiere := 'Euro';
                        VarDeviseDecimal := 'Centimes';
                        //VarDeviseEntiere := '';
                        //VarDeviseDecimal := 'Euro';
                    end;
            end;

        if StrDevise = 'GBP' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Pounds :';
                        VarDeviseDecimal := 'Cents';
                    end;
                else begin
                        VarDeviseEntiere := 'Livres Sterling :';
                        VarDeviseDecimal := 'Cents';
                    end;
            end;
        if StrDevise = 'SYP' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Syrian Pounds :';
                        VarDeviseDecimal := 'Cents';
                    end;
                else begin
                        VarDeviseEntiere := 'Syrian Pounds :';
                        VarDeviseDecimal := 'Cents';
                    end;
            end;
        //<<MBY 23/05/2013
        if StrDevise = 'QAR' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Qatari Riyals :';
                        VarDeviseDecimal := 'Only';
                    end;
                else begin
                        VarDeviseEntiere := 'Qatari Riyals :';
                        VarDeviseDecimal := 'Only';
                    end;
            end;
        //  VarDeviseDecimal := 'Only';
        //>>MBY 23/05/2013
        //>> MT 09/07/2013
        if StrDevise = 'AED' then
            case lng of
                1033:
                    begin
                        VarDeviseEntiere := 'Arab Emirates Dirham :';
                        VarDeviseDecimal := 'Only';
                    end;
                else begin
                        VarDeviseEntiere := 'Arab Emirates Dirham :';
                        VarDeviseDecimal := 'Only';
                    end;
            end;
        //<< MT 09/07/2013
        //VarDeviseEntiere := StrDevise;

    end;

    [Scope('Internal')]
    procedure MontantTexteLangue(var strprix: Text[250]; prix: Decimal; lng: Integer)
    begin
        entiere := Round(prix, 1, '<');
        decimal := Round((prix - entiere) * 1000, 1, '<');
        nbre := entiere;
        million := '';
        mille := '';
        cent := '';
        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            CentaineLangue(million, nbre1, lng);
            case lng of
                1033:
                    million := million + ' million';
                else
                    million := million + ' million';
            end;
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            CentaineLangue(mille, nbre1, lng);
            if mille <> 'un' then
                case lng of
                    1033:
                        mille := mille + ' thousand';
                    else
                        mille := mille + ' mille';
                end
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            CentaineLangue(cent, nbre, lng);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;

        if entiere > 1 then
            strprix := strprix + ' FCFA';
        if entiere = 1 then
            strprix := strprix + ' FCFA';

        cent := '';
        if decimal <> 0 then begin
            CentaineLangue(cent, decimal, lng);
            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            if decimal = 1 then
                strprix := strprix + ' centime'
            else
                strprix := strprix + ' centimes';
        end;

        strprix := UpperCase(strprix);
    end;

    [Scope('Internal')]
    procedure MontantTexteDeviseLangue(var strprix: Text[250]; prix: Decimal; Devise: Text[30]; lng: Integer)
    begin
        QuelleDevise(Devise, lng);
        entiere := Round(prix, 1, '<');
        decimal := Round((prix - entiere) * 100, 1, '<');

        nbre := entiere;
        million := '';
        mille := '';
        cent := '';

        nbre1 := nbre div 1000000;
        if nbre1 <> 0 then begin
            CentaineLangue(million, nbre1, lng);
            case lng of
                1033:
                    million := million + ' million';
                else
                    million := million + ' million';
            end;
        end;

        nbre := nbre mod 1000000;
        nbre1 := nbre div 1000;
        if nbre1 <> 0 then begin
            CentaineLangue(mille, nbre1, lng);
            if mille <> 'un' then
                case lng of
                    1033:
                        mille := mille + ' thousand';
                    else
                        mille := mille + ' mille';
                end
            else
                mille := 'mille'
        end;

        nbre := nbre mod 1000;

        if nbre <> 0 then begin
            CentaineLangue(cent, nbre, lng);
        end;

        if million <> '' then
            strprix := million;
        if ((mille <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + mille
        else
            strprix := strprix + mille;
        if ((cent <> '') and (strprix <> '')) then
            strprix := strprix + ' ' + cent
        else
            strprix := strprix + cent;
        //>>MBY 23/05/2013
        /*
        IF entiere > 1 THEN
          strprix := strprix + ' ' + VarDeviseEntiere;
        IF entiere = 1 THEN
         strprix := strprix + ' ' + VarDeviseEntiere;
        */

        //Stopped by Meg01.00
        /*IF entiere > 1 THEN
          strprix := VarDeviseEntiere + ' ' + strprix ;
        IF entiere = 1 THEN
         strprix := VarDeviseEntiere+ ' ' + strprix;*/

        //Meg01.00+
        if entiere > 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;
        if entiere = 1 then
            strprix := strprix + ' ' + VarDeviseEntiere;
        //Meg01.00-

        //>>MBY 23/05/2013
        cent := '';
        if decimal <> 0 then begin
            CentaineLangue(cent, decimal, lng);

            if strprix <> '' then
                strprix := strprix + ' ' + cent
            else
                strprix := strprix + cent;
            //Stopped By Meg01.00
            /*IF decimal = 1 THEN
              strprix := strprix + ' ' + VarDeviseDecimal
             ELSE
              strprix := strprix + ' ' + VarDeviseDecimal;*/
            strprix := strprix + ' ' + VarDeviseDecimal//Meg01.00
        end;
        //<<MBY 23/05/2013
        //ELSE//Stopped by Meg01.00
        //strprix := strprix + ' ' + VarDeviseDecimal; //Stopped by Meg01.00
        //strprix := strprix + ' ' + VarDeviseEntiere; //Meg01.00
        //>>MBY 23/05/2013


        strprix := UpperCase(strprix);

    end;

    [Scope('Internal')]
    procedure CentaineLangue(var chaine: Text[250]; i: Integer; lng: Integer)
    var
        k: Integer;
    begin
        k := i div 100;
        chaine := '';
        case lng of
            1033:
                begin
                    case k of
                        1:
                            chaine := 'one hundred';
                        2:
                            chaine := 'two hundred';
                        3:
                            chaine := 'three hundred';
                        4:
                            chaine := 'four hundred';
                        5:
                            chaine := 'five hundred';
                        6:
                            chaine := 'six hundred';
                        7:
                            chaine := 'seven hundred';
                        8:
                            chaine := 'eight hundred';
                        9:
                            chaine := 'nine hundred';
                    end;
                end;
            else begin
                    case k of
                        1:
                            chaine := 'cent';
                        2:
                            chaine := 'deux cent';
                        3:
                            chaine := 'trois cent';
                        4:
                            chaine := 'quatre cent';
                        5:
                            chaine := 'cinq cent';
                        6:
                            chaine := 'six cent';
                        7:
                            chaine := 'sept cent';
                        8:
                            chaine := 'huit cent';
                        9:
                            chaine := 'neuf cent';
                    end;
                end;
        end;
        k := i mod 100;
        DizaineLangue(chaine, k, lng);
    end;

    [Scope('Internal')]
    procedure DizaineLangue(var chaine: Text[250]; i: Integer; lng: Integer)
    var
        k: Integer;
        l: Integer;
    begin
        case lng of
            1033:
                begin
                    if i > 19 then begin
                        k := i div 10;
                        chaine1 := '';
                        case k of
                            1:
                                chaine1 := 'ten';
                            2:
                                chaine1 := 'twenty';
                            3:
                                chaine1 := 'thirty';
                            4:
                                chaine1 := 'forty';
                            5:
                                chaine1 := 'fifty';
                            6:
                                chaine1 := 'sixty';
                            7:
                                chaine1 := 'seventy';
                            8:
                                chaine1 := 'eighty';
                            9:
                                chaine1 := 'ninety';
                        end;
                        if ((chaine1 <> '') and (chaine <> '')) then
                            chaine1 := ' ' + chaine1;
                        chaine := chaine + chaine1;
                        l := k;
                        k := (i mod 10);
                    end
                    else
                        k := i;

                    if ((l <> 8) and (l <> 0) and ((k = 11) or (k = 11))) then
                        chaine := chaine + ' and';
                    if (((k = 0) or (k > 19)) and ((l = 7) or (l = 9))) then begin
                        //MHM 10/07 chaine := chaine + ' Ten';
                        if k > 19 then
                            k := k - 10;
                    end;
                end;
            else begin
                    if i > 16 then begin
                        k := i div 10;
                        chaine1 := '';
                        case k of
                            1:
                                chaine1 := 'dix';
                            2:
                                chaine1 := 'vingt';
                            3:
                                chaine1 := 'trente';
                            4:
                                chaine1 := 'quarante';
                            5:
                                chaine1 := 'cinquante';
                            6:
                                chaine1 := 'soixante';
                            7:
                                chaine1 := 'soixante';
                            8:
                                chaine1 := 'quatre vingt';
                            9:
                                chaine1 := 'quatre vingt';
                        end;
                        if ((chaine1 <> '') and (chaine <> '')) then
                            chaine1 := ' ' + chaine1;
                        chaine := chaine + chaine1;
                        l := k;
                        if ((k = 7) or (k = 9)) then
                            k := (i mod 10) + 10
                        else
                            k := (i mod 10);
                    end
                    else
                        k := i;

                    if ((l <> 8) and (l <> 0) and ((k = 1) or (k = 11))) then
                        chaine := chaine + ' et';
                    if (((k = 0) or (k > 16)) and ((l = 7) or (l = 9))) then begin
                        chaine := chaine + ' dix';
                        if k > 16 then
                            k := k - 10;
                    end;
                end;
        end;
        UnitéLangue(chaine, k, lng);
    end;

    [Scope('Internal')]
    procedure "UnitéLangue"(var chaine: Text[250]; i: Integer; lng: Integer)
    begin
        chaine1 := '';
        case lng of
            1033:
                case i of
                    1:
                        chaine1 := 'one';
                    2:
                        chaine1 := 'two';
                    3:
                        chaine1 := 'three';
                    4:
                        chaine1 := 'four';
                    5:
                        chaine1 := 'five';
                    6:
                        chaine1 := 'six';
                    7:
                        chaine1 := 'seven';
                    8:
                        chaine1 := 'eight';
                    9:
                        chaine1 := 'nine';
                    10:
                        chaine1 := 'ten';
                    11:
                        chaine1 := 'eleven';
                    12:
                        chaine1 := 'twelve';
                    13:
                        chaine1 := 'thirteen';
                    14:
                        chaine1 := 'fourteen';
                    15:
                        chaine1 := 'fifteen';
                    16:
                        chaine1 := 'sixteen';
                    17:
                        chaine1 := 'seventeen';
                    18:
                        chaine1 := 'eighteen';
                    19:
                        chaine1 := 'nineteen';
                end;
            else
                case i of
                    1:
                        chaine1 := 'un';
                    2:
                        chaine1 := 'deux';
                    3:
                        chaine1 := 'trois';
                    4:
                        chaine1 := 'quatre';
                    5:
                        chaine1 := 'cinq';
                    6:
                        chaine1 := 'six';
                    7:
                        chaine1 := 'sept';
                    8:
                        chaine1 := 'huit';
                    9:
                        chaine1 := 'neuf';
                    10:
                        chaine1 := 'dix';
                    11:
                        chaine1 := 'onze';
                    12:
                        chaine1 := 'douze';
                    13:
                        chaine1 := 'treize';
                    14:
                        chaine1 := 'quatorze';
                    15:
                        chaine1 := 'quinze';
                    16:
                        chaine1 := 'seize';
                end;
        end;
        if ((chaine1 <> '') and (chaine <> '')) then
            chaine1 := ' ' + chaine1;
        chaine := chaine + chaine1;
    end;

    [Scope('Internal')]
    procedure SetGCurrencyCode(PCurrencyCode: Code[20])
    begin
        //>> DELTA AK
        GCurrencyCode := PCurrencyCode;
        //<< DELTA AK
    end;
}

