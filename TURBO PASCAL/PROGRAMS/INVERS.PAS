  program Okos;
  uses    Crt;
  const   n      = 4;
  type    matrix = array[1..n,1..n] of real;
  var     A, Gamma  : matrix;
          ch : char;
          D  : real;


  procedure ReadMatrix( var X : matrix );
  var ii,jj : byte;
  begin
       X[1,1] := sin(pi/6);     X[1,2] := 78;    X[1,3] := 1;    X[1,4] :=  0;
       X[2,1] := 1;     X[2,2] := cos(pi/7);    X[2,3] := 0;    X[2,4] :=  0;
       X[3,1] := 0;     X[3,2] := 1;    X[3,3] := 0;    X[3,4] :=  10;
       X[4,1] := 0;     X[4,2] := 0;    X[4,3] := 0;    X[4,4] := 1;
  end; { ReadMatrix }

  procedure WriteMatrix( var X : matrix; nn : byte );
  var ii,jj : byte;
  begin
       for ii := 1 to nn do begin
           writeln;
           for jj := 1 to nn do write(X[ii,jj]:10:2);
       end;
  end;  { WriteMatrix }

 procedure ComputeInverse( var X : matrix; var Y : matrix; nn : byte );
 var Gamma, Inter : matrix;
     i1,j1,i2,j2,p,q : byte;
     semn : integer;

     procedure ComputeTransp( var X : matrix; nn : byte );
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
           until jj = (nn+1);
           ii := ii + 1;
        until ii = (nn+1);
     end; { ComputeTransp }

     procedure ComputeDet( var X : matrix; nn : byte );
     var i,j,k,l : byte;
         Op      : real;
     begin
         i := 1;
         j := 1;
         repeat
            if X[i,j]<>0 then begin
               l := i+1;
               repeat
                  k  := j;
                  Op := X[l,k]/X[i,j];
                  repeat
                     X[l,k] := X[i,k]*Op - X[l,k];
                     k := k + 1;
                  until k = (nn+1);
                  l := l + 1;
               until l = (nn+1);
            end; { if }
            i := i+1; j := j+1;
         until i=nn;
         i := 1 ; j := 1; D := 1;
         repeat
            D := D*X[i,j];
            i := i+1; j := j+1;
         until i=(nn+1);
         D := (-1)*D;
     end; { ComputeDet }

 begin   { ComputeInverse }
    ComputeTransp( X, n );
    WriteMatrix( X,n );
    for i1 := 1 to n do begin
        if  (i1 mod 2)=0 then semn := 1 else semn := -1;
        for j1 := 1 to n do begin
            p  := 1;
               for i2 := 1 to n do begin
                   q  := 0;
                   for j2 := 1 to n do
                          if (i2<>i1) and  (j2<>j1) then
                             begin
                                q := q + 1;
                                Inter[p,q] := X[i2,j2];
                                if q=(n-1) then p := p + 1;
                             end;
               end; { for i2 }
{               WriteMatrix( Inter, n-1 );
               ch := ReadKey;             }
               ComputeDet( Inter,n-1 );
               semn := semn * (-1);
               Y[i1,j1] := semn * D;
        end; { for j1 }
    end; { for i1 }
 end;  { ComputeInverse }

  begin  { main }
         ReadMatrix( A );
         ClrScr;
         WriteMatrix( A,n );
         writeln;
         writeln;
         ComputeInverse( A,Gamma,n );
         writeln;
         WriteMatrix( Gamma, n );
         ch := ReadKey;
  end.   { main }