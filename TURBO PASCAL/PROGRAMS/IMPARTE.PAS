  program DivideSiruri;
  uses  Crt  ;
  const N=10 ;
  type  Sir = array[1..n] of byte;
        M   = set of byte         ;
  var   A,B,C : Sir  ;
        ch    : char ;

  function Suma( Sir0:Sir ):word;
  var i:byte;
      S:word;
  begin
    S := 0;
    for i:=1 to n do S:=S+Sir0[i];
    Suma := S;
  end; { Suma }

  procedure Initializeaza(var Sir1,Sir2,Sir3 :Sir);
  var i:byte;
  begin
    for i:=1 to n do begin
        Sir1[i]:=Random(100);
        Sir2[i]:=0;
        Sir3[i]:=0;
    end { for }
  end;  { Initializeaza }

  procedure Imparte( var Sir1,Sir2,Sir3 : Sir );
  var i:byte;
  begin
    for i:=1 to n do begin
        if Suma(Sir2) > Suma(Sir3) then Sir3[i]:=Sir1[i]
                                 else Sir2[i]:=Sir1[i];
    end; { for }
  end; { Imparte }

  procedure Afiseaza( var Sir0:Sir );
  var i:byte;
  begin
    for i:=1 to n do write(Sir0[i]:3);
    write('  =  ',Suma(Sir0));
  end;  { Afiseaza }

  begin  { main }
    ClrScr;
    Initializeaza(A,B,C);
    Imparte(A,B,C);
    Afiseaza(A);writeln;
    Afiseaza(B);writeln;
    Afiseaza(C);writeln;
    ch := ReadKey;
  end.