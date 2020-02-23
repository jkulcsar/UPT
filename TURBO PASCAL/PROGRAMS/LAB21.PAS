program reducere_forte;

uses graph,crt;

const
     n=4;
     gd=0;
     gm=2;
type
    v_forta = array [1..n,1..3] of real;
    mod_fort = array [1..n] of real;
    mom_c = array [5..6,1..3] of real;

var
   l1,l2,l3,i,j,k,p:integer;
   GraphDriver, GraphMode : integer;
   mc,q:mom_c;
   tasta,rel:char;
   f,a,b,c,d,x,m,cos,g,h,l:v_forta;
   f1,f2,f3,f4,rad,e,baza,mm1:real;
   z,r,mr,mm:mod_fort;
   rez,mom:string;
   MaxX, MaxY, x0, y0 : word;

function radac(rad,e:real):real;
var
   temp:real;
begin
     temp:=ln(rad)/n;
     radac:=exp(temp);
end;
function putere(baza,e:real):real;
var
   temp:real;
begin
     temp:=e*ln(baza);
     putere:=exp(temp);
end;

procedure Init;
begin
     GraphDriver := Detect;
     InitGraph( GraphDriver, GraphMode, 'C:\TP6\BGI' );
     MaxX := GetMaxX ;
     MaxY := GetMaxY ;
     x0   := MaxX div 2;
     y0   := MaxY div 2;
end; { Init }

  procedure WriteVector( CoordX,CoordY : word;
                                Litera : string;
                                Indice : string        );
  begin
       SetTextStyle( SmallFont, HorizDir, 4 );
       SetTextJustify( CenterText, TopText );
       SetLineStyle( SolidLn,0,NormWidth );
       OutTextXY( CoordX, CoordY, Litera );
       OutTextXY( TextWidth(Litera)+CoordX+2, (TextHeight(Litera) div 2)+CoordY+2, Indice );
       MoveTo( CoordX - (TextWidth('M') div 2), CoordY );
       LineTo( CoordX + (TextWidth('M') div 2), CoordY  );
  end; { WriteVector }

  procedure WriteScalar( CoordX, CoordY : word;
                                 Litera : string;
                                 Indice : string       );
  begin
       SetLineStyle( SmallFont, HorizDir, 4 );
       SetTextJustify( CenterText, TopText );
       SetLineStyle( SolidLn,0,NormWidth );
       OutTextXY( CoordX, CoordY, Litera );
       OutTextXY( TextWidth(Litera)+CoordX+2, (TextHeight(Litera) div 2)+CoordY+2, Indice );
  end; { WriteScalar }

procedure RestoreViewPort;
begin
     SetViewPort( 0,0,MaxX,MaxY, True );
end;

procedure enunt;
var ch : char;
begin
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, True);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutText('Enuntul problemei : ');
     SetTextStyle( SmallFont, HorizDir, 4 );
     OutTextXY(1,30,'Pentru figura de mai sus se dau lungimile laturilor');
     OutTextXY(1,40,'paralelipipedului marimile fortelor F si momentelor M');
     OutTextXY(1,50,'precum si p care reprezinta marimea fortei distribuite.');
     OutTextXY(1,60,'   Datele numerice care urmeaza se recomanda a se nota');
     OutTextXY(1,70,'   deoarece ele se vor utiliza in calcule ulterioare.');
     OutTextXY(1,100,' Apasa orice tasta pentru continuare  . . . ');
        ch := ReadKey;
     ClearViewPort;
     OutTextXY( 1,20,'Lungimile laturilor paralelipipedului sint : ');
     OutTextXY( 1,40,'  L1 = 3    m ');
     OutTextXY( 1,50,'  L2 = û3   m ');
     OutTextXY( 1,60,'  L3 = 2*û3 m ');
     OutTextXY( 1,100,' Apasa orice tasta pentru continuare . . . ');
        ch := ReadKey;
     ClearViewPort;
     OutTextXY( 1,20,'Marimile fortelor concentrate sint : ');
     OutTextXY( 1,40,'   F1 = 20 N ');
     OutTextXY( 1,50,'   F2 = 30 N ');
     OutTextXY( 1,60,'   F3 = 40 N ');
     OutTextXY( 1,80,'Marimea fortei uniform distribuite (F4) este : p = 2 N/m ');
     OutTextXY( 1,100,' Apasa orice tasta pentru continuare . . . ');
        ch := ReadKey;
     ClearViewPort;
     OutTextXY( 1,20,' Marimile momentelor M5 respectiv M6 sint : ');
     OutTextXY( 1,40,'    M5 = 3 * û2 Nm ');
     OutTextXY( 1,50,'    M6 = 2 * û5 Nm ');
     OutTextXY( 1,100,' Apasa orice tasta pentru continuare . . . ');
        ch := ReadKey;
     ClearViewPort;
        RestoreViewPort;
