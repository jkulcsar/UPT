  program NrDistincte;
  uses Crt;
  type leg      = ^numar;
       numar    =  record
                     cheie : integer ;
                     urm   : leg     ;
                   end;
  var  prim, p : leg ;
       nr      : integer;

  function Cauta( x:integer ) : boolean ;
  var p     : leg     ;
      gasit : boolean ;
  begin  { Cauta }
    p     := prim  ;
    gasit := false ;
    while (p<>nil) and not gasit do
          if p^.cheie = x then gasit := true;
    p     := p^.urm ;
    cauta := gasit  ;
  end;   { Cauta }

  begin   { main }
      ClrScr;
      writeln( 'Introduceti lista de numere . . . ');
    { Crearea listei }
      prim := nil ;
      read( nr );
      while nr<>0 do begin
        if not Cauta( nr ) then begin
           new( p );
           p^.cheie := nr   ;
           p^.urm   := prim ;
        end;
        read( nr );
      end;  { while }
      p := prim;
      while p<>nil do begin
            writeln( p^.cheie );
            p := p^.urm ;
      end
  end.    { main }





