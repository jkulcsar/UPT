  program Sortare;
  uses Crt, QuickSor;

  procedure CitDate;
  var i : word;
  begin
    ClrScr;
    for i:=1 to 10000 do begin
                         a[i] := Random(20000);
                      end;
   end;    { CitDate }

   procedure Afiseaza;
   var i  : word;
       ch : char;
   begin
     ClrScr;
     for i:=1 to 10000 do writeln( a[i] );
     write(' Any key continues . . . ');
     ch := ReadKey;
   end;  { Afiseaza }

   begin   { main }
     CitDate;
     Quick_Sort( 1,10000 );
     Afiseaza
   end.
