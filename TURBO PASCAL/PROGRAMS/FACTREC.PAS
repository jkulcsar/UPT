  program Recursiv01;
  uses Crt;
  var  n  : byte;
       ch : char;

  function FactRec( n:byte ) : real;
    begin
      if n<=0 then FactRec := 1 else
      FactRec := n*FactRec(n-1);
    end;

  begin  { main }
    ClrScr;
    write(' Factorial de ... ');readln(n);
    write(' Este ...         ');write( FactRec(n):0:2 );
    ch := ReadKey;
  end.   { main }
