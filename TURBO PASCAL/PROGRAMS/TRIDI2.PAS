program incercare_grafica;
uses crt,graph;
var c,ci:array[1..100,1..3] of longint;
    p:array[1..100,1..2] of longint;
    m:array[1..100,1..2] of longint;
    i,j,k,nv,nm,z0:integer;
    gd,gm,page,x,y,z:integer;
    ch:char;
    var sin1,cos1:array[1..360] of real;


procedure calc_trig;
var i:integer;
    u:real;
begin
     for i:=1 to 360 do begin
         sin1[i]:=sin(i*pi/180);
         cos1[i]:=cos(i*pi/180);
     end;
end;

procedure rest;
var i,j:integer;
begin
     for i:=1 to 8 do
         for j:=1 to 3 do c[i,j]:=ci[i,j];
end;


procedure translatie(tx,ty,tz:integer);
var i:integer;
begin
     if tx<>0 then for i:=1 to nv do c[i,1]:=c[i,1]+tx;
     if ty<>0 then for i:=1 to nv do c[i,2]:=c[i,2]+ty;
     if tz<>0 then for i:=1 to nv do c[i,3]:=c[i,3]+tz;
end;

procedure afiseaza;
var i:integer;
begin
      setactivepage(page);setvisualpage(1-page);
     cleardevice;
     for i:=1 to nm do
         line(p[m[i,1],1],200-p[m[i,1],2],p[m[i,2],1],200-p[m[i,2],2]);
      setvisualpage(page);setactivepage(1-page);
     page:=1-page;
end;

procedure rotatie(rx,ry,rz:integer);
var j:integer;
    inx,iny,inz:integer;
begin
     if rx<>0 then for j:=1 to nv do begin
            iny:=c[j,2];inz:=c[j,3];
            c[j,2]:=trunc(iny*cos1[rx]+inz*sin1[rx]);
            c[j,3]:=trunc(-iny*sin1[rx]+inz*cos1[rx]);
     end;
     if ry<>0 then for j:=1 to nv do begin
            inx:=c[j,1];inz:=c[j,3];
            c[j,1]:=trunc(-inz*sin1[ry]+inx*cos1[ry]);
            c[j,3]:=trunc(inz*cos1[ry]+inx*sin1[ry]);
     end;
     if rz<>0 then for j:=1 to nv do begin
            inx:=c[j,1];iny:=c[j,2];
            c[j,1]:=trunc(inx*cos1[rz]-iny*sin1[rz]);
            c[j,2]:=trunc(inx*sin1[rz]+iny*cos1[rz]);
     end;
end;

procedure proiectie;
var i:integer;
begin
     for i:=1 to nv do begin
         p[i,1]:=320+trunc(z0*c[i,1]/(z0-c[i,3]));
         p[i,2]:=100-trunc(z0*c[i,2]/(z0-c[i,3]));
     end
end;

procedure scalare(sx,sy,sz:real);
var i:integer;
begin
     if sx<>1 then for i:=1 to nv do c[i,1]:=trunc(c[i,1]*sx);
     if sy<>1 then for i:=1 to nv do c[i,2]:=trunc(c[i,2]*sy);
     if sy<>1 then for i:=1 to nv do c[i,3]:=trunc(c[i,3]*sz);
end;
begin
     gd:=detect;
     initgraph(gd,gm,'');
     nv:=8;nm:=12;
     c[1,1]:=50;c[1,2]:=50;c[1,3]:=-30;c[2,1]:=50;c[2,2]:=50;c[2,3]:=60;
     c[3,1]:=150;c[3,2]:=50;c[3,3]:=60;c[4,1]:=150;c[4,2]:=50;c[4,3]:=-30;
     c[5,1]:=50;c[5,2]:=-90;c[5,3]:=-30;c[6,1]:=50;c[6,2]:=-90;c[6,3]:=60;
     c[7,1]:=150;c[7,2]:=-90;c[7,3]:=60;c[8,1]:=150;c[8,2]:=-90;c[8,3]:=-30;
     m[1,1]:=1;m[1,2]:=2;m[2,1]:=1;m[2,2]:=4;m[3,1]:=1;m[3,2]:=5;
     m[4,1]:=2;m[4,2]:=3;m[5,1]:=2;m[5,2]:=6;m[6,1]:=3;m[6,2]:=4;
     m[7,1]:=3;m[7,2]:=7;m[8,1]:=4;m[8,2]:=8;m[9,1]:=5;m[9,2]:=6;
     m[10,1]:=5;m[10,2]:=8;m[11,1]:=6;m[11,2]:=7;m[12,1]:=7;m[12,2]:=8;
     z0:=150;nv:=8;nm:=12;
     scalare(1/2,1/2,1/2);calc_trig;
     for i:=1 to nv do for j:=1 to 3 do ci[i,j]:=c[i,j];
     page:=0;i:=1;
     repeat
         repeat
           rotatie(i,i,i);
           proiectie;
           rest;
           afiseaza;
           i:=i+5;
         until (i>=360);
         i:=1;
     until keypressed;
end.