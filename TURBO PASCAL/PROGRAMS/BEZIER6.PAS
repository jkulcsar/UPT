program matrix ;
uses Graph, Crt, MyGraph ;
var       xQb, yQb, zQb : MatriceData;
                  x0,y0 : word;
            xB ,yB ,zB  : MatriceBaza;
            xS ,yS ,zS  : MatriceBaza;
                qB, wB  : MatriceIntr;
              page, arg : word;
                    pas : real;
                    j,k : byte;

 procedure ReadData;
 var     j,k : byte;
     ch, chr : char;
        nume : string[20];
           f : file of MatriceData;
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
       writeln;
       writeln(' Citeva exemple de pasi de parcurgere recomandabile : ');
       writeln(' Pasul de   0.1    pentru o retea de 10x10 ');
       writeln(' Pasul de   0.05   pentru o retea de 20x20 ');
       writeln(' Pasul de   0.04   pentru o retea de 25x25 ');
       writeln(' Pasul de   0.033  pentru o retea de 30x30 ');
       write(' Pasul de parcurgere este  . . . ');readln(pas);
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
          close(f);
          write(' Pasul de parcurgere este . . . '); readln( pas );
         end; { case F }
    end; { case }
 end; { ReadData }

begin  { main }
   ReadData;
   CalcVectorSinCos;
   CalcCoordBazaSuprafataBezier( xQb,yQb,zQb, xB,yB,zB, pas );
   SalveazaCoordBazaSuprafata( xB,yB,zB,  xS,yS,zS, marime );
   Init;
   SetActivePage( 0 );
      Rectangle( 0,0,540,300 );
   SetActivePage( 1 );
      Rectangle( 0,0,540,300 );
   page := 0;
   arg  := 0;
   repeat
     SetActivePage( page );
     SetVisualPage( 1-page);
     SetViewPort( 1,1,539,299, true );
     ClearViewPort;
     RotesteSuprafata( xB,yB,zB,   marime,  arg,arg,arg );
     ProiecteazaSuprafata( xB,yB,zB,  qB,wB,  marime );
     TraseazaSuprafata( qB,wB,  marime );
     RestaureazaCoordBazaSuprafata( xS,yS,zS,  xB,yB,zB, marime );
     arg := arg+2;
     page := 1-page;
     if arg = 360 then arg := 0;
   until  KeyPressed;
   repeat until KeyPressed;
end.   { main }