end;

procedure cos_corect;
begin
     g[1,1]:=0;h[1,1]:=0;q[5,1]:=1.5;
     g[1,2]:=-1;h[1,2]:=0;q[5,2]:=2.59;
     g[1,3]:=0;h[1,3]:=0;q[5,3]:=3;
     g[2,1]:=0.5;h[2,1]:=0;q[6,1]:=-2;
     g[2,2]:=-0.86;h[2,2]:=3;q[6,2]:=0;
     g[2,3]:=0;h[2,3]:=3.46;q[6,3]:=4;
     g[3,1]:=0.35;h[3,1]:=0;
     g[3,2]:=0.61;h[3,2]:=0;
     g[3,3]:=-0.7;h[3,3]:=3.46;
     g[4,1]:=0;h[4,1]:=0.86;
     g[4,2]:=0;h[4,2]:=0;
     g[4,3]:=-1;h[4,3]:=3.46;
     for i:=1 to n do
         begin
              cos[i,1]:=g[i,1];
              cos[i,2]:=g[i,2];
              cos[i,3]:=g[i,3];
         end;
end;
procedure para;

const t=250;

var i:integer;

begin
     rectangle(150,150,400,350);
     line(250,50,500,50);
     line(250,0,245,5);
     line(250,0,255,5);
     line(600,250,595,245);
     line(600,250,595,255);
     line(50,450,50,445);
     line(55,450,50,450);
     line(250,50,250,10);
     line(500,50,500,250);
     line(150,150,250,50);
     line(400,150,500,50);
     line(400,350,500,250);
     line(250,0,250,50);
     line(240,10,240,60);
     line(230,20,230,70);
     line(220,30,220,80);
     line(210,40,210,90);
     line(200,50,200,100);
     line(190,60,190,110);
     line(180,70,180,120);
     line(170,80,170,130);
     line(160,90,160,140);
     line(150,100,150,150);
     line(150,350,50,450);
     line(500,250,600,250);
     for i:=0 to 10 do line(t-i*10,50+i*10,t-i*10+5,50+i*10-10);
     for i:=0 to 10 do line(t-i*10,50+i*10,t-i*10-5,50+i*10-10);
     setlinestyle(dottedln,0,normwidth);
     line(150,350,250,250);
     line(250,250,500,250);
     line(250,50,250,250);
     line(400,350,500,50);
     line(250,50,400,350);
     line(250,250,400,150);
     line(150,150,500,50);
     setlinestyle(solidln,0,thickwidth);
     line(250,250,170,250);
     line(200,50,200,100);
     line(170,250,175,245);
     line(170,250,175,255);
     line(250,250,350,184);
     line(350,184,345,184);
     line(350,184,348,190);
     line(250,50,295,140);
     line(295,140,290,137);
     line(295,140,295,135);
     line(500,50,380,84);
     line(380,84,385,80);
     line(380,84,387,85);
     line(400,350,440,228);
     line(440,228,435,233);
     line(440,228,440,235);
     line(200,100,205,90);
     line(200,100,195,90);
      WriteVector( 180,40,'F','4' );
      WriteVector( x0-20,120,'F','3');
      WriteVector( x0+70,90,'F','2');
      WriteVector( 180,y0-10,'F','1' );
      WriteVector( x0+40,y0-50,'M','5' );
      WriteVector( x0+130,y0-10,'M','6' );
      OutTextXY(  MaxX-50,y0-10,'Y');
      OutTextXY(  45,MaxY-45,'X');
      OutTextXY(  x0-50,5,'Z');
      WriteScalar( x0-50,y0+95,'L','1');
      WriteScalar( x0+150,y0+50,'L','2');
      WriteScalar( x0+190,y0-80,'L','3');
