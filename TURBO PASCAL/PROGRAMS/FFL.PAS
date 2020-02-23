  program FaceFiserDeCaractere;
  uses Crt;
  type sir = array[1..225] of char;
  var      s      : sir;

  procedure CreazaTablou(var x:sir);
  var i:word;
  begin
    ClrScr;
    writeln('Introduceti cele 225 (9x25) de caractere...');
    for i:=1 to 225 do begin
        write(i:3,' . ');readln(x[i]);
    end;
  end;  { CreazaTablou }

  procedure SalveazaTablou(var x:sir);
  var Fisier : file of char; i:word; ch : char;
  begin
    writeln('Salvez tabloul in fisierul LABIRINT.MIC ... ');
    assign( Fisier, 'a:\janos\labirint.mic' );
    rewrite( Fisier );
      for i:=1 to 225 do write( Fisier,x[i] );
    close( Fisier );
    writeln('Am salvat ...');
    writeln('Orice tasta continua ...');
    ch := ReadKey;
  end; { SalveazaTablou }

  begin  { main }
    CreazaTablou( S );
    SalveazaTablou( S );
  end.   { main }

