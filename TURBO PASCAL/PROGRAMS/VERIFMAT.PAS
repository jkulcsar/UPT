program matrix ;
uses Crt ;
const n=3;
type  matriceNxN = array[1..n,1..n] of integer ;
     { matrice(nxp) = array[1..n,1..p] of integer ;}
     { matrice(mxp) = array[1..m,1..p] of integer ;}
 var  i,j,k : byte ;
      A,B,C : matriceNxN;
 procedure CitMat(var x:matriceNxN; ch : char);
 begin
  for i:=1 to n do
   for j:=1 to n do begin
    write('',ch,'[',i,j,']=');
    read(x[i,j]);
   end;
 end;{CitMat}
 procedure Inmulteste(var X,Y : matriceNxN; var Z : matriceNxN);
 begin
  for i:=1 to n do
   for j:=1 to n do begin
    Z[i,j]:=0;
    for k:=1 to n do
     Z[i,j]:= Z[i,j]+X[i,k]*Y[k,j];
   end;
 end; { Inmulteste }
 procedure Afiseaza(var X:matriceNxN);
 begin
  for i:=1 to n do  begin
   writeln ;
   for j:=1 to n do
    write(x[i,j]:6);
  end;
 end;  { Afiseaza }

 procedure Tipareste_Liniile( var  l1,l2 : byte );
 var u,v : byte ;  { contoare locale }
       X : matriceNxN ;
 begin
  for u:=1 to n do  begin { aici n este numarul de coloane }
   write(X[l1,u]:6); end;
   writeln;
  for v:=1 to n do
   write(X[l2,v]:6);
 end;  { Tipareste_Liniile }

 procedure Tipareste_Coloana( var c : byte );
 var X:matriceNxN;
  begin
   writeln;
   for i:=1 to n do
   write(X[i,c]);
  end;    { Tipareste_Coloana }

 procedure Verifica_Liniile_Identice(var X:matriceNxN);
 begin
  for i:=1 to n do
   for k := i+1 to n do begin
    El := 0 ;
    for j:=1 to n do begin
     if X[i,j]=X[k,j] then El:=El+1;
    end;
    if (El=n) then Tipareste_Liniile(i,k);
    writeln;
   end;
  end;  { Verifica_Liniile_Identice }

 procedure Verifica_Coloanele( var X:matriceNxN );
 var marc : byte ;
 begin
  for j:=1 to n do
   for i:=1 to n do begin
     marc := 0 ;
     for k:=2 to x[i,j] do begin
      if X[i,j]/k = trunc(X[i,j]/k) then
      marc := marc +1 ;
    end; { k }
    if marc>=2 then Tipareste_Coloana(j);
 end;    { Verifica_Coloanele }

 begin   { main }
  CitMat(A,'a');
 { CitMat(B,'b'); }
 { Inmulteste(A,B,C);ClrScr;}
  Afiseaza(A);
  writeln;
 { Afiseaza(B);writeln;afiseaza(C);writeln; }
  Verifica_Liniile_Identice(A);
  Verifica_Coloanele(A);
  repeat until KeyPressed;

  end.   { main }




