  program Queens;
  uses Crt;
  var  a  : array[1..8]  of boolean ;
       b  : array[2..16] of boolean ;
       c  : array[-7..7] of boolean ;
       x  : array[1..8] of integer  ;
       succes : boolean ;
       i      : integer ;

  procedure Tipareste ;
  var k : integer;
  begin
    for k:=1 to 8 do
        writeln(' Linia: ',k,' Coloana : ',x[k]);
    for k:=1 to 3 do writeln;
  end;    { Tipareste }

  procedure Incearca( i:integer );
  var j : integer ;
      procedure Ocupa;
        begin { Ocupa }
          a[j] := false; b[i+j] := false; c[i-j] := false
        end;  { Ocupa }
      procedure Elibereaza;
        begin { Elibereaza }
          a[j] := true; b[i+j] := true; c[i-j] := true
        end;  { Elibereaza }
      begin   { Incearca   }
        j := 0;
        repeat
          j:=j+1;
          succes := a[j] and b[i+j] and c[i-j];
          if succes then begin
             ocupa;      { Put Queen }
             x[i] := j;  { memoreaza coloana }
             if i<8 then incearca(i+1) else begin
                                              ClrScr;
                                              tipareste;
                                              Delay(8000);end;
             elibereaza { Take Queen }
           end
         until j=8
       end;  { Incearca }

       begin { main     }
         for i:=1 to 8 do a[i] := true;
         for i:=2 to 16 do b[i] := true;
         for i:=-7 to 7 do c[i] := true;
         incearca(1);
       end.