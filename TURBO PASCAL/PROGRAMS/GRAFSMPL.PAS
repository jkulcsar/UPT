  program GraficaSimpla ;
  uses    Crt,Graph     ;
  var     GraphDriver, GraphMode : integer ;
          R, MaxX, MaxY : word ;
          ch            : char ;

  begin
    GraphDriver := Detect;
    InitGraph( GraphDriver, GraphMode, '');
    MaxX := GetMaxX; MaxY := GetMaxY;
    Rectangle(1,1,MaxX,MaxY);
    R := 0;
    repeat
      R := R+2;
      Circle( (MaxX div 2),(MaxY div 2),R);
    until R = 100;
    ch := ReadKey;
  end.