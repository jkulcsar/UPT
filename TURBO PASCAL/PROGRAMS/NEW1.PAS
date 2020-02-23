  program  NewTrajectoryPlanning;
  uses     Graph, Crt;
  const    Grade  = 3;
           Nmax   = 6;

  type     Matrice = array[1..Nmax,1..Nmax]  of real;
           Vector  = array[1..Nmax]          of real;
           Coeficienti = record
                           B : Matrice;
                         end;
           LongVector = array[1..1200] of word;

  var      F, Fprim, Fsecund : Matrice ;
           M, A              : Matrice ;
           Segment           : array[1..Nmax-1] of Coeficienti ;
        MaxFprim, MaxFsecund : Matrice;
           Sv, Sa            : Vector  ;
           Vc,Ac             : Vector  ;
           T                 : Vector  ;
           GraphX, GraphY    : LongVector ;
           MaxX, MaxY        : word    ;
           x0, y0            : word    ;
           S                 : real    ;

  procedure AfiseazaMatricea( var Mtr : Matrice; NrLinii, NrColoane : byte );
  var i,j : byte;
  begin
       for i := 1 to NrLinii do
           begin
                writeln;
                for j := 1 to NrColoane do write( Mtr[i,j]:10:3 );
           end; { for }
  end; { AfiseazaMatricea }

  procedure AfiseazaVector( var V : Vector; Lungime : byte );
  var i : byte;
  begin
       writeln;writeln;
       for i := 1 to Lungime do write( V[i]:10:3 );
  end; { AfiseazaVector }

  procedure CitesteDate;
  var i,j : byte;
  begin
       F[1,1] := 0;   F[1,2] := 0;   F[1,3] := 0;
       F[2,1] := 1;   F[2,2] := 1;   F[2,3] := 1;
       F[3,1] := 2;   F[3,2] := 2.5; F[3,3] := 2;
       F[4,1] := 4;   F[4,2] := 3.5; F[4,3] := 2.5;
       F[5,1] := 5;   F[5,2] := 2;   F[5,3] := 1.75;
       F[6,1] := 6;   F[6,2] := 0;   F[6,3] := 0;

       Vc[1] := 100; Vc[2] := 90; Vc[3] := 100;
       Ac[1] := 45 ; Ac[2] := 50; Ac[3] := 40 ;

  end; { CitesteDate }

  procedure CalculeazaTimpii(var Time : Vector);
  var       k,i : byte;
            Sq  : real;
  begin
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
       { Calculeaza matricea M }
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
       i := 2;
       repeat
             j := 1;
             repeat
                   A[i,j] := 3/(T[i+1]*T[i+2])*( sqr(T[i+1])*(F[i+2,j]-F[i+1,j]) +
                             sqr(T[i+2])*(F[i+1,j]-F[i,j]) );
                   j := j + 1;
             until j  = Grade + 1;
             i := i + 1;
       until i  = Nmax - 2;
       for j := 1 to Grade do
           begin
                A[1,j] := 3/sqr(T[3])*(F[3,j]-F[2,j]) + 6/sqr(T[2])*(F[2,j]-F[1,j]);
                A[Nmax-2,j] := 3/sqr(T[Nmax-1])*(F[Nmax-1,j]-F[Nmax-2,j]) + 6/sqr(T[Nmax])*(F[Nmax,j]-F[Nmax-1,j]);
           end; { for }
  end; { CalculeazaMatriceaA }

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

        for i := 2 to 4 do
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
        InitGraph( GraphDriver, GraphMode, 'C:\TP6\BGI' );
        MaxX := GetMaxX;
        MaxY := GetMaxY;
        x0   := MaxX div 2;
        y0   := MaxY div 2;
  end;  { Init }

  procedure TraseazaGraficul;
