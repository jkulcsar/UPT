  program  NewTrajectoryPlanning;
  uses     Graph, Crt,Printer;
  const    Gr     = 10;
           NrP    = 10;
           orizontala     = #196;   Spatiu = '        ';
           verticala      = #179;
           ColtStingaSus  = #218;
           ColtStingaJos  = #192;
           ColtDreaptaSus = #191;
           ColtDreaptaJos = #217;

           SageataSus     =  72;
           SageataJos     =  80;
           SageataDreapta =  77;
           SageataStinga  =  75;

  type     Matrice = array[1..NrP,1..NrP]  of real;
           Vector  = array[1..NrP]         of real;
           Coeficienti = record
                           B : Matrice;
                         end;

  var      F, Fprim, Fsecund : Matrice ;
           M,MSalv,A, ASalv  : Matrice ;
           Segment           : array[1..NrP-1] of Coeficienti ;
           MaxFprim          : Matrice;
           MaxFsecund        : Matrice;
           Sv, Sa            : Vector  ;
           Vc,Ac             : Vector  ;
           T                 : Vector  ;
           CentruPunct       : Vector  ;
           MaxX, MaxY        : word    ;
           GraphX, GraphY    : word    ;
           TextMaxX,TextMaxY : byte    ;
           x0, y0            : word    ;
           ch                : char    ;
           S                 : real    ;
           Grade, Nmax       : byte    ;

  procedure AfiseazaMatricea( var Mtr : Matrice; NrLinii, NrColoane : byte );
  var i,j : byte;
  begin
       GoToXY(1,5);
       for i := 1 to NrLinii do begin
           if i = 1 then begin write(ColtStingaSus);GoToXY(NrColoane*8+3,5);writeln(ColtDreaptaSus);end;
           write(Verticala);
           for j := 1 to NrColoane do write( Mtr[i,j]:8:3 );
           writeln(' ' +Verticala);
           if i = NrLinii then begin write(ColtStingaJos);GoToXY(NrColoane*8+3,5+NrLinii+1);writeln(ColtDreaptaJos);end;
       end; { for i }
  end; { AfiseazaMatricea }

  procedure AfiseazaVector( var V : Vector; Lungime : byte );
  var i : byte;
  begin
       writeln;writeln;
       for i := 1 to Lungime do writeln( V[i]:10:3 );
  end; { AfiseazaVector }

  procedure Fereastra( x1,y1,x2,y2 : integer; CuloareFond : integer;
                                              CuloareScriere : integer);
  var i : byte;
  begin
    TextColor(CuloareScriere);
    TextBackground(CuloareFond);
    Window(x1,y1,x2,y2);
    ClrScr;
  { Traseaza liniile orizontale  }
    for i:=1+1 to x2-x1-1 do begin
      GotoXY(i,1); write(orizontala);
      GotoXY(i,y2-y1); write(orizontala);
    end;
  { Traseaza liniile verticale }
    for i:=1+1 to y2-y1-1 do begin
      GotoXY(1,i); write(verticala);
      GotoXY(x2-x1,i); write(verticala);
    end;
  { Deseneaza colturile }
    GotoXY(1,1); write(ColtStingaSus);
    GotoXY(x2-x1,1); write(ColtDreaptaSus);
    GotoXY(x2-x1,y2-y1); write(ColtDreaptaJos);
    GotoXY(1,y2-y1); write(ColtStingaJos);
    Window(x1+2,y1+2,x2-3,y2-2);
    TextMaxX := x2-3;
    TextMaxY := y2-2;
  end;  { Fereastra }

  procedure CitestePuncteCupla( indice : integer );
  var j : byte;
  begin
       repeat
          ClrScr;
          writeln(' Punctele prin care trece cupla ',indice,' sint : ');
          for j := 1 to Nmax do begin
                if j=1 then GoToXY(5,5) else GoToXY(5,(5+j-1));
                write('Punctul ',j,' : ');
                readln(F[j,indice]);
          end; { for j }
          writeln;
          write(' Datele introduse sint corecte ? (d/n) ');
          ch := ReadKey; ch := upcase(ch);
       until ch = 'D';
       writeln;
       write(' Apasati orice tasta . . . ');
       ch := ReadKey;
  end;

  procedure CitesteDate;
  var i,j : integer;
      Cond : byte;
  begin
     Fereastra(0,0,80,24,Black,White);
     Cond := 0;
     repeat
         write(' Numarul de cuple  : ');readln(Grade);
         if (Grade>10) or (Grade<=0) then begin
                                             Cond := 0;
                                             writeln(' Valoare eronata ! ');
                                             writeln(' Va rog sa verificati si reintroduceti .');
                                             write('   Orice tasta continua  . . . ');
                                             ch := ReadKey; ClrScr;
                                          end
         else Cond := 1;
     until Cond = 1;
     Cond := 0;
     repeat
        write(' Numarul de puncte : ');readln(Nmax);
        if (Nmax>10) or (Nmax<=3) then begin
                                          Cond := 0;
                                          writeln(' Valoare eronata !');
                                          writeln(' Va rog sa verificati si reintroduceti .');
                                          write('   Orice tasta continua . . . ');
                                          ch := ReadKey; ClrScr;
                                        end
        else Cond := 1;
     until Cond = 1;
     for i := 1 to Grade do CitestePuncteCupla(i);
     ClrScr;
     Window(1,1,80,25);
  end; { CitesteDate }

  procedure AfiseazaDateleCalculate;
  begin
     Fereastra(0,0,80,24,Black,White);
     writeln(' Vectorul de timp este : '); AfiseazaVector(T,Nmax);
     writeln; writeln; write(' Orice tasta continua . . . '); ch := ReadKey;
       ClrScr;
     writeln(' Matricea M este : '); AfiseazaMatricea( M,Nmax-2,Nmax-2 );
     writeln; writeln; write( ' Orice tasta continua . . . '); ch := ReadKey;
       ClrScr;
     writeln(' Matricea A este : '); AfiseazaMatricea( A,Nmax-2,Grade );
     writeln; writeln; write( ' Orice tasta continua . . . '); ch := ReadKey;
       ClrScr;
     Window(1,1,80,25);
  end; { AfiseazaDateleCalculate }

  procedure CalculeazaTimpii(var Time : Vector);
  var       k,i : byte;
            Sq  : real;
  begin
       Time[1] := 0;
       for k := 1 to Nmax-1  do
           begin
                Sq := 0;
                for i := 1 to Grade do Sq := Sq + sqr( F[k+1,i] - F[k,i] );
                Time[k+1] := sqrt( Sq );
           end; { for }
  end; { CalculeazaTimpii }

  procedure SolveGauss( var X : Matrice; NrLiniiX, NrColoaneX : byte;
                        var Y : Matrice; NrLiniiY, NrColoaneY : byte;
                        var Z : Matrice; NrLiniiZ, NrColoaneZ : byte );
  var N,i,j,k,l,ii,jj : byte;
      Suma        : real;
      kZ,jZ          : byte;
      Op          : real;
     begin
         i := 1;
         j := 1;
         repeat
            if X[i,j]<>0 then begin
               l := i+1;
               repeat
                  k  := j;
                  Op := X[l,k]/X[i,j];
                  for kZ := 1 to NrColoaneZ do Z[l,kZ] := Z[l,kZ] - Z[i,kZ]*Op;
                  repeat
                     X[l,k]  := X[l,k] - X[i,k]*Op ;
                     k := k + 1;
                  until k = (NrColoaneX+1);
                  l := l + 1;
               until l = (NrLiniiX+1);
            end; { if }
            i := i+1;
            j := j+1;
         until i=NrLiniiX;

     N := Nmax - 2;
     for j := 1 to Grade do
         begin
              Y[N,j] := Z[N,j]/X[N,N];
              for ii := (N-1) downto 1 do
                  begin
                       jj   := ii + 1;
                       Suma := 0;
                       repeat
                             Suma := Suma + (X[ii,jj]/X[ii,ii])*Y[jj,j];
                             jj   := jj + 1;
                       until jj = (N+1);
                       Y[ii,j] := Z[ii,j]/X[ii,ii] - Suma;
                  end; { for ii }
         end; { for j }
  end; { SolveGauss }

  procedure CalculeazaMatriceaM;
  var i,j : byte;
  begin
       i := 1;
       repeat
             j := 1;
             repeat
                   if ( j = i-1 )  then M[i,j] := T[i+2] else
                   if ( j = i   )  then M[i,j] := 2*(T[i+2] + T[i+1]) else
                   if ( j = i+1 )  then M[i,j] := T[i+1] else
                   M[i,j] := 0;
                   j := j + 1;
             until j  = Nmax - 1;
             i := i + 1;
       until i  = Nmax - 1;
       M[Nmax-2,Nmax-3] := 1/T[Nmax-1] ;
       M[Nmax-2,Nmax-2] := 2/T[Nmax-1] + 3/T[Nmax] ;
       M[1,1] := 2/T[3] + 3/T[2] ;
       M[1,2] := 1/T[3] ;
  end; { CalculeazaMatriceaM }

  procedure CalculeazaMatriceaA;
  var i,j : byte;
  begin
       for i := 2 to (Nmax-2) do
       begin
             j := 1;
             repeat
                   A[i,j] := (3/(T[i+1]*T[i+2]))*( sqr(T[i+1])*(F[i+2,j]-F[i+1,j]) +
                             sqr(T[i+2])*(F[i+1,j]-F[i,j]) );
                   j := j + 1;
             until j  = Grade + 1;
       end; { for i }
       for j := 1 to Grade do
           begin
                A[1,j] := 3/sqr(T[3])*(F[3,j]-F[2,j]) + 6/sqr(T[2])*(F[2,j]-F[1,j]);
                A[Nmax-2,j] := 3/sqr(T[Nmax-1])*(F[Nmax-1,j]-F[Nmax-2,j]) + 6/sqr(T[Nmax])*(F[Nmax,j]-F[Nmax-1,j]);
           end; { for }
  end; { CalculeazaMatriceaA }

  procedure SalveazaMatricile;
  var i,j : byte;
  begin
     for i := 1 to Nmax-2 do
         for j := 1 to Nmax-2 do MSalv[i,j] := M[i,j];
     for i := 1 to Nmax-2 do
         for j := 1 to Grade do  ASalv[i,j] := A[i,j];
  end;

 procedure CalculeazaMatriceaFprim;
 begin
     SolveGauss( M,     Nmax-2, Nmax-2,
                 Fprim, Nmax-2, 1     ,
                 A,     Nmax-2, Grade      );
 end; { CalculeazaMatriceaFprim }

  procedure CalculeazaSegmentele;
  var i,ii,j,jj,N : byte;
      Suma        : real;
      ch          : char;
  begin
        with Segment[1] do
        for j := 1 to Grade do
                 begin
                      B[1,j] := F[1,j];
                      B[2,j] := 0;
                      B[3,j] := 0;
                      B[4,j] :=  4/(sqr(T[2])*T[2]  ) *( F[2,j]-F[1,j] ) - Fprim[1,j]/sqr(T[2]);
                      B[5,j] :=  3/( sqr(sqr(T[2])) ) *( F[1,j]-F[2,j] ) + Fprim[1,j]/(sqr(T[2])*T[2]);
                  end; { for }

        for i := 2 to Nmax-1 do
            with Segment[i] do
                 for j := 1 to Grade do
                     begin
                          B[1,j] := F[i,j];
                          B[2,j] := Fprim[i-1,j];
                          B[3,j] := ( 3*(F[i+1,j]-F[i,j])/T[i+1] - 2*Fprim[i-1,j] - Fprim[i,j])/T[i+1];
                          B[4,j] := ( 2*(F[i,j]-F[i+1,j])/T[i+1] + Fprim[i-1,j] + Fprim[i,j])/sqr(T[i+1]);
                     end;

        with Segment[Nmax-1] do
        for j := 1 to Grade do
                 begin
                      B[1,j] := F[Nmax-1,j];
                      B[2,j] := Fprim[Nmax-2,j];
                      B[3,j] := (  6*F[Nmax,j] - 6*F[Nmax-1,j] - 3*Fprim[Nmax-2,j]*T[Nmax])/sqr(T[Nmax]);
                      B[4,j] := ( -8*F[Nmax,j] + 8*F[Nmax-1,j] + 3*Fprim[Nmax-2,j]*T[Nmax])/(sqr(T[Nmax])*T[Nmax]);
                      B[5,j] := (  3*F[Nmax,j] - 3*F[Nmax-1,j] -   Fprim[Nmax-2,j]*T[Nmax])/(sqr(sqr(T[Nmax])));
                 end;

  end;  { CalculeazaSegmentele }

  procedure CalculeazaFactorulS;
  var i,j,k : byte;
      timp  : real;
      Aux   : real;
      AuxV,AuxA : real;
      S1,S2 : real;
      InterFprim, InterFsecund : Vector;
  begin
        { Calculeaza vectorul MaxFprim pentru primul segment }
        with Segment[1] do
        for j := 1 to Grade do
            begin
                 timp := ((-1)*6*B[4,j])/(12*B[5,j]);
                 if ( (timp <=  T[2]) or (timp < 0) ) then
                    MaxFprim[1,j] :=  abs(3*B[4,j]*timp*timp + 4*B[5,j]*timp*timp*timp)
                 else MaxFprim[1,j] := 0;
            end;

        { Calculeaza vectorii MaxFprim intermediare }
        for i := 2 to Nmax-2 do
            with Segment[i] do
            for j := 1 to Grade do
                begin
                     timp :=  ((-1)*2*B[3,j])/(6*B[4,j]);
                     if ((timp <=  T[i+1])  or (timp < 0) ) then
                        MaxFprim[i,j] := abs(B[2,j] + 2*B[3,j]*timp + 3*B[4,j]*timp*timp)
                     else MaxFprim[i,j] := 0;
                end;

        { Calculeaza vectorul MaxFprim pentru ultimul segment }
        with Segment[Nmax-1] do
        for j := 1 to Grade do
            begin
                  timp := 0;
                  repeat
                     Aux :=  2*B[3,j] + 6*B[4,j]*timp+12*B[5,j]*timp*timp;
                     timp := timp + 0.001;
                  until ( (Aux>=0) and (Aux<=0.01) );
                  if ( (timp <= T[Nmax]) or (timp < 0) ) then
                     MaxFprim[Nmax-1,j] := abs(B[2,j] + 2*B[3,j]*timp + 3*B[4,j]*timp*timp +
                                           4*B[5,j]*timp*timp*timp)
                  else MaxFprim[Nmax-1,j] := 0;
            end;

            {Calculeaza MaxFsecund pentru primele segmente }
            with Segment[1] do
            for j := 1 to Grade do
                begin
                     timp := (-0.25)*(B[4,j]/B[5,j]);
                     if ( (timp<=T[2]) or (timp<0) ) then
                        MaxFsecund[1,j] := abs(6*B[4,j]*timp + 12*B[5,j]*timp*timp)
                     else MaxFsecund[1,j] := 0;
                end;

            {Calculeaza pentru segmentele intermediare }
            for i := 2 to Nmax-2 do
                with Segment[i] do
                for j := 1 to Grade do
                    begin
                         timp := T[i+1];
                         MaxFsecund[i,j] := abs( 2*B[3,j] + 6*B[4,j]*timp );
                    end;

            {Calculeaza pentru ultimele segmente }
            with Segment[Nmax-1] do
            for j := 1 to Grade do
                begin
                     timp := (-0.25)*(B[4,j]/B[5,j]);
                     if ( (timp<=T[2]) or (timp<0) ) then
                        MaxFsecund[Nmax-1,j] := abs(2*B[3,j] + 6*B[4,j]*timp +
                                                    12*B[5,j]*timp*timp)
                     else MaxFsecund[Nmax-1,j] := 0;
                end;

        for j := 1 to Grade do begin
            InterFprim[j] := 0;
            for i := 1 to Nmax-1 do
                if MaxFprim[i,j] >= InterFprim[j] then InterFprim[j] := MaxFprim[i,j];
        end;

        for j := 1 to Grade do begin
            InterFsecund[j] := 0;
            for i := 1 to Nmax-1 do
                if MaxFsecund[i,j] >= InterFsecund[j] then InterFsecund[j] := MaxFsecund[i,j];
        end;

        for j := 1 to Grade do begin
            Sv[j] := InterFprim[j]/Vc[j];
            Sa[j] := sqrt(InterFsecund[j]/Ac[j]);
        end;

        AuxV := 0; AuxA := 0;
        for j := 1 to Grade do
            begin
                 if Sv[j] >= AuxV then S1 := Sv[j];
                 if Sa[j] >= AuxA then S2 := Sa[j];
            end;
        if S1>S2 then S := S1 else S := S2;
  end;

  procedure Init;
  var       GraphDriver, GraphMode : integer;
  begin
        GraphDriver := Detect;
        InitGraph( GraphDriver, GraphMode, 'C:\TP7\BGI' );
        MaxX := GetMaxX;
        MaxY := GetMaxY;
        x0   := MaxX div 2;
        y0   := MaxY div 2;
        SetViewPort(0,0,MaxX,MaxY,True);
  end;  { Init }

  procedure Message( Msg : string );
  begin
      SetViewPort(0,0,MaxX,MaxY,True);
      SetTextStyle(SmallFont,HorizDir,4);
      SetFillStyle( SolidFill, Black );
      Bar( 0,MaxY-10,MaxX,MaxY );
      OutTextXY( 10,MaxY-10,Msg );
  end;

  procedure AxeSuprapuse;
  begin
       SetColor( LightGray );
       Line( 10,10,10,MaxY-20);
       Line( 5,((MaxY-20) div 2),(MaxX-10),((MaxY-20) div 2));
       SetColor( White );
  end;

   procedure AfiseazaFunctie( Nc : integer; Ns : integer );
   var Xmin,Ymin,Xmax,Ymax : word;
       idx                 : byte;
       Numar,strNc,strNs   : string[30];
       Semn,Putere         : string[5];
   begin
      Xmin:=x0+1;Ymin:=y0+1;
      Xmax:=MaxX-1;Ymax:=MaxY-12;
      SetViewPort(0,0,MaxX,MaxY,True);
      Rectangle( Xmin,Ymin,Xmax,Ymax );
      SetViewPort( Xmin,Ymin,Xmax,Ymax,False);
      SetColor( White );

      Str(Nc,strNc); Str(Ns,strNs);
      OutTextXY(10,20, ' Pentru cupla '+strNc);
      OutTextXY(10,35, ' si pentru segmentul '+strNs+' functia de interpolare este : ');
      OutTextXY(20,75, ' f(t) = ');
        if (Ns = 1) or (Ns = (Nmax-1)) then
           with Segment[Ns] do
                for idx := 1 to 5 do begin
                    Str(B[idx,Nc]:10:3, Numar);
                    Str(idx-1,Putere);
                    if idx = 1 then OutTextXY( 50,25*idx+50,Numar)
                       else if idx = 2 then OutTextXY( 50,25*idx+50,Numar+' t ')
                            else OutTextXY( 50,25*idx+50,Numar+' t'+Putere);
                end
        else with Segment[Ns] do
                  for idx := 1 to 4 do begin
                      Str(B[idx,Nc]:10:3, Numar);
                    Str(idx-1,Putere);
                    if idx = 1 then OutTextXY( 50,25*idx+50,Numar)
                       else if idx = 2 then OutTextXY( 50,25*idx+50,Numar+' t ')
                            else OutTextXY( 50,25*idx+50,Numar+' t'+Putere);
                  end;
        OutTextXY( 10,200, ' Orice tasta continua  . . . ');
        ch := ReadKey;
        ClearViewPort;
   end; { AfiseazaFunctie }

   {$I PRINTFIL.PAS }

  procedure TraseazaGraficul;
  var ScalX, ScalY   : real;
      timp,p,pas     : real;
      i,j,c          : byte;
      k,l,ii,jj      : word;
      Contor         : real;
      Elapsed        : real;
      Numar          : string[20];
      Gx,Gy          : array[1..3000] of real;
      Xmin,Ymin,Xmax,Ymax : word;
      Aux,AuxX,AuxY  : real;
      MaxP           : real; { In aceasta variabila aflu coordonata Y maxima
                               a tuturor traiectoriilor ; ajuta la reprezentarea
                               exacta ( scalarea exacta ) a graficelor pe
                               coordonatele Y la trasarea graficelor suprapuse }
      ch             : char;
  begin

   repeat
        Message('    S  -  grafice suprapuse     L  -  grafice laterale     I - Imprimanta       Esc  -  Iesire grafice  ');
        ch := ReadKey; ch := upcase(ch);
        ClearDevice;
        MaxP  := 0;

        j     := 1;
       repeat
        pas   := 0.05;           { Se initializeaza pasul de parcurgere }
        p     := 0;
        k     := 1;
        CentruPunct[1] := k;

 { Calculeaza punctele intermediare pentru primul segment pentru cupla j }
        with Segment[1] do begin
             Contor  := 0;
             begin
                  timp := Contor;
                  Gx[k] :=  p  ;
                  Gy[k] :=  (-1)*(B[1,j] + B[2,j]*timp + B[3,j]*timp*timp +
                            B[4,j]*timp*timp*timp + B[5,j]*timp*timp*timp*timp)  ;
                  if abs(Gy[k]) >= MaxP then MaxP := abs(Gy[k]);
                  repeat
                        timp := Contor;
                        k    := k + 1;
                        Gx[k] :=  p ;
                        Gy[k] :=  (-1)*(B[1,j] + B[2,j]*timp + B[3,j]*timp*timp +
                                   B[4,j]*timp*timp*timp + B[5,j]*timp*timp*timp*timp);
                        if abs(Gy[k]) >= MaxP then MaxP := abs(Gy[k]);
                        Contor  := Contor  + pas;
                              p := p       + pas;
                  until Contor >= T[2];
                  CentruPunct[2] := k;
             end;
        end; { with }

 { Calculeaza punctele intermediare pt. segmentele intermediare pt. cupla j }
        for i := 2 to Nmax-2 do
            with Segment[i] do begin
                 Contor := 0;
                 repeat
                       timp := Contor;
                       k    := k + 1;
                       Gx[k] :=  p ;
                       Gy[k] :=  (-1)*(B[1,j] + B[2,j]*timp + B[3,j]*timp*timp +
                                  B[4,j]*timp*timp*timp) ;
                       if abs(Gy[k]) >= MaxP then MaxP := abs(Gy[k]);
                       Contor  := Contor  + pas;
                       p       := p       + pas;
                 until Contor >= T[i+1];
                 CentruPunct[i+1] := k;
            end; { with }

 { Calculeaza punctele intermediare pentru ultimul segment  pentru cupla j }
        with Segment[Nmax-1] do begin
             Contor := 0;
             repeat
                   timp := Contor;
                   k    := k + 1;
                   Gx[k] :=  p ;
                   Gy[k] :=  (-1)*(B[1,j] + B[2,j]*timp + B[3,j]*timp*timp +
                              B[4,j]*timp*timp*timp + B[5,j]*timp*timp*timp*timp) ;
                   if abs(Gy[k]) >= MaxP then MaxP := abs(Gy[k]);
                   p       := p       + pas;
                   Contor  := Contor  + pas;
             until Contor >= T[Nmax];
             CentruPunct[Nmax] := k;
        end; { with }

    if ch='L' then begin
        if j = 4 then ClearDevice;
        c := j mod 3;
        if (c = 1) then begin
                             Xmin:=1;Ymin:=1;
                             Xmax:=x0-1;Ymax:=y0-1;
                             SetColor( LightGray );
                             Line(Xmin+2,((MaxY-12)div 4),Xmax-2,((MaxY-12) div 4));
                             Line(Xmin+5,Ymin+5,Xmin+5,Ymax-5);
                             SetColor( White );
                        end;
        if (c = 2) then begin
                             Xmin:=x0+1;Ymin:=1;
                             Xmax:=MaxX-1;Ymax:=y0-1;
                             SetColor( LightGray );
                             Line(Xmin+2,((MaxY-12)div 4),Xmax-2,((MaxY-12) div 4));
                             Line(Xmin+5,Ymin+5,Xmin+5,Ymax-5);
                             SetColor( White );
                        end;
        if (c = 0) then begin
                             Xmin:=1;Ymin:=y0+1;
                             Xmax:=x0-1;Ymax:=MaxY-12;
                             SetColor( LightGray );
                             SetViewPort(0,0,MaxX,MaxY,True );
                             Line(Xmin+2,round(0.75*(MaxY-12)),Xmax-2,round(0.75*(MaxY-12)) );
                             Line(Xmin+5,Ymin+5,Xmin+5,Ymax-5);
                             SetColor( White );
                         end;

        Aux := 0;
        for l := 1 to k do if abs(Gx[l]) >= Aux then Aux := abs(Gx[l]);
        ScalX := 120;
        repeat
             AuxX := Aux*ScalX;
             ScalX := ScalX - 0.1;
        until AuxX < ( x0-10 );

        Aux := 0;
        for l := 1 to k do if abs(Gy[l]) >= Aux then Aux := abs(Gy[l]);
        ScalY := 120;
        repeat
              AuxY := MaxP*ScalY;
              ScalY := ScalY - 0.1;
        until AuxY < ( Ymax div 5 );

        SetViewPort(0,0,MaxX,MaxY,True);
        Rectangle( Xmin,Ymin,Xmax,Ymax );
        SetViewPort( Xmin,Ymin,Xmax,Ymax,False);
        Str(j,Numar); OutTextXY(265,215,'Cupla '+Numar);

        for l := 1 to k do begin
            GraphX := round(Gx[l]*ScalX)+5 ;
            GraphY := round(Gy[l]*ScalY)+( (Ymax-Ymin) div 2 )   ;
            if l = 1 then  begin
                              MoveTo( GraphX,GraphY );
                              Circle( GraphX,GraphY,2 );
                           end
            else LineTo( GraphX,GraphY );
            for i := 2 to Nmax do if (l=CentruPunct[i]) then Circle( GraphX,GraphY,2);
        end;

            for jj := 1 to Nmax-1 do
                AfiseazaFunctie( j, jj );

        SetViewPort(0,0,MaxX,MaxY,True);
    end; { optiunea grafice laterale }

    if ch='S' then begin

        Rectangle(0,0,MaxX,MaxY-11);
        AxeSuprapuse;

        Aux := 0;
        for l := 1 to k do if abs(Gx[l]) >= Aux then Aux := abs(Gx[l]);
        ScalX := 120;
        repeat
             AuxX  := Aux*ScalX;
             ScalX := ScalX - 0.1;
        until AuxX < ( MaxX-20 );

        Aux := 0;
        for l := 1 to k do if abs(Gy[l]) >= Aux then Aux := abs(Gy[l]);
        ScalY := 120;
        repeat
              AuxY := MaxP*ScalY;
              ScalY := ScalY - 0.1;
        until AuxY < ( (MaxY div 2) - 20 );

        SetViewPort(0,0,MaxX,MaxY,True);
        for l := 1 to k do
            begin
                 GraphX := round(Gx[l]*ScalX) + 10  ;
                 GraphY := round(Gy[l]*ScalY) + (MaxY div 2) ;
                 if l = 1 then begin
                                  MoveTo( GraphX,GraphY );
                                  Circle( GraphX,GraphY,2 );
                               end
                 else LineTo( GraphX,GraphY );
                 for i := 2 to Nmax do if (l=CentruPunct[i]) then Circle( GraphX,GraphY,2 );
        end; { for l }
        Str(j:2,Numar); OutText(Numar);
    end; { optiunea grafice suprapuse }

    if ch='I' then TiparesteDate;

    j := j + 1;
  until j = (Grade+1);
 until ch = #27;
 end; { TraseazaGraficul }

  procedure SetDesign;
  var Xmin,Ymin,Xmax,Ymax : word;
      Xc,Yc               : word;
  begin
       Xmin := x0; Ymin := y0;
       Xmax := x0; Ymax := y0;
       Xc   :=  0; Yc   :=  0;
       repeat
             SetColor( Yellow );
             Rectangle( Xmin-Xc,Ymin-Yc, Xmax+Xc,Ymax+Yc );
             Delay(10);
             if Xc < ( MaxX div 2 ) then
                begin
                     SetColor( Black );
                     Rectangle( Xmin-Xc,Ymin-Yc, Xmax+Xc,Ymax+Yc );
                end; { if }
             Xc := Xc + 8;
             Yc := Yc + 6;
       until Xc >= (MaxX div 2);
       SetColor( Yellow );
       Rectangle( 0,0,MaxX, MaxY-11);
  end; { SetDesign }

  begin { main }
  repeat
    ClrScr;
    CitesteDate;
    CalculeazaTimpii( T );
    CalculeazaMatriceaM;
    CalculeazaMatriceaA;
    writeln; GoToXY(3,3);
    writeln(' Pentru a vizualiza matricile T, M respectiv A apasati SpaceBar . . . ');
    GoToXY(3,4); write(' Orice alta tasta continua . . . ');
    ch := ReadKey; if ch = ' ' then AfiseazaDateleCalculate;
    SalveazaMatricile;
    CalculeazaMatriceaFprim;
    CalculeazaSegmentele;
{    CalculeazaFactorulS;          }
    Init;
      SetDesign;
      TraseazaGraficul;
   Message(' Pentru o noua rulare apasati Enter                                           Iesire din program cu Esc ');
   ch := ReadKey;
   CloseGraph;
  until ch = #27;
  end.  { main }