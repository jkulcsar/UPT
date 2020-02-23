  program Hermite;
  uses    Graph, Crt, MyGraph;
  var     MaxX, MaxY : word;
          x0, y0     : word;
          xAxe, yAxe, zAxe  : array[1..3] of real;
          xSAxe,ySAxe,zSAxe : array[1..3] of real;
          xA,yA,zA,lA,mA,nA : real;
          xB,yB,zB,lB,mB,nB : real;
          GraphX, GraphY    : word;
          q, w              : VectorIntr;
          pas               : real;
          xH, yH, zH        : VectorBaza;
          xHS, yHS, zHS     : VectorBaza;
          i                 : byte;
          arg               : real;
          page              : byte;

  procedure ReadData;
  var       f :  file of real;
            nume : string[25];
            ch   : char;
            w    : byte;
  begin
    ClrScr;
    writeln(' C I T I R E     D E    D A T E  pentru curba  H E R M I T E '); writeln;
    write(' De unde citesc datele ?  ( F/C ) '); readln(ch); ch := upcase(ch);
   case ch of
    'C': begin
          ClrScr;
          writeln(' Introduceti coordonatele primului punct de control . . . ');
          write(' xA = '); readln(xA);
          write(' yA = '); readln(yA);
          write(' zA = '); readln(zA);
          writeln(' Parametri tangentelor in acest punct sint . . . ');
          write(' lA = '); readln(lA);
          write(' mA = '); readln(mA);
          write(' nA = '); readln(nA);
          writeln;
          writeln(' Introduceti coordonatele celui de al doilea punct de control . . . ');
          write(' xB = '); readln(xB);
          write(' yB = '); readln(yB);
          write(' zB = '); readln(zB);
          writeln(' Parametri tangentelor in aceste puncte sint . . . ');
          write(' lB = '); readln(lB);
          write(' mB = '); readln(mB);
          write(' nB = '); readln(nB);
          writeln;
          write(' Pasul de parcurgere  (0.1)  . . . ');readln( pas );
          ClrScr;
          write(' Sa salvez datele introduse? (d/n) '); readln(ch);ch:=upcase(ch);
          if ch = 'D' then
                begin
                  writeln(' Introduceti numele fisierului unde sa salvez datele . . . ');
                  readln(nume);
                  assign( f, nume);
                  rewrite(f);
                  write(f,xA,yA,zA,lA,mA,nA,xB,yB,zB,lB,mB,nB,pas);
                  close(f);
                end; { if }
         end;
    'F': begin
          ClrScr;
          writeln(' Introduceti numele fisierului din care sa citesc datele . . . ');
          readln( nume );
          assign( f, nume );
          reset( f );
          read(f,xA,yA,zA,lA,mA,nA,xB,yB,zB,lB,mB,nB,pas);
          close( f );
         end;
   end; { case }

{Se citesc in mod automat virfurile sistemului de axe si se salveaza acestea}
   xAxe[1] := 200; yAxe[1] := 0;    zAxe[1] := 0;
   xAxe[2] := 0;   yAxe[2] := 200;  zAxe[2] := 0;
   xAxe[3] := 0;   yAxe[3] := 0;    zAxe[3] := 200;
   for w := 1 to 3 do begin
       xSAxe[w]:=xAxe[w]; ySAxe[w]:=yAxe[w]; zSAxe[w]:=zAxe[w]; end;

  end; { ReadData }
  procedure RestaureazaAxe;
  var ww : byte;
  begin
    for ww := 1 to 3 do begin
        xAxe[ww] := xSAxe[ww];
        yAxe[ww] := ySAxe[ww];
        zAxe[ww] := zSAxe[ww];
    end { for }
  end; { RestaureazaAxe }

  procedure TraseazaAxe( var v1, v2, v3 : real );
  begin
    Proiecteaza( v1, v2, v3 );
    GraphX := q + x0;
    GraphY := w + y0;
    Line(x0,y0,GraphX,GraphY);
  end;  { TraseazaAxe }


  begin { main }
    ReadData;
    CalcCoordBazaCurbaHermite( xA, yA, zA, lA, mA, nA,
                               xB, yB, zB, lB, mB, nB,
                               xH, yH, zH, pas );
    SalveazaCoordBazaCurba( xH,yH,zH, xHS,yHS,zHS, marime );
    Init;
    repeat
        arg  := 0;
        page := 0;
        repeat
          SetVisualPage( 1-page );
          SetActivePage( page );
          ClearDevice;
          SetColor( White );
          RotesteCurba( xH, yH, zH, marime, arg, arg+10, arg+20 );
          ProiecteazaCurba( xH, yH, zH, qH, wH, marime );
          TraseazaCurba( qH, wH, marime );
          arg := arg + 2;
          page := 1-page;
          RestaureazaCoordBazaCurba( xHS,yHS,zHS, xH,yH,zH, marime );
          if  arg >= 360 then arg := 0;
      until KeyPressed;
    repeat until KeyPressed;
  end.  { main }