  program Lista1 ;
  uses    Crt    ;
  type    Ptr =  ^nod;
          nod =   record
                    nr  : integer;
                    urm : ptr
                  end;
      ConvPtr = record
                    Ofs : word;
                    Seg : word
                end;

  var   n : integer;
        R : ptr;
       Op : char;

  function Hexa( x:word ) : string;
    const    CifreH : array[0..15] of char=('0','1','2','3','4','5','6','7',
                                          '8','9','A','B','C','D','E','F');
    var  S : string;
    begin
       S := '';
       repeat
          S := CifreH[ x mod 16 ] + S;
          x := x div 16
       until x = 0;
       Hexa   := '$' + S;
    end;

  procedure Initializari;
  begin
    n := 0;
    R := nil
  end;

  procedure ScrieOAdresa( p:ptr );
  begin
    if p = nil then write(' nil')
    else write(' ', Hexa(ConvPtr(p).Seg), ':' , Hexa(ConvPtr(p).Ofs))
  end;

  procedure ScrieNod( p:ptr );
  begin
    write(' Adresa ');ScrieOAdresa(p);
    write(' : nr = ',p^.nr:2,' urm = ');
    ScrieOAdresa(p^.urm);writeln;
    delay(1000)
  end;

  procedure ScrieLista;
    var q : ptr;
    begin
      write(' Radacina = ');ScrieOAdresa(R);
      writeln;
      q:=R;
      while  q<>nil  do begin
                          scrienod(q);
                          q := q^.urm
                        end;
    writeln;
    delay(2000)
  end;

  function NodNou : ptr;
  var  p : ptr;
  begin
     new(p);
     n:=n+1;
     with  p^  do begin
                   nr  := n;
                   urm := nil
                 end;
    write(' S-a alocat nodul :  ');
    delay(1000);
    ScrieNod(p);
    delay(1000);
    NodNou  :=  p;
  end;

  procedure InserIncep;
  var nnod : ptr;
  begin
     writeln(' Inserare la inceput ...');
     nnod := NodNou;
     nnod^.urm := R;
     write(' nnod^.urm:=R; noul nod : ');
     ScrieNod(nnod); delay(1000);
     R := nnod
  end;

  procedure InserSf;
   var   nnod : ptr;
         q    : ptr;
   begin
        writeln(' Inserare la sfirsit ... ');
        nnod := NodNou;
        if R = nil then R := nnod
        else begin
               q := R;
               while q^.urm <> nil do q := q^.urm;
               q^.urm := nnod
         end
    end;

  function CautaNod( NumarNod : integer ) : Ptr;
  var q : ptr;
  begin
    q := R;
    while ( q<>nil) and (q^.nr<>NumarNod) do
            q := q^.urm;
    if q = nil then
    begin
       writeln(' Nodul cautat nu exista. ');
       delay(1000);
    end;
    CautaNod := q
  end;

  procedure Ins( Numar:integer );
  var nnod : ptr;
      q,q1 : ptr;
  begin
      q   := CautaNod( Numar );
      if q = nil then InserSf
      else begin
             write(' Nodul q^ : ');
             ScrieNod(q);
             nnod := NodNou;
             new(q1);
             write(' new(q1)   - ');ScrieNod(q1);
             q1^ := q^;
             write(' q1^ := q^ - ');ScrieNod(q1);
             nnod^.urm := q1;
             write(' nnod^.urm := q1 '); ScrieNod(nnod);
             q^ := nnod^;
           end
  end;

  procedure Inserare;
  var   Op : integer;
  begin
    writeln;
    writeln('  0 = inserare la INCEPUTUL  listei     ... ');
    writeln(' -1 = inserare la SFIRSITUL  listei     ... ');
    writeln('  n = inserare    INAINTEA nodului "n"  ... ');
    write(' Optiunea : '); read( Op );
    case Op of
       0 : InserIncep;
      -1 : InserSf;
       else Ins(Op)
    end;
  end;

  procedure SterIncep;
  var ps : ptr;
  begin
    writeln(' Stergere la inceputul listei ... ');
    ps := R;
    R  := ps^.urm;
    dispose(ps);  writeln('dispose(ps)');  delay(1000)
  end;

  procedure SterSf;
  var   q1, ps : ptr;
  begin
    writeln(' Stergere la sfirsitul listei ... ');
    q1 := R;
    while q1^.urm^.urm<>nil do  q1 := q1^.urm;
    ps      := q1^.urm;
    q1^.urm := nil;
    dispose(ps);  writeln('dispose(ps)');  delay(1000);
  end;

  procedure Ster( q:ptr );
  var ps : ptr;
  begin
    writeln(' Stergere in interiorul listei ... ');
    ps := q^.urm;
    q^ := ps^;
    dispose(ps); writeln(' dispose(ps) ');delay(1000);
  end;

  procedure Stergere;
  var  nn : integer;
       q  : ptr;
  begin
      write(' Stergeti nodul nr... ');readln(nn);
      q := CautaNod(nn);
      if q<>nil then
      begin
          write(' Nodul q^ : ');
          ScrieNod(q); delay(1000);
          if q = R then SterIncep
          else
            if q^.urm = nil then SterSf
            else Ster(q)
          end
  end;

  begin  {  main  }
    Initializari;
    write(' Lista initiala este : ');
    ScrieLista; delay(2000);
  repeat
    writeln;
    writeln(' I..........Inserare');
    writeln(' S..........Stergere inceput');
    writeln(' T..........sTop');
    writeln(' Optiunea : '); Op := ReadKey; write(Op);
    case upcase(Op) of
      'I' : Inserare;
      'S' : Stergere;
    end;
    if Op in ['s','S','i','I'] then
         begin
            writeln(' Lista modificata este : ');
            ScrieLista;
         end
  until upcase(Op) = 'T'
  end.


