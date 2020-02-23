program matrix ;
uses Graph, Crt ;
type         matriceNxN = array[1..4,1..4] of real ;
            MatriceBaza = array[1..20,1..20] of real;
                MatrInt = array[1..20,1..20] of integer;
                 vector = array[1..20] of real;

var            S, Mb, T : matriceNxN;
          xQb, yQb, zQb : matriceNxN;
     {Atentie! Aici T nu este matricea propriuzisa ci transpusa originalului!}

                  x0,y0 : word;
               xB,yB,zB : MatriceBaza;
                  qB,wB : MatrInt;
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
    end { case }
 end; { ReadData }

 procedure Inmulteste(     m,n,p : byte;
                       var   X,Y : matriceNxN;
                       var     Z : matriceNxN);
 var       ii,jj,kk : byte;
 begin
  for ii:=1 to m do
   for jj:=1 to p do begin
    Z[ii,jj]:=0;
    for kk:=1 to n do
     Z[ii,jj]:= Z[ii,jj]+X[ii,kk]*Y[kk,jj];
   end;
 end; { Inmulteste }

 procedure CalcCoordBazaBezier(  xQb,yQb,zQb : matriceNxN;
                                          pB : real;
                                var  x, y, z : MatriceBaza);
 var   ps, pt : real;
            I : matriceNxN;
          j,k : byte;
 begin
 repeat
    ps := 0;
     j := 1;
    repeat
      pt := 0;
       k := 1;
     { Declararea matricii Mb }
      Mb[1,1] := -1; Mb[1,2] :=  3; Mb[1,3] := -3; Mb[1,4] :=  1;
      Mb[2,1] :=  3; Mb[2,2] := -6; Mb[2,3] :=  3; Mb[2,4] :=  0;
      Mb[3,1] := -3; Mb[3,2] :=  3; Mb[3,3] :=  0; Mb[3,4] :=  0;
      Mb[4,1] :=  1; Mb[4,2] :=  0; Mb[4,3] :=  0; Mb[4,4] :=  0;

     { Declararea matricii S  }
      S[1,1] := ps*ps*ps; S[1,2] := ps*ps; S[1,3] := ps; S[1,4] := 1;
     { Declararea matricii T  }
      T[1,1] := pt*pt*pt; T[2,1] := pt*pt; T[3,1] := pt; T[4,1] := 1;

      Inmulteste( 1,4,4, S,Mb,  I );
      Inmulteste( 1,4,4, I,xQb, I );
      Inmulteste( 1,4,4, I,Mb,  I );
      Inmulteste( 1,4,1, I,T,   I );
      x[j,k] := I[1,1];

      Inmulteste( 1,4,4, S,Mb,  I );
      Inmulteste( 1,4,4, I,yQb, I );
      Inmulteste( 1,4,4, I,Mb,  I );
      Inmulteste( 1,4,1, I,T,   I );
      y[j,k] := I[1,1];

      Inmulteste( 1,4,4, S,Mb,  I );
      Inmulteste( 1,4,4, I,zQb, I );
      Inmulteste( 1,4,4, I,Mb,  I );
      Inmulteste( 1,4,1, I,T,   I );
      z[j,k] := I[1,1];

      pt := pt + pB;
       k := k  + 1;
   until pt = ( 1-pB );
   j  := j  + 1;
   ps := ps + pB;
 until ps = ( 1-pB );
 end;  { CalcCoordBazaBezier }

 procedure Init;
 var GraphDriver, GraphMode : integer;
 begin
   GraphDriver := Detect;
   InitGraph( GraphDriver, GraphMode, 'c:\');
   x0 := GetMaxX div 2;
   y0 := GetMaxY div 2;
 end;  { Init }

 procedure Proiecteaza( var x,y,z : MatriceBaza; var q,w : MatrInt );
 var   j, k : byte;
       z0   : word;
 begin
   z0    := 1000;
   for j := 1 to 20 do
       for k := 1 to 20 do begin
           q[j,k] := trunc( x[j,k]*(z0/(z0-z[j,k])) );
           w[j,k] := trunc( y[j,k]*(z0/(z0-z[j,k])) );
       end { for }
  end;  { Proiecteaza }


 procedure Traseaza( var q,w : MatrInt );
 var              j,k : byte;
       GraphX, GraphY : word;
 begin
   j := 0;
   repeat
     j := j+1;
     k := 0;
     repeat
       k := k+1;
       GraphX := q[j,k] + x0;
       GraphY := w[j,k] + y0;
       if ( (j=1) and (k=1) ) or ( k=1 ) then MoveTo( GraphX, GraphY )
                               else LineTo( GraphX, GraphY );
     until k = 20;
   until j = 20;

   k := 0;
   repeat
     k := k+1;
     j := 0;
     repeat
       j := j+1;
       GraphX := q[j,k] + x0;
       GraphY := w[j,k] + y0;
       if ( (j=1) and (k=1) ) or ( j=1 ) then MoveTo( GraphX, GraphY )
                               else LineTo( GraphX, GraphY );
     until j = 20;
   until k = 20;
 end;  { Traseaza }


begin  { main }
   ReadData;
   CalcCoordBazaBezier( xQb,yQb,zQb, pas, xB,yB,zB );
   for j := 1 to 20 do
       for k := 1 to 20 do Proiecteaza( xB,yB,zB, qB,wB );
   Traseaza( qB, wB );
   repeat until KeyPressed;
end.   { main }

