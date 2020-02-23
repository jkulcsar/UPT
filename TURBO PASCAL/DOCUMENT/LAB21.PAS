program reducere_forte;

uses graph,crt;

const
     n=4;
     gd=0;
     gm=2;
           orizontala     = #205;   Spatiu = '        ';
           verticala      = #186;
           ColtStingaSus  = #201;
           ColtStingaJos  = #200;
           ColtDreaptaSus = #187;
           ColtDreaptaJos = #188;

           SageataSus     =  72;
           SageataJos     =  80;
           SageataDreapta =  77;
           SageataStinga  =  75;

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
var ch : char;
begin
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, True);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutTextXY(200,1,'Calculul rezultantei fortelor : ');
     SetTextStyle( SmallFont, HorizDir, 4 );

     OutTextXY(100,20,' Fortele au urmatoarea forma : ');
     WriteVector(3,60,'F','i');OutTextXY(20,60,' = ');
     WriteVector(30,60,'F','ix');OutTextXY(50,60,' + ');
     WriteVector(60,60,'F','iy');OutTextXY(80,60,' + ');
     WriteVector(90,60,'F','iz');     OutTextXY(170,60,' unde : ');

     WriteScalar(250,40,'F','ix');OutTextXY(270,40,' = ');
     WriteScalar(280,40,'F','i');OutTextXY(300,40,' * ');OutTextXY(320,40,'cos(');
     WriteScalar(340,40,'F','i');OutTextXY(365,40,',Ox )');

     WriteScalar(250,60,'F','iy');OutTextXY(270,60,' = ');
     WriteScalar(280,60,'F','i');OutTextXY(300,60,' * ');OutTextXY(320,60,'cos(');
     WriteScalar(340,60,'F','i');OutTextXY(365,60,',Oy )');

     WriteScalar(250,80,'F','iz');OutTextXY(270,80,' = ');
     WriteScalar(280,80,'F','i');OutTextXY(300,80,' * ');OutTextXY(320,80,'cos(');
     WriteScalar(340,80,'F','i');OutTextXY(365,80,',Oz )');

     OutTextXY(100,100,' Apasa orice tasta . . . ');
        ch := ReadKey;
        ClearViewPort;
        RestoreViewPort;


{     writeln('Marimea fortei uniform distribuite este:F4 = p*L2 [N]');}
 end;

procedure citire_cos;
var ch : char;
    Indice : string;
    Numar  : string;
    cc     : byte;
