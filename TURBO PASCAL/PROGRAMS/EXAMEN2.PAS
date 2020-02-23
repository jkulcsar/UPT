 program Examen2 ;
 uses Crt ;
 const n=10 ;
 type sir = array[1..n] of string ;
 var  a: sir ;
    i,j,c: byte ;

  procedure CitSir( var x:sir; ch : char );
  begin
   for i:= 1 to n do begin
    write(' Cuvintul ',i,' ');
    readln(x[i]);
   end;
  end;  { CitSir }

   procedure Verif( var x:sir );
   var frecv,k : byte ;
   begin
    for i:=1 to n do begin
    frecv := 0 ;
     for j:=1 to n do begin
      if x[i]=x[j] then
        begin
         frecv := frecv +1;
         if frecv >= 2 then begin
                              c:=c+1;
                              for k:=j to n do a[k]:=a[k+1];

        end;
     end;


     writeln(' Frecventa cuvintului ', x[i], ' este : ',frecv);
    end;
   end; { verif }

   begin  { main }
    ClrScr ;
    CitSir(a,'a');
    verif(a);
   end.   { main }

