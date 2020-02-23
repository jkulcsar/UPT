  program Prime ;
  uses Crt ;
  var
    A, B  ,k       : integer ;
    n,i,j,NrPrim : integer ;
  begin
   ClrScr ;
    writeln(' Intervalul : ') ;
    write(' A = ') ; readln(A);
    write(' B = ') ; readln(B);
     NrPrim := 0 ;
          K := 0 ;
       for n := A to B do  begin
           k:=0;
         j := trunc(sqrt(n));
           for i := 2 to j do
             begin
              if n/i =  trunc( n/i ) then K := 1 ; 
             end;
             if k=0 then begin
                nrprim:=nrprim+1;
                writeln(n);
             end;
             i:=i+1;
       end;
     writeln (' Numarul numerelor prime = ', NrPrim );
     repeat until KeyPressed ;
  end.