begin
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, False);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutTextXY(100,1,' Cosinusii directori : ');
     RestoreViewPort;
     SetViewPort(x0-150,MaxY-100,MaxX-1,MaxY-1,True);
     SetTextStyle( SmallFont, HorizDir, 4 );

     for i:=1 to n do
         begin
              for p:=1 to 3 do
                  begin
                       if p=1 then begin
                                     cc := 1;
                                     repeat
                                        ClearViewPort;
                                        OutTextXY(40,30,'cos( ');
                                        Str(i,Indice);
                                        WriteVector(60,30,'F',Indice);
                                        OutTextXY(100,30,' , Ox ) = ');
                                        MoveTo(150,30);read(a[i,p]);
                                        Str(a[i,p]:5:2,Numar);OutTextXY(150,30,Numar);
                                        if (a[i,p] = cos[i,p]) then begin
                                                                         OutTextXY( 150,50,' Corect. ');
                                                                         cc := 3;
                                                                    end
                                                               else begin
                                                                         OutTextXY( 150,50,' Gresit. ');
                                                                         cc := cc + 1;
                                                                         if cc = 3 then
                                                                         begin
                                                                            OutTextXY(90,70,' Corect este : ');
                                                                            Str(cos[i,p]:5:2,Numar);OutTextXY(150,70,Numar);
                                                                         end;
                                                                    end;
                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;
                       if p=2 then begin
                                     cc := 1;
                                     repeat
                                        ClearViewPort;
                                        OutTextXY(40,30,'cos( ');
                                        Str(i,Indice);
                                        WriteVector(60,30,'F',Indice);
                                        OutTextXY(100,30,' , Oy ) = ');
                                        MoveTo(150,30);read(a[i,p]);
                                        Str(a[i,p]:5:2,Numar);OutTextXY(150,30,Numar);
                                        if (a[i,p] = cos[i,p]) then begin
                                                                         OutTextXY( 150,50,' Corect. ');
                                                                         cc := 3;
                                                                    end
                                                               else begin
                                                                         OutTextXY( 150,50,' Gresit. ');
                                                                         cc := cc + 1;
                                                                         if cc = 3 then
                                                                         begin
                                                                            OutTextXY(90,70,' Corect este : ');
                                                                            Str(cos[i,p]:5:2,Numar);OutTextXY(150,70,Numar);
                                                                         end;
                                                                    end;

                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;
                       if p=3 then begin
                                     cc := 1;
                                     repeat
                                        ClearViewPort;
                                        OutTextXY(40,30,'cos( ');
                                        Str(i,Indice);
                                        WriteVector(60,30,'F',Indice);
                                        OutTextXY(100,30,' , Oz ) = ');
                                        MoveTo(150,30);read(a[i,p]);
                                        Str(a[i,p]:5:2,Numar);OutTextXY(150,30,Numar);
                                        if (a[i,p] = cos[i,p]) then begin
                                                                         OutTextXY( 150,50,' Corect. ');
                                                                         cc := 3;
                                                                    end
                                                               else begin
                                                                         OutTextXY( 150,50,' Gresit. ');
                                                                         cc := cc + 1;
                                                                         if cc = 3 then
                                                                         begin
                                                                            OutTextXY(90,70,' Corect este : ');
                                                                            Str(cos[i,p]:5:2,Numar);OutTextXY(150,70,Numar);
                                                                         end;
                                                                    end;
                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;
                  end;
         end;

end; { Citire_Cos }

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
end; { Calc_Pro }

procedure afis_vect;
var Numar : string;
   Indice : string;
    ch    : char;
begin
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, False);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutTextXY(140,1,' Forma finala a fortelor : ');
     RestoreViewPort;
     SetViewPort(x0-150,MaxY-100,MaxX-1,MaxY-1,True);
     SetTextStyle( SmallFont, HorizDir, 4 );

     for i:=1 to n do
         begin
              Str(i,Indice);
              WriteVector(40,30,'F',Indice);OutTextXY(60,30,' = ');
              if f[i,1]<>0 then begin
                                     Str(f[i,1]:5:2,Numar);
                                     OutTextXY(100,30,Numar);
                                     WriteVector(120,30,'i','');
                                end;

              if f[i,2]<>0 then
                 begin
                      if f[i,2]>0 then begin
                                            OutTextXY(150,30,' + ');
                                            Str(f[i,2]:5:2,Numar);
                                            OutTextXY(170,30,Numar);
                                            WriteVector(190,30,'j','');
                                       end
                                  else begin
                                            Str(f[i,2]:5:2,Numar);
                                            OutTextXY(150,30,Numar);
                                            WriteVector(170,30,'j','');
                                       end;
                 end;
              if f[i,3]<>0 then
                 begin
                      if f[i,3]>0 then begin
                                            OutTextXY(230,30,' + ');
                                            Str(f[i,3]:5:2,Numar);
                                            OutTextXY(250,30,Numar);
                                            WriteVector(270,30,'k','');
                                       end
                                  else begin;
                                            Str(f[i,3]:5:2,Numar);
                                            OutTextXY(230,30,Numar);
                                            WriteVector(250,30,'k','');
                                       end;
                 end;

              rad:=f[i,1]*f[i,1]+f[i,2]*f[i,2]+f[i,3]*f[i,3];
              Str(i,Indice);WriteScalar(40,50,'F',Indice);OutTextXY(60,50,' = ');
              Str(sqrt(rad):5:2,Numar);OutTextXY(100,50,Numar);
              OutTextXY(150,50,' N');

              OutTextXY( 80,70,' Apasa orice tasta . . . ');
              ch := ReadKey;
              ClearViewPort;

         end;
         OutTextXY( 80,70,' Apasa orice tasta . . . ');
         ch := ReadKey;
         ClearViewPort;
