program editor;
uses crt;
label 5,15;
type linie=string[126];
var lin:linie;
    cuv,cuv1:string;
    ch:char;
    a:array[1..51] of linie;
    i,j,k,nr,s,o,n,pozcuv,lungime,pozcuv1:integer;
    qa:array[1..20] of string[16];

procedure patrat(x,y,dx,dy:integer);
var i:integer;
begin
     clrscr;
     textattr:=5;
     gotoxy(x+1,y+2);
     write(chr(201));
     for i:=1 to dx-4 do write(chr(205));
     writeln(chr(187));
     for i:=1 to dy do begin
         gotoxy(x+1,wherey);
         write(chr(186));
         gotoxy(x+dx-2,wherey);
         writeln(chr(186));
     end;
     gotoxy(x+1,y+dy+3);
     write(chr(200));
     for i:=1 to dx-4 do write(chr(205));
     writeln(chr(188));
end;
procedure meniu(pozx,pozy,nn:integer;var w:integer);
          label 15,20,30;
          var y,xm,ym,i,j,k:integer;
              begin
                   textattr:=0;
                   for i:=1 to nn do begin
                       k:=16-length(qa[i]);
                       qa[i]:=qa[i];
                       for j:=1 to k do qa[i]:=qa[i]+' ';
                   end;
                   patrat(pozx,pozy,20,nn);
                   textattr:=15;
                   for i:=1 to nn do begin
                       gotoxy(pozx+2,pozy+i+2);
                       writeln(qa[i]);
                       gotoxy(pozx+2,pozy+i+2);
                       ym:=nn+2;
                       y:=3;
                   end;
                   textattr:=112;
                   gotoxy(pozx+2,pozy+3);
                   writeln(qa[1]);
                   gotoxy(pozx+2,pozy+nn-1);
                   30:ch:=readkey;
                   w:=ord(ch);
                   case w of
                        72:begin
                                textattr:=15;
                                gotoxy(pozx+2,pozy+y);
                                writeln(qa[y-2]);
                                gotoxy(pozx+2,pozy+y);
                                if y>=3 then y:=y-1;
                                if y<3 then y:=ym;
                                textattr:=112;
                                gotoxy(pozx+2,pozy+y);
                                writeln(qa[y-2]);
                                gotoxy(pozx+2,pozy+y);
                        end;
                        80:begin
                                textattr:=15;
                                gotoxy(pozx+2,pozy+y);
                                writeln(qa[y-2]);
                                if y<=ym then y:=y+1;
                                if y>ym then y:=3;
                                textattr:=112;
                                gotoxy(pozx+2,pozy+y);
                                writeln(qa[y-2]);
                                gotoxy(pozx+2,pozy+y);
                        end;
                        27:goto 20;
                        13:goto 15;
                   end;
                   goto 30;
                   15:w:=y-2;
                   20:textattr:=15;
          end;

procedure citeste_text(var nr:integer);
begin
     gotoxy(1,21);
     writeln('INTRODUCETI TEXTUL DE EDITAT');
     writeln;
     nr:=0;
     repeat
           nr:=nr+1;
           readln(lin);
           a[nr]:=lin;
     until (nr=50) or (lin='');
end;
procedure pozit_linie;
begin
     gotoxy(1,21);
     writeln('INTRODUCETI NUMARUL LINIEI DE EDITAT');
     readln(n);
end;
procedure sterge_linie;
begin
     for i:=n to nr-1 do a[i]:=a[i+1];
     nr:=nr-1;
end;
procedure insereaza_linie;
begin
     gotoxy(1,21);
     writeln('LINIA SE VA INSERA LA POZITIA CURENTA (',n,')');
     for i:=nr downto n do a[i+1]:=a[i];
     nr:=nr+1;
     if (nr+1)>50 then begin
        writeln('ULTIMA LINIE DIN TEXT VA FI STEARSA');
        nr:=nr-1;
     end;
     readln(a[n]);
     ch:=readkey;
end;
procedure schimba_linie;
begin
     gotoxy(1,21);
     writeln('INTRODUCETI LINIA DE SCHIMB PENTRU LINIA CURENTA');
     writeln;
     readln(lin);
     a[n]:=lin;
     ch:=readkey;
end;
procedure cauta_cuvint;
begin
     gotoxy(1,21);
     writeln('INTRODUCETI SIRUL DE CAUTAT');
     readln(cuv);
     pozcuv:=pos(cuv,a[n]);
     writeln('POZITIA SIRULUI IN CADRUL LINIEI ESTE ',pozcuv);
     ch:=readkey;
end;
procedure sterge_cuvint;
begin
     gotoxy(1,21);
     writeln('INTRODUCETI LUNGIMEA CUVINTUL DE STERS ');
     readln(lungime);
     delete(a[n],pozcuv,lungime);
end;
procedure inlocuieste_cuvint;
begin
     gotoxy(1,21);
     writeln('INTRODUCETI CUVINTUL DE INLOCUIT ');
     readln(cuv);
     writeln('INTRODUCETI NOUL CUVINT ');
     readln(cuv1);
     pozcuv1:=pos(cuv,a[n]);
     delete(a[n],pozcuv1,length(cuv));
     insert(cuv1,a[n],pozcuv1);
end;
procedure insereaza_cuvint;
begin
     gotoxy(1,21);
     writeln('CUVINTUL DE INSERAT = ');
     readln(cuv);
     write('POZITIA CURENTA = ');
     readln(pozcuv1);
     insert(cuv,a[n],pozcuv1);
end;
procedure afiseaza_text;
begin
     clrscr;
     for i:=1 to nr do writeln(a[i]);
     ch:=readkey;
end;

begin
     5:qa[1]:='CITESTE TEXT';qa[2]:='POZIT-LINIE';
     qa[3]:='STERGE-LINIE';qa[4]:='SCHIMBA-LINIE';
     qa[5]:='INSER-LINIE';qa[6]:='POZIT-CUVINT';
     qa[7]:='STERGE-CUVINT';qa[8]:='SCHIMBA-CUVINT';
     qa[9]:='INSER-CUVINT';qa[10]:='AFISEAZA-TEXT';
     qa[11]:='TERMINA';
     meniu(10,5,11,o);
     case o of
          1:begin
                 citeste_text(nr);
                 goto 5;
          end;
          2:begin
                 pozit_linie;
                 goto 5;
          end;
          3:begin
                 sterge_linie;
                 goto 5;
          end;
          4:begin
                 schimba_linie;
                 goto 5;
          end;
          5:begin
                 insereaza_linie;
                 goto 5;
          end;
          6:begin
                 cauta_cuvint;
                 goto 5;
          end;
          7:begin
                 sterge_cuvint;
                 goto 5;
          end;
          8:begin
                 inlocuieste_cuvint;
                 goto 5;
          end;
          9:begin
                 insereaza_cuvint;
                 goto 5;
          end;
          10:begin
                 afiseaza_text;
                 goto 5;
          end;
          11:goto 15;
     end;
     ch:=readkey;
15:end.

