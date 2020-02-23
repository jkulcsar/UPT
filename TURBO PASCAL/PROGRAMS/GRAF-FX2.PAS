  program Trying;
  uses    Graph,Crt;
  type    vector = array[1..10] of real;
  var     x0,y0                  : word    ;
          GraphX, GraphY         : vector  ;
          GraphDriver, GraphMode : integer ;
          Xmin, Xmax, Xrange,p,pas: real    ;
          i,ScalX,ScalY,Xdiv     : integer ;
          ch                     : char    ;
          c                      : word    ;
          cc                     : string[10];


  function f( x:real ):real;
  begin
    f := ( sin(x)+sin(2*x)+sin(3*x) )*exp( -x/10 )
  end;

  begin
    GraphDriver := Detect;
    GraphMode   := 0;
    InitGraph( GraphDriver, GraphMode, 'c:\' );
    x0     := GetMaxX div 2;
    y0     := GetMaxY div 2;
    Xmin   :=  -3*pi;
    Xmax   :=   16*pi;
    ScalX  := 10;
    ScalY  := 10;
    pas    := 0.1;
    p      := Xmin;
    c      := 1;
    MoveTo( round( (Xmin+p)*ScalX)+x0, round( f( Xmin+p )*ScalY)+y0 );
    repeat
      LineTo( round( (Xmin+p)*ScalX)+x0, round( f( Xmin+p )*ScalY)+y0 );
      c := c+1;
      p := p+pas;
    until p >= Xmax;
    OutTextXY( 10,470,' Marimea vectorului este = ');
    Str(c, cc);
    OutTextXY( 230,470,cc );
    ch := ReadKey;
    CloseGraph
  end.