end; { Afis_Vect }

  procedure Fereastra( x1,y1,x2,y2 : integer);
  var i : byte;
  begin
    TextColor(White);
    TextBackground(Black);
    Window(1,1,80,23);
    Window(x1,y1,x2,y2);
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
    Window(x1+2,y1+1,x2-3,y2-2);
  end;  { Fereastra }


procedure calc_rez;
var Indice : string;
    Numar  : string;
    ch     : char;
    rez    : string;
begin

     CloseGraph;
     Fereastra(1,1,70,10);
     writeln('Introduceti relatia de calcul a rezultantei : ');
     writeln('fara spatii : A~=B1~+... ');
     writeln('Semnul tilda inseamna `vector` ');
     write('Relatia este : '); readln(rez);
     if rez='R~=F1~+F2~+F3~+F4~' then
                                begin
                                     writeln(' CORECT');
                                     write(' Apasa orice tasta . . . ');
                                     tasta:=readkey;
                                end
                            else begin
                                      writeln(' Corect este:R~=F1~+F2~+F3~+F4~');
                                      write(' Apasa orice tasta . . . ');
                                      tasta := ReadKey;
                                 end;
     Init;
     Para;
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, True);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutTextXY(200,1,'Rezultanta fortelor : ');
     SetTextStyle( SmallFont, HorizDir, 4 );

     OutTextXY(100,20,' Rezultanta are urmatoarea forma : ');
     WriteVector(3,40,'R','');OutTextXY(20,40,' = ');
     WriteVector(30,40,'R','x');OutTextXY(50,40,' + ');
     WriteVector(60,40,'R','y');OutTextXY(80,40,' + ');
     WriteVector(90,40,'R','z');


     for i:=1 to 3 do r[i]:=0;
     for i:=1 to n do
         begin
              r[1]:=r[1]+f[i,1];
              r[2]:=r[2]+f[i,2];
              r[3]:=r[3]+f[i,3];
         end;
     WriteVector(3,60,'R','');OutTextXY(20,60,' = ');
     if r[1]<>0 then begin
                          Str(r[1]:5:2,Numar);
                          OutTextXY(50,60,Numar);WriteVector(70,60,'i','');
                     end;
     if r[2]<>0 then
        if r[2]>0 then begin
                            Str(r[2]:5:2,Numar);
                            OutTextXY(90,60,' + ');OutTextXY(110,60,Numar);
                            WriteVector(130,60,'j','');
                       end
                  else begin
                            Str(r[2]:5:2,Numar);
                            OutTextXY(90,60,Numar);WriteVector(110,60,'j','');
                       end;
     if r[3]<>0 then
                    if r[3]>0 then begin
                                        Str(r[3]:5:2,Numar);OutTextXY(150,60,' + ');
                                        OutTextXY(170,60,Numar);WriteVector(190,60,'k','');
                                   end
                              else begin
                                        Str(r[3]:5:2,Numar);
                                        OutTextXY(150,60,Numar);
                                        WriteVector(170,60,'k','');
                                   end;

     rad:=putere(abs(r[1]),2)+putere(abs(r[2]),2)+putere(abs(r[3]),2);
     Str(sqrt(rad):5:2,Numar);
     WriteScalar(3,80,'R','');OutTextXY(40,80,' = '+Numar);
     OutTextXY(100,100,' Apasa orice tasta . . . ');
     ch := ReadKey;
     ClearViewPort;
   end;