end;

procedure afisare;
begin
     clrscr;
     writeln('1.a Calculul rezultantei fortelor.');
     writeln('    Introduceti fortele Fi~ de forma:');
     writeln('_         _        _        _');
     writeln('Fi~ = Fix*i~ + Fiy*j~ + Fiz*k~');
     writeln('unde:');
     writeln('Fix = Fi * cos(Fi,Ox)');
     writeln('Fiy = Fi * cos(Fi,Oy)');
     writeln('Fiz = Fi * cos(Fi,Oz)');
     writeln;
     writeln('Marimea fortei uniform distribuite este:F4 = p*L2 [N]');
     writeln;
     writeln('Introduceti cosinusii directori ai fortelor de forma:');
     writeln;
     writeln('cos(Fi~,Ox)=...');
     writeln('cos(Fi~,Oy)=...');
     writeln('cos(Fi~,Oz)=...');
     writeln;
end;
procedure citire_cos;
label rep;
begin
     for i:=1 to n do
         begin
              for p:=1 to 3 do
                  begin
rep:                   if p=1 then write('cos(F~',i,',Ox)=');
                       if p=2 then write('cos(F~',i,',Oy)=');
                       if p=3 then write('cos(F~',i,',Oz)=');
                       readln(a[i,p]);
                       if p=1 then write('cos(F~',i,',Ox)=');
                       if p=2 then write('cos(F~',i,',Oy)=');
                       if p=3 then write('cos(F~',i,',Oz)=');
                       writeln(a[i,p]:2:2);
                       if a[i,p]=cos[i,p] then writeln('Corect!')
                                          else
                                              begin
                                                   writeln('GRESIT');
                                                   goto rep;
                                              end;
                  end;
         end;
end;
procedure calc_pro;
begin
     for i:=1 to n do
         begin
              for p:=1 to 3 do
                  begin
                       f[i,p]:=0;
                       f[i,p]:=z[i]*a[i,p];
                  end;
         end;
end;
procedure afis_vect;
begin
     for i:=1 to n do
         begin
              write('F~',i,' = ');
              if f[i,1]<>0 then write(f[i,1]:2:2,'*i~');
              if f[i,2]<>0 then
                 begin
                      if f[i,2]>0 then write(' + ',f[i,2]:2:2,'*j~')
                                  else write(f[i,2]:2:2,'*j~');
                 end;
              if f[i,3]<>0 then
                 begin
                      if f[i,3]>0 then writeln(' + ',f[i,3]:2:2,'*k~')
                                  else writeln(f[i,3]:2:2,'*k~')
                 end
                           else writeln;
              if f[i,1]=0 then
                 if f[i,2]=0 then
                    if f[i,3]=0 then writeln(0);
              writeln;
              rad:=f[i,1]*f[i,1]+f[i,2]*f[i,2]+f[i,3]*f[i,3];
              writeln('F',i,' = ',sqrt(rad):2:2,' N');
              writeln;
         end;
end;
procedure calc_rez;
begin
     writeln('Introduceti relatia de calcul a rezultantei(fara spatii:A~=B1~+...):');
     writeln;
     readln(rez);
     writeln;
     if rez='R~=F1~+F2~+F3~+F4~' then
                                begin
                                     writeln('CORECT');
                                     tasta:=readkey;
                                end
                            else writeln('Corect este:R~=F1~+F2~+F3~+F4~');
     writeln;
     writeln('Rezultanta R~ este de forma: R~ = Rx*i~ + Ry*j~ + Rz*k~');
     writeln;
     writeln('Calculind Rx,Ry si Rz rezulta ca:');writeln;
     for i:=1 to 3 do r[i]:=0;
     for i:=1 to n do
         begin
              r[1]:=r[1]+f[i,1];
              r[2]:=r[2]+f[i,2];
              r[3]:=r[3]+f[i,3];
         end;
     write('R~ = ');
     if r[1]<>0 then write(r[1]:2:2,'*i~');
     if r[2]<>0 then
        if r[2]>0 then write('+',r[2]:2:2,'*j~')
                  else write(r[2]:2:2,'*j~');
     if r[3]<>0 then
                    if r[3]>0 then writeln('+',r[3]:2:2,'*k~')
                              else writeln(r[3]:2:2,'*k~')
                else writeln;
     writeln;
     rad:=putere(abs(r[1]),2)+putere(abs(r[2]),2)+putere(abs(r[3]),2);
     writeln('Modulul rezultantei este:  R = ',sqrt(rad):2:2,' N');
