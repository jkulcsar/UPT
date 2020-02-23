  program Okos;
  uses    Crt;
  const   n      = 4;
  type    matrix = array[1..n,1..n] of real;
  var     A  : matrix;
          ch : char;
          D  : real;


  procedure ReadMatrix( var X : matrix );
  var ii,jj : byte;
  begin
       X[1,1] := 2;     X[1,2] := 1;    X[1,3] := 11;    X[1,4] := 0;
       X[2,1] := 4;     X[2,2] := 1;    X[2,3] := 2;    X[2,4] := 1;
       X[3,1] := 7;     X[3,2] := 3;    X[3,3] := 3;    X[3,4] := 3;
       X[4,1] := 2;     X[4,2] := 7;    X[4,3] := 1;    X[4,4] := 79;
  end; { ReadMatrix }

  procedure WriteMatrix( var X : matrix );
  var ii,jj : byte;
  begin
       for ii := 1 to n do begin
           writeln;
           for jj := 1 to n do write(X[ii,jj]:10:2);
       end;
  end;  { WriteMatrix }

  procedure ComputeTransp( var X : matrix );
  var ii,jj : byte;
      term  : real;
  begin
     ii := 1;
     repeat
        jj := ii;
        repeat
           term := X[ii,jj];
           X[ii,jj] := X[jj,ii];
           X[jj,ii] := term;
           jj := jj + 1;
        until jj = (n+1);
        ii := ii + 1;
     until ii = (n+1);
  end; { ComputeTransp }

  procedure ComputeDet( var X : matrix );
  var i,j,k,l : byte;
      Op      : real;
  begin
      i := 1;
      j := 1;
      repeat
         l := i+1;
         repeat
            k  := j;
            Op := X[l,k]/X[i,j];
            repeat
               X[l,k] := X[i,k]*Op - X[l,k];
               k := k + 1;
            until k = (n+1);
            l := l + 1;
         until l = (n+1);
         i := i+1; j := j+1;
      until i=n;
      i := 1 ; j := 1; D := 1;
      repeat
         D := D*X[i,j];
         i := i+1; j := j+1;
     until i=(n+1);
     writeln;
     writeln;
     writeln(' Determinantul este   D  = ',D:10:0);
  end;

 procedure ComputeInverse( var X : matrix );
 var Gamma, Inter : matrix;
     i1,j1,i2,j2,p,q : byte;
     semn : integer;

 begin
    for i1 := 1 to n do
        for j1 := 1 to n do begin
               p := 1; semn := -1
               for i2 := 1 to n do
                   for j2 := 1 to n do begin
                          q := 1;
                          if i2<>i1 then begin
                             p := p + 1;
                             if j2<>j1 then begin
                                q := q + 1;
                                Inter[p,q] := X[i1,j1];
                             end;
                          end;
                    end; { for j2 }
        ComputeDet( Inter );
        Gamma[i1,j1] := semn * D;
        end; { for j1 }

 end;

  begin  { main }
         ReadMatrix( A );
         ClrScr;
         WriteMatrix( A );
         writeln;
         writeln;
         ComputeInverse( A );
         writeln;
{         WriteMatrix( A );}
         ch := ReadKey;
  end.   { main }