procedure afisgenmom;
var Indice : string;
    Numar  : string;
    ch     : char;
    cc     : byte;
begin
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, True);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutTextXY(150,1,'Calculul momentului rezultant : ');
     SetTextStyle( SmallFont, HorizDir, 4 );

     OutTextXY(40,20,' Momentul fortei ');
     WriteVector(120,20,'F','i');
     OutTextXY(130,40,' in raport cu punctul O se calculeaza cu : ');
     WriteVector(100,80,'M','o');OutTextXY(120,80,' = ');
     Line(140,55,140,110);
     WriteVector(160,60,'i','');WriteVector(180,60,'j','');WriteVector(200,60,'k','');
     WriteScalar(160,80,'x','i');WriteScalar(180,80,'y','i');WriteScalar(200,80,'z','i');
     WriteScalar(160,100,'F','ix');WriteScalar(180,100,'F','iy');WriteScalar(200,100,'F','iz');
     Line(225,55,225,110);OutTextXY(320,100,'Apasa orice tasta . . .');
     ch := ReadKey;
     ClearViewPort;
     OutTextXY(140,1,'Introduceti coordonatele punctelor de aplicatie ale fortelor:');
     for i:=1 to n do
         begin
              Str(i,Indice);
              OutTextXY(40,20,'Pentru forta '+ Indice);
              for p:=1 to 3 do
                  begin
                   if p=1 then begin
                                    cc := 1;
                                    repeat
                                       WriteScalar(80,40,'x',Indice);
                                       OutTextXY(100,40,' = ');
                                       readln(x[i,p]);
                                       Str(x[i,p]:5:2,Numar);
                                       OutTextXY(120,40,Numar);
                                       if x[i,p]=h[i,p] then begin
                                                                OutTextXY(120,60,'Corect.');
                                                                cc := 3;
                                                             end
                                                         else begin
                                                                 OutTextXY(120,60,'Gresit.');
                                                                 cc := cc + 1;
                                                                 if cc = 3 then
                                                                    begin
                                                                       OutTextXY(90,80,' Corect este : ');
                                                                       Str(h[i,p]:5:2,Numar);OutTextXY(150,70,Numar);
                                                                    end;
                                                              end;

                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;

                   if p=2 then begin
                                    cc := 1;
                                    repeat
                                       WriteScalar(80,40,'y',Indice);
                                       OutTextXY(100,40,' = ');
                                       readln(x[i,p]);
                                       Str(x[i,p]:5:2,Numar);
                                       OutTextXY(120,40,Numar);
                                       if x[i,p]=h[i,p] then begin
                                                                OutTextXY(120,60,'Corect.');
                                                                cc := 3;
                                                             end
                                                         else begin
                                                                 OutTextXY(120,60,'Gresit.');
                                                                 cc := cc + 1;
                                                                 if cc = 3 then
                                                                    begin
                                                                       OutTextXY(90,80,' Corect este : ');
                                                                       Str(h[i,p]:5:2,Numar);OutTextXY(150,70,Numar);
                                                                    end;
                                                              end;

                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;

                   if p=3 then begin
                                    cc := 1;
                                    repeat
                                       WriteScalar(80,40,'z',Indice);
                                       OutTextXY(100,40,' = ');
                                       readln(x[i,p]);
                                       Str(x[i,p]:5:2,Numar);
                                       OutTextXY(120,40,Numar);
                                       if x[i,p]=h[i,p] then begin
                                                                OutTextXY(120,60,'Corect.');
                                                                cc := 3;
                                                             end
                                                         else begin
                                                                 OutTextXY(120,60,'Gresit.');
                                                                 cc := cc + 1;
                                                                 if cc = 3 then
                                                                    begin
                                                                       OutTextXY(90,80,' Corect este : ');
                                                                       Str(h[i,p]:5:2,Numar);OutTextXY(150,70,Numar);
                                                                    end;
                                                              end;

                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;

                  end;
         end;
         ClearViewPort;
     for i:=1 to n do
         begin
              m[i,1]:=f[i,3]*x[i,2]-f[i,2]*x[i,3];
              m[i,2]:=f[i,1]*x[i,3]-f[i,3]*x[i,1];
              m[i,3]:=f[i,2]*x[i,1]-f[i,1]*x[i,2];
         end;
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, False);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutTextXY(100,1,' Forma finala a momentelor : ');
     RestoreViewPort;
     SetViewPort(x0-150,MaxY-100,MaxX-1,MaxY-1,True);
     SetTextStyle( SmallFont, HorizDir, 4 );

     for i:=1 to n do
         begin
              Str(i,Indice);
              WriteVector(40,30,'M',Indice);OutTextXY(60,30,' = ');
              if m[i,1]<>0 then begin
                                     Str(m[i,1]:5:2,Numar);
                                     OutTextXY(100,30,Numar);
                                     WriteVector(120,30,'i','');
                                end;

              if m[i,2]<>0 then
                 begin
                      if m[i,2]>0 then begin
                                            OutTextXY(150,30,' + ');
                                            Str(m[i,2]:5:2,Numar);
                                            OutTextXY(170,30,Numar);
                                            WriteVector(190,30,'j','');
                                       end
                                  else begin
                                            Str(m[i,2]:5:2,Numar);
                                            OutTextXY(150,30,Numar);
                                            WriteVector(170,30,'j','');
                                       end;
                 end;
              if m[i,3]<>0 then
                 begin
                      if m[i,3]>0 then begin
                                            OutTextXY(230,30,' + ');
                                            Str(m[i,3]:5:2,Numar);
                                            OutTextXY(250,30,Numar);
                                            WriteVector(270,30,'k','');
                                       end
                                  else begin;
                                            Str(m[i,3]:5:2,Numar);
                                            OutTextXY(230,30,Numar);
                                            WriteVector(250,30,'k','');
                                       end;
                 end;

              rad:=m[i,1]*m[i,1]+m[i,2]*m[i,2]+m[i,3]*m[i,3];
              Str(i,Indice);WriteScalar(40,50,'M',Indice);OutTextXY(60,50,' = ');
              Str(sqrt(rad):5:2,Numar);OutTextXY(100,50,Numar);
              OutTextXY(150,50,' Nm');

              OutTextXY( 80,70,' Apasa orice tasta . . . ');
              ch := ReadKey;
              ClearViewPort;

         end;
         OutTextXY( 80,70,' Apasa orice tasta . . . ');
         ch := ReadKey;
         ClearViewPort;