end;
procedure afisgenmom;
label rep;
begin
     writeln;
     writeln('1.b Calculul momentului rezultant.');
     writeln;
     writeln('Momentul fortei Fi~ in raport cu punctul O se calculeaza cu:');
     writeln;
     writeln('       |  i~   j~   k~  |');
     writeln('Moi~ = |  xi   yi   zi  |');
     writeln('       |  Fxi  Fyi  Fzi |');
     writeln;
     writeln('Introduceti coordonatele punctelor de aplicatie ale fortelor:');
     for i:=1 to n do
         begin
              writeln;
              writeln('Pentru forta ',i);
              for p:=1 to 3 do
                  begin
rep:                   if p=1 then write ('x',i,'=');
                       if p=2 then write ('y',i,'=');
                       if p=3 then write ('z',i,'=');
                       readln(x[i,p]);
                       if x[i,p]=h[i,p] then writeln('Corect!')
                                          else
                                              begin
                                                   writeln('GRESIT');
                                                   goto rep;
                                              end;
                  end;
         end;
     for i:=1 to n do
         begin
              m[i,1]:=f[i,3]*x[i,2]-f[i,2]*x[i,3];
              m[i,2]:=f[i,1]*x[i,3]-f[i,3]*x[i,1];
              m[i,3]:=f[i,2]*x[i,1]-f[i,1]*x[i,2];
         end;
     writeln;
     writeln('Momentele calculate sint:');
     writeln;
     for i:=1 to n do
         begin
              if i<>1 then begin
              write('Mo~',i,' =');
              if m[i,1]<>0 then write(m[i,1]:2:2,'*i~');
              if m[i,2]<>0 then
                 begin
                      if m[i,2]>0 then write('+',m[i,2]:2:2,'*j~')
                                  else write(m[i,2]:2:2,'*j~');
                 end;
              if m[i,3]<>0 then
                               begin
                                    if m[i,3]>0 then writeln('+',m[i,3]:2:2,'*k~')
                                                else writeln(m[i,3]:2:2,'*k~');
                               end
                           else writeln;
                           end;
              if m[i,1]=0 then
                 if m[i,2]=0 then
                    if m[i,3]=0 then writeln('Mo~',i,' = 0~');
              rad:=m[i,1]*m[i,1]+m[i,2]*m[i,2]+m[i,3]*m[i,3];
              writeln('Mo',i,' = ',sqrt(rad):2:2,' Nm');
              writeln;
         end;
end;
procedure mom_cup;
label rep;
begin
     writeln;
     writeln;
     writeln('Introduceti momentul pentru cuplul M5~ si pentru cuplul M6~, de forma:');
     writeln;
     writeln('Mi~ = Mxi*i~ + Myi*j~ + Mzi*k~');
     writeln;
     for i:=5 to 6 do
         begin
              for p:=1 to 3 do
                  begin
rep:                   if p=1 then write('Mx',i,'=');
                       if p=2 then write('My',i,'=');
                       if p=3 then write('Mz',i,'=');
                       readln(mc[i,p]);
                       if mc[i,p]=q[i,p] then writeln('Corect!')
                                          else
                                              begin
                                                   writeln('GRESIT');
                                                   goto rep;
                                              end;
                       writeln;
                  end;
         end;
