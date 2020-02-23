program matrix ;
uses Graph, Crt, MyGraph ;
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
     Roteste( xB,yB,zB,  0,arg,0 );
     Proiecteaza( xB,yB,zB,  qB,wB );
     TraseazaSuprafata( qB,wB );
     RestaureazaCoordBaza( xS,yS,zS,  xB,yB,zB );
     arg := arg+2;
     page := 1-page;
     if arg = 360 then arg := 0;
   until  KeyPressed;
   repeat until KeyPressed;
end.   { main }