end;

procedure mom_cup;
var Numar : string;
    Indice : string;
    ch     : char;
    cc     : byte;
begin
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, True);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 4 );
     OutTextXY(150,1,'Introduceti valorile momentelor M5 si M6 :');
     OutTextXY(150,20,' Momentele au urmatoarea forma : ');
     WriteVector(3,60,'M','i');OutTextXY(20,60,' = ');
     WriteVector(30,60,'M','ix');OutTextXY(50,60,' + ');
     WriteVector(60,60,'M','iy');OutTextXY(80,60,' + ');
     WriteVector(90,60,'M','iz');

     ch := ReadKey;
     ClearViewPort;
     for i:=5 to 6 do
         begin
              Str(i,Indice);
              OutTextXY(80,20,'Pentru momentul '+ Indice);
              for p:=1 to 3 do
                  begin
                   if p=1 then begin
                                    cc := 1;
                                    repeat
                                       WriteScalar(80,40,'M','x'+Indice);
                                       OutTextXY(100,40,' = ');
                                       readln(mc[i,p]);
                                       Str(mc[i,p]:5:2,Numar);
                                       OutTextXY(120,40,Numar);
                                       if mc[i,p]=q[i,p] then begin
                                                                OutTextXY(120,60,'Corect.');
                                                                cc := 3;
                                                             end
                                                         else begin
                                                                 OutTextXY(140,60,'Gresit.');
                                                                 cc := cc + 1;
                                                                 if cc = 3 then
                                                                    begin
                                                                       OutTextXY(120,80,' Corect este : ');
                                                                       Str(q[i,p]:5:2,Numar);OutTextXY(150,80,Numar);
                                                                    end;
                                                              end;
                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;


                   if p=2 then begin
                                    cc := 1;
                                    repeat
                                       WriteScalar(80,40,'M','y'+Indice);
                                       OutTextXY(100,40,' = ');
                                       readln(mc[i,p]);
                                       Str(mc[i,p]:5:2,Numar);
                                       OutTextXY(120,40,Numar);
                                       if mc[i,p]=q[i,p] then begin
                                                                OutTextXY(120,60,'Corect.');
                                                                cc := 3;
                                                             end
                                                         else begin
                                                                 OutTextXY(140,60,'Gresit.');
                                                                 cc := cc + 1;
                                                                 if cc = 3 then
                                                                    begin
                                                                       OutTextXY(120,80,' Corect este : ');
                                                                       Str(q[i,p]:5:2,Numar);OutTextXY(150,80,Numar);
                                                                    end;
                                                              end;

                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;

                   if p=3 then begin
                                    cc := 1;
                                    repeat
                                       WriteScalar(80,40,'M','z'+Indice);
                                       OutTextXY(100,40,' = ');
                                       readln(mc[i,p]);
                                       Str(mc[i,p]:5:2,Numar);
                                       OutTextXY(120,40,Numar);
                                       if mc[i,p]=q[i,p] then begin
                                                                OutTextXY(120,60,'Corect.');
                                                                cc := 3;
                                                             end
                                                         else begin
                                                                 OutTextXY(140,60,'Gresit.');
                                                                 cc := cc + 1;
                                                                 if cc = 3 then
                                                                    begin
                                                                       OutTextXY(120,80,' Corect este : ');
                                                                       Str(q[i,p]:5:2,Numar);OutTextXY(120,80,Numar);
                                                                    end;
                                                              end;

                                        OutTextXY(90,80,' Apasa orice tasta . . . ');
                                        ch := ReadKey;
                                        ClearViewPort;
                                     until cc = 3;
                                   end;
         end;
         ClearViewPort;
         end;
