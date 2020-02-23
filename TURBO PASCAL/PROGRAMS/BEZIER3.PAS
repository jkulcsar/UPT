program matrix ;
uses Graph, Crt ;
type         matriceNxN = array[1..4,1..4] of real ;
            MatriceBaza = array[1..10,1..10] of real;
                MatrInt = array[1..10,1..10] of integer;

var       xQb, yQb, zQb : matriceNxN;
                  x0,y0 : word;
            xB ,yB ,zB  : MatriceBaza;
            xS ,yS ,zS  : MatriceBaza;
                qB, wB  : MatrInt;
              page, arg : word;
                    pas : real;
                    j,k : byte;

 procedure ReadData;
 var     j,k : byte;
     ch, chr : char;
        nume : string[20];
           f : file of matriceNxN;
 begin
     ClrScr;
     write(' De unde citesc datele ? (F/C) . . . ');readln(ch);ch:=upcase(ch);
     case ch of
 'C' : begin
       writeln( 'Introduceti coordonatele punctelor de control . . . ');writeln;
       for j := 1 to 4 do
           for k := 1 to 4 do begin
               write('xQb[ ',j:2,k:2,' ]= ');readln(xQb[j,k]);
               write('yQb[ ',j:2,k:2,' ]= ');readln(yQb[j,k]);
               write('zQb[ ',j:2,k:2,' ]= ');readln(zQb[j,k]);
               writeln;
           end; { for }
       write(' Pasul de parcurgere este (0.05) . . . ');readln(pas);
       write(' Sa salvez datele introduse? (d/n) ');readln(chr);chr := upcase(chr);
       if chr='D' then
          begin
            writeln(' Numele fisierului va fi . . . ');readln(nume);
            assign(f,nume);
            rewrite(f);
            write(f,xQb,yQb,zQb);
            close(f);
          end
       end; { case C }
  'F'  : begin
          write(' Numele fisierului este . . . ');readln(nume);
          assign(f,nume);
          reset(f);
          read(f,xQb,yQb,zQb);
         end; { case F }
    end; { case }
    pas := 0.1;
 end; { ReadData }

 procedure CalcCoordBazaBezier( var xxQb,yyQb,zzQb : matriceNxN;
                                var xxB, yyB, zzB  : MatriceBaza;
                                p : real );
 var j,k : byte;
     S1,S2,S3,S4 : real;
     SX1,SX2,SX3,SX4, SY1,SY2,SY3,SY4, SZ1,SZ2,SZ3,SZ4 : real;
     ps, pt : real;
 begin
   ps := 0;
   j  := 1;
   repeat
      S1 := -ps*ps*ps + 3*ps*ps - 3*ps + 1;
      S2 := 3*ps*ps*ps - 6*ps*ps + 3*ps*ps;
      S3 := -3*ps*ps*ps + 3*ps*ps;
      S4 := ps*ps*ps;

     SX1 := S1*xxQb[1,1]+S2*xxQb[2,1]+S3*xxQb[3,1]+S4*xxQb[4,1];
     SX2 := S1*xxQb[1,2]+S2*xxQb[2,2]+S3*xxQb[3,2]+S4*xxQb[4,2];
     SX3 := S1*xxQb[1,3]+S2*xxQb[2,3]+S3*xxQb[3,3]+S4*xxQb[4,3];
     SX4 := S1*xxQb[1,4]+S2*xxQb[2,4]+S3*xxQb[3,4]+S4*xxQb[4,4];

     SY1 := S1*yyQb[1,1]+S2*yyQb[2,1]+S3*yyQb[3,1]+S4*yyQb[4,1];
     SY2 := S1*yyQb[1,2]+S2*yyQb[2,2]+S3*yyQb[3,2]+S4*yyQb[4,2];
     SY3 := S1*yyQb[1,3]+S2*yyQb[2,3]+S3*yyQb[3,3]+S4*yyQb[4,3];
     SY4 := S1*yyQb[1,4]+S2*yyQb[2,4]+S3*yyQb[3,4]+S4*yyQb[4,4];

     SZ1 := S1*zzQb[1,1]+S2*zzQb[2,1]+S3*zzQb[3,1]+S4*zzQb[4,1];
     SZ2 := S1*zzQb[1,2]+S2*zzQb[2,2]+S3*zzQb[3,2]+S4*zzQb[4,2];
     SZ3 := S1*zzQb[1,3]+S2*zzQb[2,3]+S3*zzQb[3,3]+S4*zzQb[4,3];
     SZ4 := S1*zzQb[1,4]+S2*zzQb[2,4]+S3*zzQb[3,4]+S4*zzQb[4,4];

      pt := 0;
      k  := 1;
      repeat

        xxB[j,k] := (-SX1+3*SX2-3*SX3)*pt*pt*pt +
                  (3*SX1-6*SX2+3*SX3)*pt*pt   +
                  (-3*SX1+3*SX2)*pt           +  SX1 ;
        yyB[j,k] := (-SY1+3*SY2-3*SY3)*pt*pt*pt +
                  (3*SY1-6*SY2+3*SY3)*pt*pt   +
                  (-3*SY1+3*SY2)*pt           +  SY1 ;
        zzB[j,k] := (-SZ1+3*SZ2-3*SZ3)*pt*pt*pt +
                  (3*SZ1-6*SZ2+3*SZ3)*pt*pt   +
                  (-3*SZ1+3*SZ2)*pt           +  SZ1 ;

        k := k + 1;
       pt := pt+ pas;
     until   pt >= 1;
     j  := j + 1;
     ps := ps+ pas;
   until ps >= 1;
 end; { CalcCoordBazaBezier }

 procedure Init;
 var GraphDriver, GraphMode : integer;
 begin
   GraphMode   := 1;
   GraphDriver := 3;
   InitGraph( GraphDriver, GraphMode, 'c:\');
   x0 := GetMaxX div 2;
   y0 := GetMaxY div 2;
 end;  { Init }

 procedure Proiecteaza( var xx, yy,zz : MatriceBaza; var qq, ww : MatrInt );
 var  j,k  : byte;
      z0   : word;
      Fz   : real;  { Factorul Z ce apare in formulele de proiectare }
 begin
   for j := 1 to 10 do
       for k := 1 to 10 do begin
          z0    := 1000;
          Fz    := z0/(z0-zz[j,k]);
         qq[j,k] := trunc( xx[j,k]*Fz );
         ww[j,k] := trunc( yy[j,k]*Fz );
       end; { for }
  end;  { Proiecteaza }

  procedure Roteste( var xxB,yyB,zzB : MatriceBaza; a,b,c : real );
  var   u : real;
       sa,ca,sb,cb,sc,cc : real;
       j,k : byte;
  begin
     { Trecem unghiurile din grade in radiani }
     u  := pi/180;    a := a*u;      b  := b*u;    c:= c*u;
     ca := cos(a);   cb := cos(b);   cc := cos(c);
     sa := sin(a);   sb := sin(b);   sc := sin(c);
     for j := 1 to 10 do
         for k := 1 to 10 do
         begin
           if a<>0 then
           begin
             u := yyB[j,k];
             yyB[j,k] := u*cb + zzB[j,k]*sa;
             zzB[j,k] := zzB[j,k]*ca - u*sa
           end;
           if b<>0 then
           begin
             u := zzB[j,k];
             zzB[j,k] := u*cb + xxB[j,k]*sb;
             xxB[j,k] := xxB[j,k]*cb - u*sb
           end;
           if c<>0 then
           begin
             u := xxB[j,k];
             xxB[j,k] := u*cc + yyB[j,k]*sc;
             yyB[j,k] := yyB[j,k]*cc - u*sc
           end
         end    { for }
     end; { Roteste }

  procedure SalveazaCoordBaza( var xxxB,yyyB,zzzB : MatriceBaza;
                               var xxxS,yyyS,zzzS : MatriceBaza);
  var j,k : byte;
  begin
    for j := 1 to 10 do
        for k := 1 to 10 do
        begin
          xxxS[j,k] := xxxB[j,k];
          yyyS[j,k] := yyyB[j,k];
          zzzS[j,k] := zzzB[j,k]
        end
  end;  { SalveazaCoordBaza }

  procedure RestaureazaCoordBaza( var xxS,yyS,zzS : MatriceBaza;
                                  var xxB,yyB,zzB : MatriceBaza);
  var  j,k : byte;
  begin
    for j := 1 to 10 do
        for k := 1 to 10 do
        begin
          xxB[j,k] := xxS[j,k];
          yyB[j,k] := yyS[j,k];
          zzB[j,k] := zzS[j,k]
        end
   end; { RestaureazaCoordBaza }

 procedure Traseaza( var qqq, www : MatrInt );
 var              j,k : byte;
       GraphX, GraphY : word;
       sc             : real;
 begin
   sc := 1.5;
   j := 0;
   repeat
     j := j+1;
     k := 0;
     repeat
       k := k+1;
       GraphX := trunc( qqq[j,k] * sc ) + x0;
       GraphY := trunc( www[j,k] * sc ) + y0;
       if ( (j=1) and (k=1) ) or ( k=1 ) then MoveTo( GraphX, GraphY )
                                         else LineTo( GraphX, GraphY );
     until k = 10;
   until j = 10;

   k := 0;
   repeat
     k := k+1;
     j := 0;
     repeat
       j := j+1;
       GraphX :=  trunc( qqq[j,k] * sc ) + x0;
       GraphY :=  trunc( www[j,k] * sc ) + y0;
       if ( (j=1) and (k=1) ) or ( j=1 ) then MoveTo( GraphX, GraphY )
                                         else LineTo( GraphX, GraphY );
     until j = 10;
   until k = 10;
 end;  { Traseaza }


begin  { main }
   ReadData;
   CalcCoordBazaBezier( xQb,yQb,zQb, xB,yB,zB, pas );
   SalveazaCoordBaza( xB,yB,zB,  xS,yS,zS );
   Init;
   page := 0;
   arg  := 0;
   repeat
     SetActivePage( page );
     SetVisualPage( 1-page);
     ClearDevice;
     Roteste( xB,yB,zB,  0,0,arg );
     Proiecteaza( xB,yB,zB,  qB,wB );
     Traseaza( qB,wB );
     RestaureazaCoordBaza( xS,yS,zS,  xB,yB,zB );
     arg := arg+2;
     page := 1-page;
     if arg = 360 then arg := 0;
   until  KeyPressed;
   repeat until KeyPressed;
end.   { main }

