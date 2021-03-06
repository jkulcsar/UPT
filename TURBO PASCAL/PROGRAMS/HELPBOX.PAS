  unit HelpBox;
  interface
  uses Graph, Crt;

  procedure PutHelpBox( NumeFisier : string );

  implementation

  procedure PutHelpBox( NumeFisier : string );
  var Linie,LinieMax: string[80];
      Fisier  : text;
      LungMax : byte;
      StrLungMax : string[10];
      LungLin : byte;
      LungFis : word;
      StrLungFis : string[10];
      Cx,Cy : word;
  begin
      SetTextStyle(0,HorizDir,1);
      assign(Fisier,NumeFisier);
      reset(Fisier);
      LungMax := 0;
      LungFis := 0;
      while not eof(Fisier) do
        begin
             readln(Fisier,Linie);
             LungFis := LungFis+1;
             LungLin := length(Linie);
             if LungLin >= LungMax then
                begin
                   LungMax := LungLin;
                   LinieMax:= Linie;
                end;
        end;
      close(Fisier);

      Rectangle(0,0,TextWidth(LinieMax)+20,LungFis*10+20);
      SetViewPort(10,10,TextWidth(LinieMax)+10,LungFis*10+10,True);

      assign(Fisier,NumeFisier);
      reset(Fisier);
      Cx := 0;
      Cy := 0;
      while not eof(Fisier) do
        begin
           readln(Fisier,Linie);
           OutTextXY(Cx,Cy,Linie);
           Cy := Cy + 10
        end;

      str(LungMax,StrLungMax);
      OutTextXY(0,460,'Linia cea mai lunga din fisier are '+StrLungMax+' caractere.');
      str(LungFis,StrLungFis);
      OutTextXY(0,470,'Fisierul curent contine '+StrLungFis+' linii.');
  end; { PutHelpBox }

  begin
  end.