end;
procedure mom_rez ;
begin
     writeln('Introduceti relatia de calcul a mom. rezultant (fara spatii:A~=B1~+...):');
     writeln;
     readln(mom);
     writeln;
     if mom='Mo~=Mo1~+Mo2~+Mo3~+Mo4~+M5~+M6~' then
                                begin
                                     writeln('CORECT');
                                     tasta:=readkey;
                                end
                            else writeln('Corect este:Mo~=Mo1~+Mo2~+Mo3~+Mo4~+M5~+M6~');
     writeln;
     for i:=1 to n do mr[i]:=0;
     for i:=1 to n do
         begin
              mr[1]:=mr[1]+m[i,1];
              mr[2]:=mr[2]+m[i,2];
              mr[3]:=mr[3]+m[i,3];
         end;
     for i:=5 to 6 do
         begin
              mr[1]:=mr[1]+mc[i,1];
              mr[2]:=mr[2]+mc[i,2];
              mr[3]:=mr[3]+mc[i,3];
         end;
     writeln('Momentul rezultant este:');
     write('Mo~ = ');
     if mr[1]<>0 then write(mr[1]:2:2,'*i~');
     if mr[2]<>0 then
        begin
             if mr[2]>0 then write('+',mr[2]:2:2,'*j~')
                        else write(mr[2]:2:2,'*j~');
        end;
     if mr[3]<>0 then
                     begin
                          if mr[3]>0 then write('+',mr[3]:2:2,'*k~')
                                     else write(mr[3]:2:2,'*k~');
                     end
                 else writeln;
     writeln;
     rad:=mr[1]*mr[1]+mr[2]*mr[2]+mr[3]*mr[3];
     writeln('Mo = ',sqrt(rad):2:1,' Nm');
end;
procedure para1;
const t=250;

var i:integer;

begin
     rectangle(150,150,400,350);
     line(50,450,50,445);
     line(55,450,50,450);
     line(250,50,500,50);
     line(250,0,245,5);
     line(250,0,255,5);
     line(600,250,595,245);
     line(600,250,595,255);
     line(250,50,500,50);
     line(500,50,500,250);
     line(150,150,250,50);
     line(400,150,500,50);
     line(400,350,500,250);
     line(250,0,250,50);
     line(240,10,240,60);
     line(230,20,230,70);
     line(220,30,220,80);
     line(210,40,210,90);
     line(200,50,200,100);
     line(190,60,190,110);
     line(180,70,180,120);
     line(170,80,170,130);
     line(160,90,160,140);
     line(150,350,50,450);
     line(500,250,600,250);
     line(150,100,150,150);
     for i:=0 to 10 do line(t-i*10,50+i*10,t-i*10+5,50+i*10-10);
     for i:=0 to 10 do line(t-i*10,50+i*10,t-i*10-5,50+i*10-10);
     setlinestyle(dottedln,0,normwidth);
     line(150,350,250,250);
     line(250,250,500,250);
     line(250,50,250,250);
     line(400,350,500,50);
     line(250,50,400,350);
     line(250,250,400,150);
     line(150,150,500,50);
     setlinestyle(solidln,0,thickwidth);
     line(250,250,325,400);
     line(325,400,327,395);
     line(325,400,319,398);
     line(250,250,170,250);
     line(200,50,200,100);
     line(170,250,175,245);
     line(170,250,175,255);
     line(250,250,350,184);
     line(350,184,345,184);
     line(350,184,348,190);
     line(250,50,295,140);
     line(295,140,290,137);
     line(295,140,295,135);
     line(500,50,380,84);
     line(380,84,385,80);
     line(380,84,387,85);
     line(400,350,440,228);
     line(440,228,435,233);
     line(440,228,440,235);
     line(200,100,205,90);
     line(200,100,195,90);
     window(1,1,200,200);
     gotoxy(25,3);
     write('F4');
     gotoxy(48,5);
     write('F2');
     gotoxy(35,9);
     write('F3');
     gotoxy(22,15);
     write('F1');
     gotoxy(45,13);
     write('M5');
     gotoxy(53,15);
     write('M6');
     gotoxy(17,15);
     write('L');
     gotoxy(18,16);
     write('3');
     gotoxy(35,23);
     write('L');
     gotoxy(36,24);
     write('1');
     gotoxy(58,20);
     write('L');
     gotoxy(59,21);
     write('2');
     gotoxy(33,1);write('z');
     gotoxy(75,17);write('y');
     gotoxy(8,25);write('x');
     gotoxy(43,25);write('Mo');