end;

procedure mom_rez ;
var mom : string;
    Numar  : string;
    Indice : string;
    cc     : byte;
    ch     : char;
begin

     CloseGraph;
     Fereastra(1,1,70,10);
     writeln('Introduceti relatia de calcul a rezultantei : ');
     writeln('fara spatii : A~=B1~+... ');
     writeln('Semnul tilda inseamna `vector` ');writeln;
     write('Relatia este : '); readln(mom);
     if mom='Mo~=Mo1~+Mo2~+Mo3~+Mo4~+M5+M6' then
                                begin
                                     writeln(' CORECT');
                                     write(' Apasa orice tasta . . . ');
                                     tasta:=readkey;
                                end
                            else begin
                                      writeln(' Corect este:Mo~=Mo1~+Mo2~+Mo3~+Mo4~+M5+M6');
                                      write(' Apasa orice tasta . . . ');
                                      tasta := ReadKey;
                                 end;
     Init;
     Para;
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, True);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutTextXY(200,1,'Rezultanta momentelor : ');
     SetTextStyle( SmallFont, HorizDir, 4 );

     OutTextXY(100,20,' Rezultanta are urmatoarea forma : ');
     WriteVector(13,40,'Mo','');OutTextXY(30,40,' = ');
     WriteVector(40,40,'Mo','x');OutTextXY(60,40,' + ');
     WriteVector(70,40,'Mo','y');OutTextXY(90,40,' + ');
     WriteVector(100,40,'Mo','z');


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

     WriteVector(10,60,'Mo','');OutTextXY(30,60,' = ');
     if mr[1]<>0 then begin
                          Str(mr[1]:5:2,Numar);
                          OutTextXY(50,60,Numar);WriteVector(70,60,'i','');
                     end;
     if mr[2]<>0 then
        if mr[2]>0 then begin
                            Str(mr[2]:5:2,Numar);
                            OutTextXY(90,60,' + ');OutTextXY(110,60,Numar);
                            WriteVector(130,60,'j','');
                       end
                  else begin
                            Str(mr[2]:5:2,Numar);
                            OutTextXY(90,60,Numar);WriteVector(110,60,'j','');
                       end;
     if mr[3]<>0 then
                    if mr[3]>0 then begin
                                        Str(mr[3]:5:2,Numar);OutTextXY(150,60,' + ');
                                        OutTextXY(170,60,Numar);WriteVector(190,60,'k','');
                                   end
                              else begin
                                        Str(mr[3]:5:2,Numar);
                                        OutTextXY(150,60,Numar);
                                        WriteVector(170,60,'k','');
                                   end;

     rad:=putere(abs(mr[1]),2)+putere(abs(mr[2]),2)+putere(abs(mr[3]),2);
     Str(sqrt(rad):5:2,Numar);
     WriteScalar(3,80,'Mo','');OutTextXY(40,80,' = '+Numar);
     OutTextXY(100,100,' Apasa orice tasta . . . ');
     ch := ReadKey;
     ClearViewPort;
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
var rez : string;
    Numar : string;
    Indice : string;
    cc     : byte;
    ch     : char;
    Nr     : real;
