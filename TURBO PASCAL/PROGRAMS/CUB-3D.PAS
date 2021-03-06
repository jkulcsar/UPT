  program Grafica;
  uses Graph, Crt;
  type Tablou     = array[1..8] of integer;
  var x0,y0       : word    ;
      MaxX, MaxY  : word    ;
      GraphMode   : integer ;
      GraphDriver : integer ;
      a1,b1,c1    : real    ;
      arg         : real    ;
      x,y,z,q,w   : tablou  ;
      x1,y1,z1    : tablou  ;
      d           : byte    ;

  procedure Init;
  begin
    GraphDriver := Detect;
    InitGraph( GraphDriver,GraphMode,'d:\' );
    SetColor( 14 );
    SetBkColor( 0 );
    MaxX := GetMaxX;
    MaxY := GetMaxY;
    x0   := MaxX div 2;
    y0   := MaxY div 2;
  end;  { Init }

  procedure DrawBorder;
  var ViewPort : ViewPortType;
  begin
    SetLineStyle( SolidLn, 0, NormWidth );
    Rectangle(0,0,2*x0,2*y0);
  end;  { DrawBorder }

  procedure FullPort;
  begin
    SetViewPort( 0, 0, MaxX, MaxY, ClipOn );
  end;  { FullPort }

  procedure MainWindow( Header:string );
  begin
    ClearDevice;
    SetTextStyle( DefaultFont, HorizDir, 1 );
    SetTextJustify( CenterText, TopText );
    FullPort;
    OutTextXY( x0, 2, Header );
    SetViewPort( 0, TextHeight('M')+4, MaxX, MaxY-(TextHeight('M')+4),ClipOn );
    DrawBorder;
    SetViewPort( 1, TextHeight('M')+5, MaxX-1, MaxY-(TextHeight('M')+5),ClipOn );
  end;  { MainWindow }

  procedure StatusLine( Msg:string );
  begin
    FullPort;
    SetTextStyle( DefaultFont, HorizDir, 1 );
    SetTextJustify( CenterText, TopText );
    SetLineStyle( SolidLn, 0, NormWidth );
    SetFillStyle( EmptyFill, 0 );
    Bar( 0, MaxY-(TextHeight('M')+4), MaxX, MaxY );
    Rectangle( 0, MaxY-(TextHeight('M')+4),MaxX,MaxY);
    OutTextXY( x0, MaxY-(TextHeight('M')+2),Msg);
    SetViewPort( 1, TextHeight('M')+5, MaxX-1,MaxY-(TextHeight('M')+5), ClipOn);
  end; { StatusLine }

  procedure WaitToGo;
  const     Esc = #27;
  var       ch  : char;
  begin
    StatusLine(' Esc aborts ... ');
    repeat until KeyPressed;
    ch := ReadKey;
    if ch = #0  then ch := ReadKey;
    if ch = Esc then Halt(0) else ClearDevice;
  end;      { WaitToGo }

  procedure CitFisiere;
  var Fisier1,Fisier2,Fisier3 : file of integer;
      i                       : byte           ;
      begin
        assign( Fisier1, 'd:\Coord-X.dta' );
        reset( Fisier1 );
        for i := 1 to 8 do read( Fisier1,x[i] );
        close( Fisier1 );
        assign( Fisier2, 'd:\Coord-Y.dta' );
        reset( Fisier2 );
        for i := 1 to 8 do read( Fisier2,y[i] );
        close( Fisier2 );
        assign( Fisier3, 'd:\Coord-Z.dta');
        reset( Fisier3 );
        for i := 1 to 8 do read( Fisier3,z[i] );
        close( Fisier3 );

      for i:=1 to 8 do begin
          x1[i] := x[i];
          y1[i] := y[i];
          z1[i] := z[i];
     end;

   end;  { CitFisier }

  procedure Roteste1( a,b,c : real );
  var Xt,Yt,Zt : integer;
      i        : byte   ;
      alfa     : array[1..3,1..3] of real;
  begin
             a :=  a*pi/180;
             b :=  b*pi/180;
             c :=  c*pi/180;
     alfa[1,1] :=  cos(a)*cos(c)-sin(c)*sin(a)*cos(b);
     alfa[1,2] :=  cos(a)*sin(c)+cos(c)*sin(a)*cos(b);
     alfa[1,3] :=  sin(a)*sin(b);
     alfa[2,1] := -sin(a)*cos(c)-sin(c)*cos(a)*cos(b);
     alfa[2,2] := -sin(a)*sin(c)+cos(c)*cos(a)*cos(b);
     alfa[2,3] :=  sin(b)*cos(a);
     alfa[3,1] :=  sin(c)*sin(b);
     alfa[3,2] := -sin(b)*cos(c);
     alfa[3,3] :=  cos(b);
    for i:=1 to 8 do begin
        Xt := x[i];
        Yt := y[i];
        Zt := z[i];
        x[i] := trunc( xt*alfa[1,1]+yt*alfa[1,2]+zt*alfa[1,3] );
        y[i] := trunc( xt*alfa[2,1]+yt*alfa[2,2]+zt*alfa[2,3] );
        z[i] := trunc( xt*alfa[3,1]+yt*alfa[3,2]+zt*alfa[3,3] );
    end;
  end; { Roteste1 }

  procedure Proiecteaza;
  var i,z0 : word;
  begin
    z0 := 1000;
    for i := 1 to 8 do begin
        q[i] := trunc(  x[i]*(z0/(z0-z[i]))  );
        w[i] := trunc(  y[i]*(z0/(z0-z[i]))  );
    end; { for }
  end; { Proiecteaza }

  procedure Restaureaza;
  var i:byte;
  begin
    for i:=1 to 8 do begin
        x[i] := x1[i];
        y[i] := y1[i];
        z[i] := z1[i];
    end;  { for }
  end;  { Restaureaza }



  procedure Traseaza;
  begin
    MoveTo( x0+q[1],y0+w[1] ); LineTo( x0+q[4],y0+w[4] );
    MoveTo( x0+q[1],y0+w[1] ); LineTo( x0+q[2],y0+w[2] );
    MoveTo( x0+q[1],y0+w[1] ); LineTo( x0+q[5],y0+w[5] );
    MoveTo( x0+q[3],y0+w[3] ); LineTo( x0+q[4],y0+w[4] );
    MoveTo( x0+q[3],y0+w[3] ); LineTo( x0+q[2],y0+w[2] );
    MoveTo( x0+q[3],y0+w[3] ); LineTo( x0+q[7],y0+w[7] );
    MoveTo( x0+q[6],y0+w[6] ); LineTo( x0+q[2],y0+w[2] );
    MoveTo( x0+q[6],y0+w[6] ); LineTo( x0+q[5],y0+w[5] );
    MoveTo( x0+q[6],y0+w[6] ); LineTo( x0+q[7],y0+w[7] );
    MoveTo( x0+q[8],y0+w[8] ); LineTo( x0+q[4],y0+w[4] );
    MoveTo( x0+q[8],y0+w[8] ); LineTo( x0+q[5],y0+w[5] );
    MoveTo( x0+q[8],y0+w[8] ); LineTo( x0+q[7],y0+w[7] );
  end;

  begin  { main }
    ClrScr;
    writeln(' Citesc fisierele . . . ');CitFisiere;
    a1 := 10;
    b1 := 30;
    c1 := 25;
    Init;
    MainWindow( 'This is a cube . . .');
    Statusline( 'Esc aborts  . . .');
    arg := 30;
    repeat
      Roteste1(arg+a1,2*arg+b1,3*arg+c1);
      Proiecteaza;
      SetColor( 14 );
      Traseaza; Delay( 10 );
      arg := arg+1;
      SetColor( 0 );
      Traseaza;
      Restaureaza;
    until KeyPressed;
    WaitToGo;
 end.  { main }

