program piramida;
uses crt;
type pos=array[1..8,1..2] of integer;
     lab=array[1..6,1..6] of integer;
const p:pos=((-1,-1),(0,-1),(1,-1),(1,0),(1,1),(0,1),(-1,1),(-1,0));
var i,j,k,m,n,pozx,pozy,pas:integer;
    a:lab;
    f:file of lab;
    ch:char;
    s:string;
    drum:array[0..100,1..2] of integer;

procedure save(nume:string);
begin
     assign(f,nume);
     rewrite(f);
     write(f,a);
     close(f);
end;

procedure load(nume:string);
begin
     assign(f,nume);
     reset(f);
     read(f,a);
     close(f);
end;

procedure afiseaza_mat(m,n:integer);
var i,j:integer;
begin
	for i:=1 to n do begin
		for j:=1 to m do begin
			gotoxy(j*5,i);
			if (i=pozx) and (j=pozy) then begin
				textcolor(lightred);
				write(a[i,j]);
				textcolor(lightblue);
			end else
			write(a[i,j])
		end
	end
end;
procedure afiseaza(max:integer);
var i:integer;
begin
     for i:=0 to max do write(drum[i,1],'-',drum[i,2],',');
     writeln;
end;

procedure cauta(pozx,pozy,pas:integer);
var i,t1,t2:integer;
begin
	 if (pozx=1) or (pozx=n) or (pozy=1) or (pozy=m) then readln
	 else begin
          for i:=1 to 8 do begin
              if a[pozx,pozy]>=a[pozx+p[i,1],pozy+p[i,2]] then begin
				 t1:=(pozy+p[i,2])*5;t2:=pozx+p[i,1];
				 gotoxy(t1,t2);
				 textcolor(lightred);
				 write(a[pozx+p[i,1],pozy+p[i,2]]);
				 drum[pas,1]:=pozx+p[i,1];
                 drum[pas,2]:=pozy+p[i,2];
				 cauta(pozx+p[i,1],pozy+p[i,2],pas+1);
				 gotoxy(t1,t2);
				 textcolor(lightblue);
				write(a[pozx+p[i,1],pozy+p[i,2]]);
			  end;
		  end;
	 end
end;
begin {PP}
	  clrscr;
	  writeln('1:Introducerea unui nou labirint');
	  writeln('2:Introducerea unui labirint existent pe disk');
	  readln(ch);
	  case ch of
		   '1':begin
					write('m=');readln(m);
					write('n=');readln(n);
					write('pozx=');readln(pozx);
					write('pozy=');readln(pozy);
					for i:=1 to m do for j:=1 to n do begin
						write('a[',i,',',j,']=');
						readln(a[i,j]);
					end;
					write('numele fisierului este ');
					readln(s);
					save(s);
		   end;
		   '2':begin
					write('numele fisierului este ');
					readln(s);
					load(s);
		   end;
	  end;
	  clrscr;
	  pozx:=3;pozy:=3;
	  drum[0,1]:=pozx;drum[0,2]:=pozy;
	  pas:=1;m:=5;n:=5;
	  afiseaza_mat(m,n);
      cauta(pozx,pozy,pas);
      ch:=readkey;
end.

