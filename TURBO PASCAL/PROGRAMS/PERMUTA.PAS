  program Permutare;
  const n=4;
  var i : byte;
      A : array[1..n] of byte;

  procedure Tiparire( n:integer );
  var i:byte;
  begin
    for i:=1 to n do
        write(A[i]:3);
        writeln
  end;   {  Tiparire  }

  procedure Permut( k:integer );
  var i,x :byte;
  begin
    if k=1 then Tiparire( N )
       else begin
              for i:=1 to k do begin
                  x:=A[i];
                  A[i]:=A[k];
                  A[k]:=x;
                  Permut(k-1);
                  x:=A[i];
                  A[i]:=A[k];
                  A[k]:=x
               end
             end
  end; { Permut }

  begin  { main }
    for i:=1 to n do A[i]:=i;
    Permut( N )
  end.