begin
     CloseGraph;
     Fereastra(1,1,70,30);
     writeln(' Relatia de calcul a momentului minimal : ');
     writeln('Semnul tilda inseamna `vector` ');writeln;
     writeln;write(' Scalar    : MR =(R~*Mo~)/R ');
     writeln;write(' Vectorial : MR~=(R~*Mo~)/R*(R~/R)');
     writeln;write(' Apasa orice tasta . . . ');
      ch := ReadKey;
     Init;
     Para1;
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, True);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     SetTextStyle( SmallFont, HorizDir, 4 );

     OutTextXY(100,20,' Vectorul moment minimal este : ');

     mm1:=(r[1]*mr[1]+r[2]*mr[2]+r[3]*mr[3])/sqrt(r[1]*r[1]+r[2]*r[2]+r[3]*r[3]);
     mm[1]:=mm1*r[1];mm[2]:=mm1*r[2];mm[3]:=mm1*r[3];

     WriteVector(3,60,'Mm','');OutTextXY(20,60,' = ');
     if mm[1]<>0 then begin
                          Str(mm[1]:5:2,Numar);
                          OutTextXY(50,60,Numar);WriteVector(70,60,'i','');
                     end;
     if mm[2]<>0 then
        if mm[2]>0 then begin
                            Str(mm[2]:5:2,Numar);
                            OutTextXY(90,60,' + ');OutTextXY(110,60,Numar);
                            WriteVector(130,60,'j','');
                       end
                  else begin
                            Str(mm[2]:5:2,Numar);
                            OutTextXY(90,60,Numar);WriteVector(110,60,'j','');
                       end;
     if mm[3]<>0 then
                    if mm[3]>0 then begin
                                        Str(mm[3]:5:2,Numar);OutTextXY(150,60,' + ');
                                        OutTextXY(170,60,Numar);WriteVector(190,60,'k','');
                                   end
                              else begin
                                        Str(mm[3]:5:2,Numar);
                                        OutTextXY(150,60,Numar);
                                        WriteVector(170,60,'k','');
                                   end;
     rad:=r[1]*r[1]+r[2]*r[2]+r[3]*r[3];
     Nr :=(r[1]*mr[1]+r[2]*mr[2]+r[3]*mr[3])/(abs(sqrt(rad)));
     Str(sqrt(rad):5:2,Numar);
     WriteScalar(3,80,'Mm','');OutTextXY(40,80,' = '+Numar);
     OutTextXY(100,100,' Apasa orice tasta . . . ');
     ch := ReadKey;
     ClearViewPort;
  end;


