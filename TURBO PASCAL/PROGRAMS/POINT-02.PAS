  program PozitieCorespunzatoare;
  type    leg    = ^numar ;
          numar  =  record
                      cheie : integer ;
                      urm   : leg     ;
                    end;
  var     prim    : leg ;

  procedure Inserare( nr : integer );
  var       Curent, p : leg ;
            localizat : boolean ;
      procedure Insert_In_Fata( p:leg );
        begin
          p^.urm := prim ;
          prim   := p;
        end;
  begin  { inserare }
    new(p);
    p^.cheie := nr;
    if prim = nil then Insert_In_Fata( p )
    else if prim^.cheie >= nr then
            Insert_in_Fata











