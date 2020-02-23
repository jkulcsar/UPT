program matrix ;
uses Graph, Crt ;
type         matriceNxN = array[1..4,1..4] of real ;
            MatriceBaza = array[1..40,1..40] of real;
                MatrInt = array[1..40,1..40] of integer;
                 vector = array[1..40] of real;

var       xQb, yQb, zQb : matriceNxN;
                  x0,y0 : word;
               x ,y ,z  : MatriceBaza;
                  q, w  : MatrInt;
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
    pas := 0.025;
 end; { ReadData }

 procedure CalcCoordBazaBezier( xQb,yQb,zQb : matriceNxN; pas : real );
 var j,k : byte;
     S1,S2,S3,S4 : real;
     SX1,SX2,SX3,SX4, SY1,SY2,SY3,SY4, SZ1,SZ2,SZ3,SZ4 : real;
     ps, pt : real;
 begin
   ps := 0;
   j  := 1;
   repeat
  {    ClrScr;
      writeln(' Pasul ps este ',ps );   }
      S1 := -ps*ps*ps + 3*ps*ps - 3*ps + 1;
      S2 := 3*ps*ps*ps - 6*ps*ps + 3*ps*ps;
      S3 := -3*ps*ps*ps + 3*ps*ps;
      S4 := ps*ps*ps;

     SX1 := S1*xQb[1,1]+S2*xQb[2,1]+S3*xQb[3,1]+S4*xQb[4,1];
     SX2 := S1*xQb[1,2]+S2*xQb[2,2]+S3*xQb[3,2]+S4*xQb[4,2];
     SX3 := S1*xQb[1,3]+S2*xQb[2,3]+S3*xQb[3,3]+S4*xQb[4,3];
     SX4 := S1*xQb[1,4]+S2*xQb[2,4]+S3*xQb[3,4]+S4*xQb[4,4];

     SY1 := S1*yQb[1,1]+S2*yQb[2,1]+S3*yQb[3,1]+S4*yQb[4,1];
     SY2 := S1*yQb[1,2]+S2*yQb[2,2]+S3*yQb[3,2]+S4*yQb[4,2];
     SY3 := S1*yQb[1,3]+S2*yQb[2,3]+S3*yQb[3,3]+S4*yQb[4,3];
     SY4 := S1*yQb[1,4]+S2*yQb[2,4]+S3*yQb[3,4]+S4*yQb[4,4];

     SZ1 := S1*zQb[1,1]+S2*zQb[2,1]+S3*zQb[3,1]+S4*zQb[4,1];
     SZ2 := S1*zQb[1,2]+S2*zQb[2,2]+S3*zQb[3,2]+S4*zQb[4,2];
     SZ3 := S1*zQb[1,3]+S2*zQb[2,3]+S3*zQb[3,3]+S4*zQb[4,3];
     SZ4 := S1*zQb[1,4]+S2*zQb[2,4]+S3*zQb[3,4]+S4*zQb[4,4];

      pt := 0;
      k  := 1;
      repeat
 {       writeln(' Pasul pt este ',pt );   }

        x[j,k] := (-SX1+3*SX2-3*SX3)*pt*pt*pt +
                  (3*SX1-6*SX2+3*SX3)*pt*pt   +
                  (-3*SX1+3*SX2)*pt           +  SX1 ;
        y[j,k] := (-SY1+3*SY2-3*SY3)*pt*pt*pt +
                  (3*SY1-6*SY2+3*SY3)*pt*pt   +
                  (-3*SY1+3*SY2)*pt           +  SY1 ;
        z[j,k] := (-SZ1+3*SZ2-3*SZ3)*pt*pt*pt +
                  (3*SZ1-6*SZ2+3*SZ3)*pt*pt   +
                  (-3*SZ1+3*SZ2)*pt           +  SZ1 ;

         {    writeln('x[ ',j,k,' ]= ',x[j,k]);
             writeln('y[ ',j,k,' ]= ',y[j,k]);
             writeln('z[ ',j,k,' ]= ',z[j,k]);  }


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
   GraphDriver := Detect;
   InitGraph( GraphDriver, GraphMode, 'c:\');
   x0 := GetMaxX div 2;
   y0 := GetMaxY div 2;
 end;  { Init }

 procedure Proiecteaza;
 var  j,k  : byte;
      z0   : word;
 begin
   for j := 1 to 40 do
       for k := 1 to 40 do begin
          z0    := 1000;
         q[j,k] := trunc( x[j,k]*(z0/(z0-z[j,k])) );
         w[j,k] := trunc( y[j,k]*(z0/(z0-z[j,k])) );
       end; { for }
  end;  { Proiecteaza }


 procedure Traseaza;
 var              j,k : byte;
       GraphX, GraphY : word;
       sc             : byte;
 begin
   sc := 2;
   j := 0;
   repeat
     j := j+1;
     k := 0;
     repeat
       k := k+1;
       GraphX := q[j,k] * sc + x0;
       GraphY := w[j,k] * sc + y0;
       if ( (j=1) and (k=1) ) or ( k=1 ) then MoveTo( GraphX, GraphY )
                                         else LineTo( GraphX, GraphY );
     until k = 40;
   until j = 40;

   k := 0;
   repeat
     k := k+1;
     j := 0;
     repeat
       j := j+1;
       GraphX :=  q[j,k] * sc + x0;
       GraphY :=  w[j,k] * sc + y0;
       if ( (j=1) and (k=1) ) or ( j=1 ) then MoveTo( GraphX, GraphY )
                                         else LineTo( GraphX, GraphY );
     until j = 40;
   until k = 40;
 end;  { Traseaza }


begin  { main }
   ReadData;
   CalcCoordBazaBezier( xQb,yQb,zQb, pas );
   Proiecteaza;
   Init;
   Traseaza;
   repeat until KeyPressed;
end.   { main }

