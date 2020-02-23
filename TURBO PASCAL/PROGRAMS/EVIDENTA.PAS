  program Trying;
  uses Crt      ;
  const    orizontala     = #205;   Spatiu = '        ';
           verticala      = #186;   n=25;
           ColtStingaSus  = #201;
           ColtStingaJos  = #200;
           ColtDreaptaSus = #187;
           ColtDreaptaJos = #188;
           SageataSus     =  72;
           SageataJos     =  80;
           SageataDreapta =  77;
           SageataStinga  =  75;
           MaxOriz        =  80;
           MaxVert        =  24;
  type     Masina         = record
                              marca : string[20];
                              AnFab : integer   ;
                              Putere: byte      ;
                              PU    : 0..100    ;
                              pa    : LongInt   ;
                              pv    : real      ;
                            end;
            TabMasini     = array[1..n] of masina ;
  var      x,y             : integer;
           ch,optiune      : char   ;
           m               : TabMasini;
           NrMasini        : byte;
           LastCol,LastRow : word;
           suma            : LongInt;
           x1,y1,x2,y2     : word;
           r,c             : byte;

  procedure Fereastra( x1,y1,x2,y2 : integer);
  var i : byte;
  begin
    TextColor(White);
    TextBackground(Black);
    Window(x1,y1,x2,y2);
    ClrScr;
  { Traseaza liniile orizontale  }
    for i:=1+1 to x2-x1-1 do begin
      GotoXY(i,1); write(orizontala);
      GotoXY(i,y2-y1); write(orizontala);
    end;
  { Traseaza liniile verticale }
    for i:=1+1 to y2-y1-1 do begin
      GotoXY(1,i); write(verticala);
      GotoXY(x2-x1,i); write(verticala);
    end;
  { Deseneaza colturile }
    GotoXY(1,1); write(ColtStingaSus);
    GotoXY(x2-x1,1); write(ColtDreaptaSus);
    GotoXY(x2-x1,y2-y1); write(ColtDreaptaJos);
    GotoXY(1,y2-y1); write(ColtStingaJos);
  end;  { Fereastra }

  procedure Initializeaza;
    begin
      ClrScr;
      TextMode(Lo(LastMode)+Font8x8);
      LastCol := Lo(WindMax);
      LastRow := Hi(WindMax);
      Fereastra(1,1,LastCol,LastRow);
    end; { Initializeaza }

  procedure CitMasina(NrOrd:byte);
  var tasta : char; j,c,r:byte;
  begin
   TextAttr := 7;
   repeat
    c:=2;r:=2;
    Window(3,22,38,34);GotoXY(c,r);writeln(' Introduceti datele masinii...');writeln;
    with m[NrMasini] do begin
      GotoXY(c,r+2);write(' Marca            : ');readln(marca);
      GotoXY(c,r+3);write(' Anul fabricatiei : ');readln(AnFab);
      GotoXY(c,r+4);write(' Puterea          : ');readln(putere);
      GotoXY(c,r+5);write(' Procent uzura    : ');readln(pu);
      GotoXY(c,r+6);write(' Pret achizitie   : ');readln(pa);
      GotoXY(c,r+7);write(' Pret vinzare     : ',pa*1.15:8:2);pv:=pa*1.15;
        if pa>suma then begin
                        ClrScr;
                        GotoXY(c,r+2);write(' Atentie! Nu se poate cumpara ! '); end;
      GotoXY(c,r+7);write(' Pret vinzare     : ');writeln((pa*1.15):10:2); end;
      GotoXY(c,r+8);write(' DATELE SINT CORECTE(d/n)? ');
    tasta := ReadKey; if tasta='n' then ClrScr;
   until tasta='d';
   TextAttr := 15;
  end;


  procedure CreazaTablou;
  var c,r,i:byte;
  begin
    i:=0;
    Fereastra(2,18,40,36);
    c:=2;r:=2;
    GotoXY(c,r);writeln(' Introduceti tabloul de masini... ');
    repeat
      i:=i+1;
      Window(3,21,38,34);ClrScr; c:=2;r:=2;
      GotoXY(c,r);writeln('  Masina numarul ',i:3);
      CitMasina(i);
      NrMasini:=i;
    until NrMasini=20;Window(2,18,40,36);ClrScr;
  end; { CreazaTablou }

  procedure SalveazaTablou;
  var Fisier : file of Masina;
      i      : byte;
  begin
    Window(2,45,40,47);ClrScr;GotoXY(2,2);Write('Salvez tabloul actual...');
      assign(Fisier,'a:\janos\masini.dat');
      rewrite(Fisier);
        for i:=1 to NrMasini do write(Fisier,m[i]);
      close(Fisier);
    ClrScr;
  end; { SalveazaTablou }

  procedure CitFisTablou;
  var Fisier : file of Masina;
      i,c          : byte;
      ch           : char;
      q            : integer;
  begin
      Window(2,45,40,47);ClrScr;GotoXY(2,2);write('Citesc fisierul...');
        assign( Fisier,'a:\janos\masini.dat');
        reset( Fisier );
          q := FileSize( Fisier );
          NrMasini := q;
          for i:=1 to q  do read(Fisier,m[i]);
      ClrScr;
  end;  { CitFisTablou }

  procedure Achizitioneaza;
  var optiune : char;
      NrOrd   : byte;
  begin
    c:=2;r:=2;
    Fereastra(2,18,40,36);GotoXY(c,r);writeln('    Achizitionare. ');
    repeat
      NrMasini := NrMasini+1;
      NrOrd := NrMasini;
      CitMasina( NrOrd );
      writeln;
      write(' Alta masina (d/n)? '); readln(optiune);
      if optiune='d'then ClrScr;
    until optiune='n';
    Window(2,18,40,36);ClrScr;
    end;

  procedure AfisDateMasina( var NrOrd:byte);
  var c,r:byte;
  begin
    with m[NrOrd] do begin
              GotoXY(c,r+2);writeln('   ',marca);
              GotoXY(c,r+3);writeln(' AnFabr.    : ',AnFab);
              GotoXY(c,r+4);writeln(' Puterea    : ',putere);
              GotoXY(c,r+5);writeln(' Proc.uz    : ',pu);
              GotoXY(c,r+6);writeln(' Pret achiz.: ',pa);
              GotoXY(c,r+7);writeln(' Pret vinz .: ',pv);
     end;
  end; { AfisDateMasina }

  procedure StergeMasina( var c:byte );
    var j:byte;
    begin
      for j:=c to (NrMasini-1) do m[c]:=m[c+1];
      NrMasini := NrMasini-1;
  end; { StergeMasina }

  procedure Vinzare;
  var pu1,pu2     : byte      ;
      CondMarca       : string[20];
      putere1,putere2 : byte      ;
      gasit,gasit1,gasit2,gasit3,gasit4,gasit5       : boolean   ;
      ch              : char      ;
      i,marc,c,r      : byte       ;
      AnFab1,AnFab2   : word;
  begin
    Fereastra(2,18,50,36);GotoXY(2,2);write(' Vinzare. ');
    Window(3,21,48,34);c:=2;r:=2;
    TextAttr := 7;
    GotoXY(c,r);write(' Introd. marca dorita : ');readln(CondMarca);
    GotoXY(c,r+1);writeln(' Anul fabricatiei...  ');
    GotoXY(c,r+2);write('   Introd. limita inferioara : '); readln(AnFab1);
    GotoXY(c,r+3);write('   Introd. limita superioara : '); readln(AnFab2);
    GotoXY(c,r+4);writeln(' Puterea motorului... ');
    GotoXY(c,r+5);write('   Introd. limita inferioara : '); readln(putere1);
    GotoXY(c,r+6);write('   Introd. limita superioara : '); readln(putere2);
    TextAttr := 15;
    Gasit := true;  marc :=0;
    for i:=1 to NrMasini do
        with m[i] do begin
             gasit := (CondMarca = marca);
             if gasit then begin
                gasit := (anfab1<=anfab) and (anfab2>=AnFab);
                if gasit then begin
                   gasit := (putere>=putere1) and (putere<=putere2);
                   if gasit then begin
                     ClrScr;
                     GotoXY(c,r);writeln(' Masina cautata este...');
                     AfisDateMasina(i) ; marc := marc+1;
                     GotoXY(c,r+9);write(' Masina se cumpara?(d/n) '); readln(ch);
                     if ch='d' then StergeMasina(i);
                   end;
                end ;
             end;
             if marc=0 then begin ClrScr; writeln(' Nu avem masina cautata ! '); end;
        end; { with }
        Window(2,18,50,36);ClrScr;
  end; { vinzare }

  procedure VizStoc;
  var i,k,c,r:byte; ch:char;
  begin
      Fereastra(41,2,77,47);c:=2;r:=2;
      GotoXY(c,r);writeln(' Tabloul actual este : ');
      Window(43,5,75,45);
      for i:=1 to NrMasini do begin
          TextAttr := 15;
          writeln('   Masina nr. ',i);
          with m[i] do begin
             writeln('         ',marca);
            TextAttr := 7;
             writeln('An fabricatie     : ',anfab);
             writeln('Puterea (CP)      : ',putere);
             writeln('Proc uzura        : ',pu);
             writeln('Pret achizitie    : ',pa);
             writeln('Pret vinzare      : ',pv:8:1);
           end; { with }
           if (i mod 5)=0 then begin
                                    repeat
                            TextAttr := 15; writeln;writeln('  C-continua...  ');
                                      ch := ReadKey;
                                    until ch='c';
                                    ClrScr;
                                end; { if }
      end; { for }
      TextAttr := 15;  writeln;
      writeln(' That"s all folks ! ');writeln;
      write('Inchid fereastra?(d/n)');
      ch := ReadKey; ch:=upcase(ch);if ch='D' then Window(41,2,77,47);ClrScr;
  end; { VizStoc }

  begin { main }
    Initializeaza;
    suma := 100000000;
    repeat
      Fereastra(2,2,40,17);
      r:=4;c:=2;
      GotoXY(4,2);writeln(' Meniu Principal ');
      GotoXY(c+30,r);write('C'); GotoXY(C+30,r+1);Write('S');
      GotoXY(C+30,r+2);Write('F');GotoXY(C+30,r+3);Write('A');
      GotoXY(C+30,r+4);Write('V');GotoXY(C+30,r+5);Write('D');
      GotoXY(C+30,r+6);Write('E');
      TextAttr := 7;
      GotoXY(c,r);  writeln(' Creaza tablou................');
      GotoXY(c,r+1);writeln(' Salveaza tabloul actual......');
      GotoXY(c,r+2);writeln(' Citeste fisier ..............');
      GotoXY(c,r+3);writeln(' Achizitioneaza...............');
      GotoXY(c,r+4);writeln(' Vinzare......................');
      GotoXY(c,r+5);writeln(' Stoc actual..................');
      GotoXY(c,r+6);writeln(' Iesire.......................');
      GotoXY(c,r+7);writeln;
      TextAttr := 15;
      GotoXY(c,r+8);write(' Optiunea Dvs?');
      optiune:=ReadKey;optiune:=upcase(optiune);
        case optiune of
         'C': CreazaTablou;
         'S': SalveazaTablou;
         'F': CitFisTablou;
         'A': Achizitioneaza;
         'D': VizStoc;
         'V': Vinzare;
        end; { case }
     until optiune='E';
  end. {  main }
