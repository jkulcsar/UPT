  program Interclasare;
  uses  Crt  ;
  const N=20 ;
  type  Sir   = array[1..N] of byte;
        SirL  = array[1..2*N] of byte;
  var   A,B,C : Sir                ;

  procedure Initializeaza( var x1,x2 : Sir );
  var i : byte;
  begin
    for i:=1 to n do begin
        x1[i] := Random(100);
        x2[i] := Random(255);
    end; { for }
  end;   { Initializeaza }

  procedure Ordoneaza( var X : Sir );
  var i,k : byte;
  begin
    repeat
      begin
        k:=0;
        for i:=1 to n-1 do
            if x[i] > x[i+1] then begin
                                    aux    := x[i]   ;
                                    x[i]   := x[i+1] ;
                                    x[i+1] := aux    ;
                                    k      := 1      ;
                                  end;
      end;
    until k=0;
  end;    { Ordoneaza }

  procedure Interclaseaza( var x1,x2:Sir; var x3:SirL );
  var i,j,k : byte;
  begin