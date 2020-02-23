  program NrDistincte ;
  uses    Crt ;
  type    leg = ^numar ;
        numar =  record
                   cheie : integer ;
                   urm   : leg     ;
                 end;
  var  prim,p :  leg ;
       nr     :  integer ;

  function Cauta( x:integer ) : boolean ;
  var gasit : boolean ;
      p     : leg     ;
  begin
    gasit := false ;
    p     := prim  ;
    while ( p<>nil ) and not gasit do
          if p^.cheie = x then gasit := true ;
          p := p^.urm ;
    Cauta := gasit ;
  end; { Cauta }

  begin  { main }
    prim := nil ;
    read( nr );
    while nr<>0 do begin
          if not Cauta( nr ) then begin
                                    new( p );
                                    p^.cheie := nr;
                                    p^.urm   := prim;
                                    prim := p
                                  end;
          read( nr )
    end;
    { Tiparirea listei }
    p := prim;
    while p<>nil do begin
                      writeln( p^.cheie );
                      p := p^.urm;
                    end
  end. { main } 


