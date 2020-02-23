  program AranjamenteCuRepetitie;
  uses Crt;
  const MaxCar = 10;
  var   text   : string[10]   ;
        indici : array [1..2] of integer ;
        m,n    : integer                      ;
        ch     : char                         ;

  procedure Tipareste;
  var i:integer    ;
    begin
      for i:=1 to m do
        write(text[indici[i]]);
        writeln;Delay(50);
  end;  { Tipareste }

  procedure Aranj ( k:integer );
  var j,t:integer;
  begin
    if k<m then
       for j:=1 to n do begin
           indici[k+1]:=j;
           t:=0;
           repeat
             t:=t+1
           until indici[t]=j;
           if t=k+1 then Aranj(k+1);
       end
       else Tipareste;
  end; { Aranj }

  begin { main }
    write(' Nr. caractere: ');read(n);
    write(' Luate cite : ');read(m);
    if (n>10) or (m>n) then
       write(' Date eronate ! ')
    else begin
         write(' textul : ');
         readln;
         read(text);
         writeln;
         Aranj(0);
         end    ;
         ch := ReadKey;
  end.