end;
procedure mom_min;
begin
     writeln('2.Calculul momentului minimal MR~.');
     writeln;
     writeln('Introduceti relatia de calcul a momentului minimal, scalar si vectorial:');
     writeln('A.SCALAR:(MR=(x*y)/z*(p/q)');
     writeln;
     readln(rez);
     writeln;
     if rez='MR=(R~*Mo~)/R' then
                                begin
                                     writeln('CORECT');
                                     tasta:=readkey;
                                end
                            else writeln('Corect este:MR=(R~*Mo~)/R');
     writeln('B.VECTORIAL:(MR~=(x*y)/z*(p/q)');
     writeln;
     readln(rez);
     writeln;
     if rez='MR~=(R~*Mo~)/R*(R~/R)' then
                                begin
                                     writeln('CORECT');
                                     tasta:=readkey;
                                end
                            else writeln('Corect este:MR~=(R~*Mo~)/R*(R~/R)');
     writeln;
     writeln('Vectorul moment minimal este:');
     writeln;
     mm1:=(r[1]*mr[1]+r[2]*mr[2]+r[3]*mr[3])/sqrt(r[1]*r[1]+r[2]*r[2]+r[3]*r[3]);
     mm[1]:=mm1*r[1];mm[2]:=mm1*r[2];mm[3]:=mm1*r[3];
     write('MR~ = ');
     if mm[1]<>0 then write(mm[1]:2:2,'*i~');
     if mm[2]<>0 then
                 begin
                      if mm[2]>0 then write('+',mm[2]:2:2,'*j~')
                                 else write(mm[2]:2:2,'*j~');
                 end;
     if mm[3]<>0 then
                 begin
                      if mm[3]>0 then writeln('+',mm[3]:2:2,'*k~')
                                 else writeln(mm[3]:2:2,'*k~');
                 end;
     writeln;
     writeln('Modulul momentului minimal este:');
     writeln;
     rad:=r[1]*r[1]+r[2]*r[2]+r[3]*r[3];
     writeln('MR = ',(r[1]*mr[1]+r[2]*mr[2]+r[3]*mr[3])/(abs(sqrt(rad))):2:1);
end;
procedure axa_centrala;
begin
     writeln('3.Calculul axei centrale.');
     writeln('Introduceti rapoartele de calcul ale axei centrale(de forma(a+b*c+...)/d=...):');
     writeln;
     readln(rez);
     writeln;
     if rez='(Mox-y*Rz+z*Ry)/Rx=(Moy-z*Rx+x*Rz)/Ry=(Moz-x*Ry+y*Rx)/Rz' then
                                begin
                                     writeln('CORECT');
                                     tasta:=readkey;
                                end
                            else writeln('Corect este:(Mox-y*Rz+z*Ry)/Rx=(Moy-z*Rx+x*Rz)/Ry=(Moz-x*Ry+y*Rx)/Rz ');
     writeln;
     writeln('Axa centrala are ecuatiile:');
     writeln;
     write(r[1]*r[3]:2:2,'*x');
     if r[2]*r[3]>0 then write('+',r[2]*r[3]:2:2,'*y')
                    else write(r[2]*r[3]:2:2,'*y');
     if r[1]*r[1]+r[2]*r[2]>0 then write('-',r[1]*r[1]+r[2]*r[2]:2:1,'*z')
                              else write('+',r[1]*r[1]+r[2]*r[2]:2:1,'*z');
     writeln(' = ',r[2]*mr[1]-r[1]*mr[2]:2:2);
     write(r[3]*r[3]+r[2]*r[2]:2:2,'*x');
     if r[2]*r[1]>0 then write('-',r[2]*r[1]:2:2,'*y')
                    else write('+',r[2]*r[1]:2:2,'*y');
     if r[3]*r[1]>0 then write('-',r[3]*r[1]:2:2,'*y')
                    else write('+',r[3]*r[1]:2:2,'*y');
     writeln(' = ',r[2]*mr[3]-r[3]*mr[2]:2:2);
end;
begin
     Init;
     cos_corect;
     enunt;
     tasta:=readkey;
     para;
     tasta:=readkey;
{      z[1]:=20;
      z[2]:=30;
      z[3]:=40;
      z[4]:=2*1.73;
     afisare;
     tasta:=readkey;
     citire_cos;
     calc_pro;
     writeln;
     afis_vect;
     calc_rez;
     afisgenmom;
     mom_cup;
     mom_rez;
     tasta:=readkey;
     Init;
     para1;
     tasta:=readkey;
     closegraph;
     mom_min;
     axa_centrala;
     tasta:=readkey;
     Init;
     para;
     tasta:=readkey;
     closegraph;}
end.