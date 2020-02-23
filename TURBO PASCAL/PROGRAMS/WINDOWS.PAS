  program Trying;
  uses Crt      ;
  const    orizontala     = #205;   Spatiu = '        ';
           verticala      = #186;
           ColtStingaSus  = #201;
           ColtStingaJos  = #200;
           ColtDreaptaSus = #187;
           ColtDreaptaJos = #188;

           SageataSus     =  72;
           SageataJos     =  80;
           SageataDreapta =  77;
           SageataStinga  =  75;


  var         x1,y1,x2,y2     : word ;
              ch              : char ;

  procedure Fereastra( x1,y1,x2,y2 : integer);
  var i : byte;
  begin
    TextColor(White);
    TextBackground(Black);
    Window(x1,y1,x2,y2);
  { Traseaza liniile orizontale  }
    for i:=1+1 to x2-x1-1 do begin
      GotoXY(i,1); write(orizontala);
      GotoXY(i,y2-y1); write(orizontala);
    end;
  { Traseaza liniile verticale }
    for i:=1+1 to y2-y1-1 do begin
      GotoXY(1,i); write(verticala);
      GotoXY(x2-x1,i); write(verticala);
    end;
  { Deseneaza colturile }
    GotoXY(1,1); write(ColtStingaSus);
    GotoXY(x2-x1,1); write(ColtDreaptaSus);
    GotoXY(x2-x1,y2-y1); write(ColtDreaptaJos);
    GotoXY(1,y2-y1); write(ColtStingaJos);
    Window(x1+2,y1+1,x2-3,y2-2);
  end;  { Fereastra }

  begin { main }
    ClrScr;
    Fereastra(1,1,80,26);
    Fereastra(2,2,56,16);
  {  Fereastra(3,4,55,15);
    Fereastra(2,16,56,24);
    Fereastra(56,2,78,24);}
    repeat
      ch := Readkey;
      write(upcase(ch));
    until ch=#27;
  end.  { main }