var   ScalX,  ScalY  : real;
      timp,p,pas     : real;
      i,j,c          : byte;
      k,l            : word;
      Contor         : real;
      Elapsed        : real;
      Numar          : string;
      Gx,Gy          : array[1..1200] of real;
      Xmin,Ymin,Xmax,Ymax : word;
      Aux,AuxX,AuxY  : real;
  begin
        j     := 1;
    repeat
        pas   := 0.2;           { Se initializeaza pasul de parcurgere }
        p     := 0;
        k     := 1;
        { Traseaza primul segment pentru cupla j }
        with Segment[1] do begin
             Contor  := 0;
             Elapsed := 0;
             begin
                  timp := Contor;
                  Gx[k] :=  p  ;
                  Gy[k] :=  (-1)*(B[1,j] + B[2,j]*timp + B[3,j]*timp*timp +
                            B[4,j]*timp*timp*timp + B[5,j]*timp*timp*timp*timp)  ;
                  repeat
                        timp := Contor;
                        k    := k + 1;
                        Gx[k] :=  p ;
                        Gy[k] :=  (-1)*(B[1,j] + B[2,j]*timp + B[3,j]*timp*timp +
                                   B[4,j]*timp*timp*timp + B[5,j]*timp*timp*timp*timp);
                        Contor  := Contor  + pas;
                        Elapsed := Elapsed + pas;
                              p := p       + pas;
                  until Contor >= T[2];
             end;
        end; { with }

        for i := 2 to Nmax-2 do
            with Segment[i] do begin
                 Contor := 0;
                 repeat
                       timp := Contor;
                       k    := k + 1;
                       Gx[k] :=  p ;
                       Gy[k] :=  (-1)*(B[1,j] + B[2,j]*timp + B[3,j]*timp*timp +
                                  B[4,j]*timp*timp*timp) ;
                       Contor  := Contor  + pas;
                       Elapsed := Elapsed + pas;
                       p       := p       + pas;
                 until Contor >= T[i+1];
            end; { with }

        { Se traseaza ultimul segment }
        with Segment[Nmax-1] do begin
             Contor := 0;
             repeat
                   timp := Contor;
                   k    := k + 1;
                   Gx[k] :=  p ;
                   Gy[k] :=  (-1)*(B[1,j] + B[2,j]*timp + B[3,j]*timp*timp +
                              B[4,j]*timp*timp*timp) ;
                   Elapsed := Elapsed + pas;
                   p       := p       + pas;
                   Contor  := Contor  + pas;
             until Contor >= T[Nmax];
        end; { with }

        c := j mod 4;
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
        if (c = 3) then begin
                             Xmin:=1;Ymin:=y0+1;
                             Xmax:=x0-1;Ymax:=MaxY-12;
                             SetColor( LightGray );
                             SetViewPort(0,0,MaxX,MaxY,True );
                             Line(Xmin+2,round(0.75*(MaxY-12)),Xmax-2,round(0.75*(MaxY-12)) );
                             Line(Xmin+5,Ymin+5,Xmin+5,Ymax-5);
                             SetColor( White );
                         end;
        if (c = 0) then begin
                             Xmin:=x0+1;Ymin:=y0+1;
                             Xmax:=MaxX-1;Ymax:=MaxY-12;
                             SetColor( LightGray );
                             SetViewPort(0,0,MaxX,MaxY,True );
                             Line(Xmin+2,round(0.75*(MaxY-12)),Xmax-2,round(0.75*(MaxY-12)) );
                             Line(Xmin+5,Ymin+5,Xmin+5,Ymax-5);
                             SetColor( White );
                        end;

        Aux := 0;
        for l := 1 to k do if abs(Gx[l]) >= Aux then Aux := abs(Gx[l]);
        ScalX := 50;
        repeat
             AuxX := Aux*ScalX;
             ScalX := ScalX - 0.1;
        until AuxX < ( x0-10 );

        Aux := 0;
        for l := 1 to k do if abs(Gy[l]) >= Aux then Aux := abs(Gy[l]);
        ScalY := 50;
        repeat
              AuxY := Aux*ScalY;
              ScalY := ScalY - 0.1;
        until AuxY < ( Ymax div 5 );

        for l := 1 to k do
            begin
                 GraphX[l] := round(Gx[l]*ScalX)+5   ;
                 GraphY[l] := round(Gy[l]*ScalY)+( (Ymax-Ymin) div 2 )   ;
            end;
        SetViewPort(0,0,MaxX,MaxY,True);
        Rectangle( Xmin,Ymin,Xmax,Ymax );
        SetViewPort( Xmin,Ymin,Xmax,Ymax,False);
        MoveTo( GraphX[1],GraphY[1] );
        for l := 2 to k do LineTo( GraphX[l],GraphY[l] );

        j := j + 1;
  until j = (Grade+1);
  end;

  procedure SetDesign;
  var Xmin,Ymin,Xmax,Ymax : word;
      Xc,Yc               : word;
  begin
       ClearDevice;
       Xmin := x0; Ymin := y0;
       Xmax := x0; Ymax := y0;
       Xc   :=  0; Yc   :=  0;
       repeat
             SetColor( Yellow );
             Rectangle( Xmin-Xc,Ymin-Yc, Xmax+Xc,Ymax+Yc );
             Delay(20);
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
        ClrScr;
    CitesteDate;
    CalculeazaTimpii( T );
    CalculeazaMatriceaM;
    CalculeazaMatriceaA;
    CalculeazaMatriceaFprim;
    CalculeazaSegmentele;
    CalculeazaFactorulS;
   Init;
    SetDesign;
    TraseazaGraficul;
    repeat until KeyPressed;
  end.  { main }