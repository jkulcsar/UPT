  program Chars;
  uses    Graph,Crt;
  var     MaxX, MaxY : word;



  procedure Initialize;
  var GraphDriver, GraphMode : integer;
  begin
       GraphDriver := Detect;
       InitGraph(GraphDriver,GraphMode,'C:\TP7\BGI');
       MaxX := GetMaxX;
       MaxY := GetMaxY;
  end; { Initialize }

  procedure Characters;
  var i,j,k  : byte;
      litera : char;
  begin
     SetUserCharSize(13,10,15,10);
     SetTextStyle(2,HorizDir,0);
     for i:=0 to 79 do
         for j:=0 to 24 do
             begin
                k := Random(25)+65;
                litera := chr(k);
                OutTextXY(i*(MaxX div 79),j*(MaxY div 24),litera);
             end;
  end; { Characters }

  begin { main }
        Initialize;
        Characters;
        repeat until KeyPressed;
  end.  { main }