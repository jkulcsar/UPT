  program Backtracking;
  uses Crt            ;
  const    N=9;  { nr. de linii   }
           M=25;  { nr. de coloane }
  type     matrice = array[0..n-1,0..m-1] of char;
  var      A   : matrice;
           ch  : char   ;

  procedure CitDate( var Mat:matrice );
  var i,j    : byte;
        q    : integer;
      Fisier : file of char;
  begin
      assign( Fisier,'a:\janos\labirint.mic' );
      reset ( Fisier );
      i:=0;j:=0;
      for q:=1 to FileSize( Fisier ) do
          begin
            read( Fisier, Mat[i,j]);
            j := j+1;
            if (q mod 25)=0 then begin
                                   i:=i+1;
                                   j:=0;
                                  end;
        end; { for }
  end;  { CitDate }

  procedure AfisDate( var Mat:matrice );
  var i,j  : byte;
  begin
    ClrScr;
    for i:=0 to n-1 do begin
        for j:=0 to m-1 do write(Mat[i,j]);
        writeln;
    end; { for }
  end;   { AfisDate }

  procedure Drum( x, y : byte );
  var tasta : char;
  begin
   if A[X,Y] = ' ' then
      if (( ( Y mod (m-1))=0 ) or (( X mod (n-1))=0)) then
      begin
        A[ X,Y ] := 'S';  { punct de iesire }
        GotoXY(Y+1,X+1); Delay(100);write('S');
        A[ X,Y ] := ' ';
        GotoXY(1,25); write('Aceasta este un drum posibil... C continua ... ');
             repeat
             tasta :=  ReadKey;
             tasta := upcase(tasta);
             until tasta='C';
         GotoXY(Y+1,X+1);  write(' ');
      end
      else
      begin
        A[X,Y] := '#' ;
        GotoXY(Y+1,X+1);Delay(100);write('#');
        drum( X+1,Y );
        drum( X,Y+1 );
        drum( X-1,Y );
        drum( X,Y-1 );
        A[ X,Y ] := ' ';
        GotoXY(Y+1,X+1);Delay(100);write(' ');
      end;
  end;     { Drum }

  begin  { main }
    CitDate(A);
    AfisDate(A);
    Drum(4,12);
    ch := ReadKey;
  end.   { main }

