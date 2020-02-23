  program IncercareVinz;
  uses Crt;

  procedure Vinzare(var m:TabMas; NrMasini:byte);
  var pu,pu1,pu2  : byte      ;
      CondMarca   : string[20];
      CondCuloare : string[20];
      gasit       : boolean   ;
  begin
    write(' Procentul de uzura va intereseaza?(d/n) ');readln(ch);
    if ch='d' or 'D' then begin
       write('   Introd. limita inferioara : '); readln(pu1);
       write('   Introd. limita superioara : '); readln(pu2); end;
    write(' Marca masinii va intereseaza?(d/n) ');readln(ch);
    if ch='d' or 'D' then begin
       write('   Introd. marca dorita : ');readln(CondMarca);end;
    write(' Culoarea masinii va intereseaza?(d/n); readln(ch);
    if ch='d' or 'D' then begin
       write('   Introd. culoarea dorita : '); readln(CondCuloare); end;
    Gasit := true;
    for i:=1 to NrMasini do
        with m[i] do begin
          gasit := (pu>=pu1) and (pu<=pu2);
          if gasit then begin
             gasit := (CondMarca = marca);
             if gasit then begin
                gasit := (CondCuloare = Culoare);
                if gasit then begin
                   ClrScr;
                   writeln(' Masina cautata este...');
                   { AfisDateMasina }
                   writeln;writeln(' Masina se cumpara?(d/n) '); readln(ch);
                   if ch='d' or 'D' then StergeMasina(i,NrMasini);
                end;
             end;
          end;
        end; { with }

    procedure StergeMasina( var c:byte; NrMasini:byte );
    var j:byte;
    begin
      for j:=c to (NrMasini-1) do m[c]:=m[c+1];
      NrMasini := NrMasini-1;
    end; { StergeMasina }



