  program CoordPolare;
  uses    Crt;
  type    p = ^coord;
          coord = record
                    ro, theta : real;
                    legatura  : p
                  end;
  var     urmator, curent : p;
          x,y             : real;
  begin
    { Creadrea listei punctelor }
    ClrScr;
    writeln(' Introduceti coordonatele . . . ');
    read( x,y );  urmator := nil;
    while x<> 0 do begin
          new( curent );    { alocarea nodului }
          { Completarea nodului cu informatii }
          curent^.ro       := sqrt( x*x+y*y );
          curent^.theta    := arctan( y/x );
          curent^.legatura := urmator;
          urmator          := curent;
          read( x,y );
    end; { while }
    { Parcurgerea listei si afisarea continutului nodurilor }
    writeln(' Lista coordonatelor polare ale punctelor este urmatoarea : ');
    while curent <> nil do
          with curent^ do begin
               writeln( ro:6:2, theta:6:2 );
               curent := legatura;
          end;  { with }
  end.