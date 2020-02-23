  program Simplu ;
  uses    Crt,Graph ;
  var     GraphDriver : integer;
          GraphMode   : integer;
          CenterX     : word   ;
          CenterY     : word   ;
          ch          : char   ;
  procedure Init;
  begin
    GraphDriver := Detect;
    InitGraph( GraphDriver, GraphMode, '');
  end;

  procedure Radar( var x0,y0 : word);
  var i,j,R : byte;
      arg   : real;
      X,Y   : word;
  begin
    ClearDevice;
    R := 200;
    MoveTo( x0,y0 );
    repeat
      arg:=0;
        repeat
           arg := arg+0.03;
           X := trunc(R*cos(arg))+x0;
           Y := trunc(R*sin(arg))+y0;
           SetColor(14);
           Line(x0,y0,X,Y);
           SetColor(0);  Delay(15);
           Line(x0,y0,X,Y);
        until arg>=6.28;
    until KeyPressed;
  end;

  procedure Patrat( var x0,y0 : word );
  var  i,j,R         : byte ;
       X1,Y1,X2,Y2   : word ;
       arg           : real ;
  begin
      ClearDevice;
      R := 200;
      Moveto(x0,y0);
    repeat
      arg := 0;
       repeat
          arg := arg+0.05;
          X1 := trunc(R*cos(arg))+x0;
          Y1 := trunc(R*sin(arg))+y0;
          X2 := trunc(R*cos(arg+pi))+x0;
          Y2 := trunc(R*sin(arg+pi))+y0;
          SetColor(14);
          Rectangle(X1,Y1,X2,Y2);
          SetColor(0); Delay(25);
          Rectangle(X1,Y1,X2,Y2);
       until arg>=200*pi;
    until KeyPressed;
  end; { patrat }

  begin
   Init;
    CenterX  := GetMaxX div 2;
    CenterY  := GetMaxY div 2;
    Radar(  CenterX,CenterY );
    Patrat( CenterX,CenterY );
    CloseGraph;
  end.
