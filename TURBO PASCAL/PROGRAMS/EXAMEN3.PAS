program matrix ;
uses Crt ;
const n=4;
type  matriceNxN = array[1..n,1..n] of integer ;
          tipsir = array[1..n] of integer ;
     { matrice(nxp) = array[1..n,1..p] of integer ;}
     { matrice(mxp) = array[1..m,1..p] of integer ;}
 var  i,j,k : byte ;
      A,B,C : matriceNxN;
          s : tipsir ;

 procedure CitMat(var x:matriceNxN; ch : char);
 begin
  for i:=1 to n do
   for j:=1 to n do begin
    write('',ch,'[',i,j,']=');
    read(x[i,j]);
   end;
 end;{CitMat}

  procedure Choice( var x:matriceNxN; var s:tipsir);
  var sir : tipsir ;
  begin
   for i:=1 to n do  begin
    sir[i] := MaxInt ;
    for j:=1 to n do begin
     if abs(x[i,j]) <= sir[i] then begin
                                      s[i] := j ;
                                    sir[i] := abs(x[i,j]);
                                   end;

     end;
    end;
   end; { Choice }

   procedure AfiSir( var s : tipsir );
   begin
    write('Sirul cautat : ');
    for i:=1 to n do begin
     write(s[i],' ');
    end;
   end; { AfiSir }

 procedure Afiseaza(var X:matriceNxN);
 begin
  for i:=1 to n do  begin
   writeln ;
   for j:=1 to n do
    write(x[i,j]:6);
  end;
 end;  { Afiseaza }

 begin   { main }
  ClrScr ;
  CitMat(A,'A');
  Choice(A,s); ClrScr ;
  write(' Matricea data : '); writeln ;
  Afiseaza(A); writeln ;
  writeln ;
  AfiSir(s);
  repeat until Keypressed ;
 end.    { main }


