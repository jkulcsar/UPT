  program Traiectorii;
  uses    Crt, Graph;
  const   tacc =  1.5;
          T1   =  10;    { Limita maxima aferenta miscarii }


  var     x0,y0,MaxX, MaxY : word;
          T0               : real;
          A, B, C, D       : real;
          ScalX, ScalY     : real;
          GraphX, GraphY   : word;
          t, pas           : real;

  function Q( t:real ):real;
  var h : real;
      dC, dB : real;
  begin
    h :=  (t+tacc)/(2*tacc);
   dC := C-B;
   dB := A-B;
    Q :=  (    (dC*tacc/T1+dB)*(2-h)*h*h-2*dB     )*h + B + dB ;
{    Q := A*t*t*t*t + B*t*t*t + C*t*t + D*t ;}
  end;

  procedure Init;
  var       GraphDriver, GraphMode : integer;
  begin
       GraphDriver := Detect;
       InitGraph( GraphDriver, GraphMode, 'c:\' );
       MaxX := GetMaxX ;
       MaxY := GetMaxY ;
       x0   := (MaxX    div 2) ;
       y0   := (MaxY    div 2) ;
  end;      { Init }

  procedure TraseazaAxe;
  begin
    SetColor( LightRed );
    MoveTo( x0,0 ); LineTo(x0, MaxY );
    MoveTo( 0,y0 ); LineTo(MaxX,y0  );
    SetColor( White );
  end;

  procedure ReadData;
  begin
        ClrScr;
        writeln(' Valorile punctelor : ');
        write(' A = ');readln(A);
        write(' B = ');readln(B);
        write(' C = ');readln(C);
        write(' Pasul de parcurgere : ');readln(pas);
        ScalX := 60; ScalY := 20;
  end;  { ReadData }

  procedure TraseazaGrafic;
  var p : real;
  begin
       T0:= - tacc;
       p := T0;
       GraphX := round(p*ScalX)    + x0;
       GraphY := round(Q(p)*ScalY) + y0;
       MoveTo( GraphX, GraphY );
       repeat
         p := p + pas;
         if (Q(p)>=A) and (Q(p)<=C) then
            begin
               GraphX := round(p*ScalX)    + x0;
               GraphY := round(Q(p)*ScalY) + y0;
               LineTo( GraphX, GraphY );
            end;
       until p >= T1;
  end;

  begin  { main }
         ReadData;
         Init;
         TraseazaAxe;
         TraseazaGrafic;
         repeat until KeyPressed;
         CloseGraph;
  end.