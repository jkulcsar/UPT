  program Hermite;
  uses    Graph, Crt;
  type    vector = array[0..10] of real;
  var     MaxX, MaxY : word;
          x0, y0     : word;
          xAxe, yAxe, zAxe  : array[1..3] of real;
          xSAxe,ySAxe,zSAxe : array[1..3] of real;
          xA,yA,zA,lA,mA,nA : real;
          xB,yB,zB,lB,mB,nB : real;
          GraphX, GraphY    : word;
          q, w              : word;
          pas               : real;
          x , y , z         : vector;
          xS, yS, zS        : vector;
          i                 : byte;
          arg               : real;
          page              : byte;

  procedure Init;
  var GraphDriver, GraphMode : integer;
  begin
    GraphDriver := 3;
    GraphMode   := 1;
    InitGraph( GraphDriver, GraphMode, 'c:\' );
    MaxX := GetMaxX;
    MaxY := GetMaxY;
    x0   := MaxX div 2;
    y0   := MaxY div 2;
    ClearDevice;
  end;  { Init }

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
         end;   end; { case }

{Se citeste in mod automat virfurile sistemului de axe si se salveaza acestea}
   xAxe[1] := 200; yAxe[1] := 0;    zAxe[1] := 0;
   xAxe[2] := 0;   yAxe[2] := 200;  zAxe[2] := 0;
   xAxe[3] := 0;   yAxe[3] := 0;    zAxe[3] := 200;
   for w := 1 to 3 do begin
       xSAxe[w]:=xAxe[w]; ySAxe[w]:=yAxe[w]; zSAxe[w]:=zAxe[w]; end;

  end; { ReadData }

  procedure Proiecteaza( var xP1, yP1, zP1 : real );
  var z0   : word;
      Fp   : real;  { Factorul de proiectare }
  begin
    z0 := 1000;
    Fp := z0/(z0-zP1);
    q  := trunc( xP1*Fp );
    w  := trunc( yP1*Fp );
  end; { Proiecteaza }

  procedure CalcCoordBaza( pas: real );
  var j : byte;
      p : real;
  begin
      j := 0;
      p := 0;
      repeat
        x[j] := ( 2*xA-2*xB+lA+lB )*p*p*p +
                ( -3*xA+3*xB-2*lA-lB)*p*p + lA*p + xA ;
        y[j] := ( 2*yA-2*yB+mA+mB )*p*p*p +
                ( -3*yA+3*yB-2*mA-mB)*p*p + mA*p + yA ;
        z[j] := ( 2*zA-2*zB+nA+nB )*p*p*p +
                ( -3*zA+3*zB-2*nA-nB)*p*p + nA*p + zA ;

 { Se salveaza coordonatele initiale ale curbei in xS, yS, zS }

        xS[j] := x[j];
        yS[j] := y[j];
        zS[j] := z[j];
            j := j+1;
            p := p+pas;
     until p >= 1;
  end; { CalcCoordBaza }

  procedure RestaureazaCurba;
  var ii : byte;
  begin
    for ii := 1 to 10 do begin
        x[ii] := xS[ii];
        y[ii] := yS[ii];
        z[ii] := zS[ii];
    end; { for }
  end;   { RestaureazaCurba }

  procedure RestaureazaAxe;
  var ww : byte;
  begin
    for ww := 1 to 3 do begin
        xAxe[ww] := xSAxe[ww];
        yAxe[ww] := ySAxe[ww];
        zAxe[ww] := zSAxe[ww];
    end { for }
  end; { RestaureazaAxe }

  procedure Roteste(  a,b,c : real; var xP, yP, zP : real);
  var Xt,Yt,Zt : real;
      i        : byte   ;
      alfa     : array[1..3,1..3] of real;
      sa,sb,sc : real;
      ca,cb,cc : real;
  begin
             a :=  a*pi/180;
             b :=  b*pi/180;
             c :=  c*pi/180;
            sa :=  sin(a); ca := cos(a);
            sb :=  sin(b); cb := cos(b);
            sc :=  sin(c); cc := cos(c);
     alfa[1,1] :=  ca*cc-sc*sa*cb;
     alfa[1,2] :=  ca*sc+cc*sa*cb;
     alfa[1,3] :=  sa*sb;
     alfa[2,1] := -sa*cc-sc*ca*cb;
     alfa[2,2] := -sa*sc+cc*ca*cb;
     alfa[2,3] :=  sb*ca;
     alfa[3,1] :=  sc*sb;
     alfa[3,2] := -sb*cc;
     alfa[3,3] :=  cb;
        Xt := xP;
        Yt := yP;
        Zt := zP;
        xP := trunc( xt*alfa[1,1]+yt*alfa[1,2]+zt*alfa[1,3] );
        yP := trunc( xt*alfa[2,1]+yt*alfa[2,2]+zt*alfa[2,3] );
        zP := trunc( xt*alfa[3,1]+yt*alfa[3,2]+zt*alfa[3,3] );
  end; { Roteste }

  procedure TraseazaCurba( var x1, y1, z1 : real );
  begin
      Proiecteaza( x1, y1, z1 );
      GraphX := q + x0;
      GraphY := w + y0;
      LineTo( GraphX,GraphY );
  end; { TraseazaCurba }

  procedure InitCursor( xInit, yInit, zInit : real );
  begin
    Proiecteaza( xInit, yInit, zInit );
    GraphX := q + x0;
    GraphY := w + y0;
    MoveTo( GraphX, GraphY );
  end;  { InitCursor }

  procedure TraseazaAxe( var v1, v2, v3 : real );
  begin
    Proiecteaza( v1, v2, v3 );
    GraphX := q + x0;
    GraphY := w + y0;
    Line(x0,y0,GraphX,GraphY);
  end;  { TraseazaAxe }


  begin { main }
    ReadData;
    CalcCoordBaza( pas );
    Init;
    repeat
        arg  := 0;
        page := 0;
        repeat
          SetVisualPage( 1-page );
          SetActivePage( page );
          ClearDevice;
          SetColor( White );
            i := 0;
            repeat
                i := i+1;
                Roteste( arg, arg+10, arg+20, x[i], y[i], z[i] );
                if i=1 then InitCursor( x[i], y[i], z[i] );
                TraseazaCurba( x[i], y[i], z[i] );
            until i = 10;
            SetColor( LightGray );
            for i := 1 to 3 do begin
                Roteste( arg, arg+10, arg+20, xAxe[i], yAxe[i], zAxe[i] );
                TraseazaAxe( xAxe[i], yAxe[i], zAxe[i] );
            end;  { for }
            arg := arg + 2;
            page := 1-page;
            RestaureazaCurba;
            RestaureazaAxe;
            if  arg >= 360 then arg := 0;
          until KeyPressed;
    until KeyPressed;
    repeat until KeyPressed;
  end.  { main }