procedure axa_centrala;
var rez : string;
    Numar : string;
    Indice : string;
    cc     : byte;
    ch     : char;
    Nr     : real;
begin
     CloseGraph;
     Fereastra(1,1,79,30);
     writeln;
     writeln(' Relatia de calcul a axei centrale : ');
     writeln;write(' (Mox-y*Rz+z*Ry)/Rx=(Moy-z*Rx+x*Rz)/Ry=(Moz-x*Ry+y*Rx)/Rz' );
     writeln;write(' Apasa orice tasta . . . ');
      ch := ReadKey;
     Init;
     Rectangle( x0-175, MaxY-121, MaxX, MaxY );
     SetViewPort( x0-150,MaxY-120, MaxX-1, MaxY-1, True);
     ClearViewPort;
     SetTextStyle( SmallFont, HorizDir, 6 );
     OutTextXY(140,1,' Axa centrala are ecuatiile : ');
     SetTextStyle( SmallFont, HorizDir, 4 );

     Str(r[1]*r[3]:5:2,Numar);OutTextXY(20,20,Numar+'*x');
     if r[2]*r[3]>0 then begin
                              Str(r[2]*r[3]:5:2,Numar);
                              OutTextXY(70,20,'+'+Numar+'*y');
                         end
                    else begin
                              Str(r[2]*r[3]:5:2,Numar);
                              OutTextXY(70,20,Numar+'*y');
                         end;
     if r[1]*r[1]+r[2]*r[2]>0 then begin
                                        Str(r[1]*r[1]+r[2]*r[2]:5:2,Numar);
                                        OutTextXY(120,20,'-'+Numar+'*z');
                                   end
                              else begin
                                        Str(r[1]*r[1]+r[2]*r[2]:5:2,Numar);
                                        OutTextXY(120,20,'+'+Numar+'*z');
                                   end;
     Str(r[2]*mr[1]-r[1]*mr[2]:5:2,Numar);
     OutTextXY(170,20,' = '+Numar);

     Str(r[3]*r[3]+r[2]*r[2]:5:2,Numar);OutTextXY(20,40,Numar+'*x');
     if r[2]*r[1]>0 then begin
                              Str(r[2]*r[1]:5:2,Numar);
                              OutTextXY(70,40,'-'+Numar+'*y');
                         end
                    else begin
                              Str(r[2]*r[1]:5:2,Numar);
                              OutTextXY(70,40,'+'+Numar+'*y');
                         end;
     if r[3]*r[1]>0 then begin
                              Str(r[3]*r[1]:5:2,Numar);
                              OutTextXY(120,40,'-'+Numar+'*z');
                         end
                    else begin
                              Str(r[3]*r[1]:5:2,Numar);
                              OutTextXY(120,40,'+'+Numar+'*z');
                         end;

     Str(r[2]*mr[3]-r[3]*mr[2]:5:2,Numar);
     OutTextXY(170,40,'='+Numar);
end;
begin
     Init;
     cos_corect;
     enunt;
     tasta:=readkey;
     para;
     tasta:=readkey;
      z[1]:=20;
      z[2]:=30;
      z[3]:=40;
      z[4]:=2*1.73;
     afisare;
     citire_cos;
     calc_pro;
     afis_vect;
     calc_rez;
    afisgenmom;
     mom_cup;
     mom_rez;
     tasta:=readkey;
     para1;
     tasta:=readkey;
     mom_min;
     axa_centrala;
     closegraph;
end.