  program Crescator;
  uses    Crt;
  type    leg   = ^numar;
          numar = record
                    cheie : integer;
                    urm   : leg;
                  end;
  var     prim  : leg;

  procedure Inserare( nr:integer );
  var NrCrt,p   : leg;
      localizat : boolean;
      procedure InsertInFata( p:leg );
        begin
          p^.urm := prim;
          prim   := p
        end;
  begin      { Inserare }
    new( p );
    p^.cheie := nr;
    if prim = nil then InsertInFata(p)
    else if prim^.cheie >= nr then InsertInFata(p)
            else begin
                   NrCrt := prim;
                   localizat := false;
                   while ( NrCrt^.urm <> nil ) and ( not localizat ) do
                         if NrCrt^.urm^.cheie >= nr then
                         localizat := true
                         else NrCrt := NrCrt^.urm;
                         { Introducerea elementului in lista }
                         p^.urm := NrCrt^.urm;
                         NrCrt^.urm := p
                 end;
  end; { Inserare }

  begin { main }
  end.  { main }