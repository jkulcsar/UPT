uses crt,graph;
type art=record
     b:array[1..4,1..3]of real;
     end;
const eps=1e-8;
      cale='\tp\bgi';
var s:array[1..20,1..21] of real;
    sol:array[1..20] of real;
    nrpct,i,j,n,k,maxx,maxy:integer;
    x,x1,var1,r,f1,contor,scara:real;
    F:array[1..20,1..3]of real;
    B1,B2:array[1..20,1..3]of real;
    Bi:array[1..20]of art;
    Fp:array[1..20,1..3]of real;
    M:array[1..20,1..20]of real;
    T:array[1..20]of real;
    A:array[1..20,1..3]of real;
    buf:char;
    c:string;
PROCEDURE init;
VAR grdriver,grmode,errcode:integer;
BEGIN
     grDriver :=detect;            {vga;grMode:=vgamed;}
     InitGraph(grDriver,grMode,cale);
     ErrCode := GraphResult;
     if ErrCode = grOk then
         BEGIN
              maxx:=getmaxx;
              maxy:=getmaxy;
         END
     else
       WriteLn('Graphics error:',
               GraphErrorMsg(ErrCode));
END;

procedure axe;
begin
line(round(maxx/2),0,round(maxx/2),maxy);
line(0,round(maxy/2),maxx,round(maxy/2));
outtextxy(round(maxx/2)-20,0,'q');
outtextxy(maxx-20,round(maxy/2)+20,'t');
end;

procedure Gauss;
var i,j,k:byte;
    aux,coef,suma:real;
begin
     for i:=1 to n do
     begin
          j:=i;
          while (j<=n) and (abs(s[j,i])<eps) do
                inc(j);
          if abs(s[j,i])<eps then
          begin
               writeln('Sistem incompatibil nedeterminat.');
               writeln('Esti tare destept...');
               halt;
          end;
          if j<>i then
             for k:=1 to n+1 do
             begin
                  aux:=s[j,k];
                  s[j,k]:=s[i,k];
                  s[i,k]:=aux;
             end;
          for j:=n+1 downto i do
              s[i,j]:=s[i,j]/s[i,i];
          for j:=i+1 to n do
          begin
               coef:=s[j,i];
               for k:=i to n+1 do
                   s[j,k]:=s[j,k]-coef*s[i,k];
          end;
     end;
     for i:=n downto 1 do
     begin
          suma:=s[i,n+1];
          for j:=n downto i+1 do
              suma:=suma-s[i,j]*sol[j];
          sol[i]:=suma/s[i,i];
     end;
end;

Begin
     clrscr;
     Write('CŒte puncte se dau ? : ');readln(nrpct);
{
     nrpct:=6;

     F[1,1]:=0;
     F[1,2]:=0;
     F[1,3]:=0;

     F[2,1]:=1;
     F[2,2]:=1;
     F[2,3]:=1;

     F[3,1]:=2;
     F[3,2]:=2.5;
     F[3,3]:=2;

     F[4,1]:=4;
     F[4,2]:=3.5;
     F[4,3]:=2.5;

     F[5,1]:=5;
     F[5,2]:=2;
     F[5,3]:=1.75;

     F[6,1]:=6;
     F[6,2]:=0;
     F[6,3]:=0;

}
     n:=nrpct-2;
     For i:=1 to nrpct do
         begin
         write('F',i:2,'1=');readln(F[i,1]);
         write('F',i:2,'2=');readln(F[i,2]);
         write('F',i:2,'3=');readln(F[i,3]);
         end;

     for i:=2 to nrpct do
         T[i]:=sqrt(sqr(F[i,1]-F[i-1,1])+sqr(F[i,2]-F[i-1,2])+sqr(F[i,3]-F[i-1,3]));
     for i:=2 to nrpct-1 do
         for j:=2 to nrpct-1 do
              M[i,j]:=0;
     M[2,2]:=2/T[3]+3/T[2];
     M[2,3]:=1/T[3];
     M[nrpct-1,nrpct-1]:=2/T[nrpct-1]+3/T[nrpct];
     M[nrpct-1,nrpct-2]:=1/T[nrpct-1];
     for i:=3 to nrpct-2 do
         begin
              M[i,i-1]:=T[i+1];
              M[i,i+1]:=T[i];
              M[i,i]:=2*(T[i]+T[i+1]);
         end;
     A[2,1]:=3*(F[3,1]-F[2,1])/sqr(T[3])+6*(F[2,1]-F[1,1])/sqr(T[2]);
     A[2,2]:=3*(F[3,2]-F[2,2])/sqr(T[3])+6*(F[2,2]-F[1,2])/sqr(T[2]);
     A[2,3]:=3*(F[3,3]-F[2,3])/sqr(T[3])+6*(F[2,3]-F[1,3])/sqr(T[2]);
     A[nrpct-1,1]:=3*(F[nrpct-1,1]-F[nrpct-2,1])/sqr(T[nrpct-1])+
                   6*(F[nrpct,1]-F[nrpct-1,1])/sqr(T[nrpct]);
     A[nrpct-1,2]:=3*(F[nrpct-1,2]-F[nrpct-2,2])/sqr(T[nrpct-1])+
                   6*(F[nrpct,2]-F[nrpct-1,2])/sqr(T[nrpct]);
     A[nrpct-1,3]:=3*(F[nrpct-1,3]-F[nrpct-2,3])/sqr(T[nrpct-1])+
                   6*(F[nrpct,3]-F[nrpct-1,3])/sqr(T[nrpct]);
     for i:=3 to nrpct-2 do
         begin
              A[i,1]:=3*(sqr(T[i])*(F[i+1,1]-F[i,1])+sqr(T[i+1])
              *(F[i,1]-F[i-1,1]))/(T[i]*T[i+1]);
              A[i,2]:=3*(sqr(T[i])*(F[i+1,2]-F[i,2])+sqr(T[i+1])
              *(F[i,2]-F[i-1,2]))/(T[i]*T[i+1]);
              A[i,3]:=3*(sqr(T[i])*(F[i+1,3]-F[i,3])+sqr(T[i+1])
              *(F[i,3]-F[i-1,3]))/(T[i]*T[i+1]);
         end;
     For k:=1 to 3 do
         Begin
              for i:=2 to nrpct-1 do
                    for j:=2 to nrpct-1 do
                        s[i-1,j-1]:=M[i,j];
              for i:=2 to nrpct-1 do
                  s[i-1,nrpct-1]:=A[i,k];
              gauss;
              for i:=2 to nrpct-1 do
                  Fp[i,k]:=sol[i-1];
         End;
     {B[] pt primul segment}
      for i:=1 to 3 do
          Begin
             B1[1,i]:=F[1,i];
             B1[2,i]:=0;
             B1[3,i]:=0;
             B1[4,i]:=4*(F[2,i]-F[1,i])/(sqr(T[2])*T[2])-Fp[2,i]/sqr(T[2]);
             B1[5,i]:=3*(F[1,i]-F[2,i])/(sqr(T[2]*T[2]))+Fp[2,i]/(Sqr(T[2])*T[2]);
          End;
      writeln('Polinomul de interpolare pt primul segment');
      for j:=1 to 3 do
          begin
          writeln('Pt CUPLA ',j:1);
          writeln('F1',j,'(t)=',B1[1,j]:10:2,'+',B1[2,j]:10:2,'*t+',
          B1[3,j]:10:2,'*t^2+',B1[4,j]:10:2,'*t^3+',B1[5,j]:10:2,'*t^4');
          writeln('Apasa Enter');
          readln;
          end;

      for k:=2 to nrpct-2 do
          for i:=1 to 3 do
              Begin
                   Bi[k].b[1,i]:=F[k,i];
                   Bi[k].b[2,i]:=Fp[k,i];
                   Bi[k].b[3,i]:=(1/T[k+1])*(3*(F[k+1,i]-F[k,i])/T[k+1]-
                   2*Fp[k,i]-Fp[k+1,i]);
                   Bi[k].b[4,i]:=(1/sqr(T[k+1]))*(2*(F[k,i]-F[k+1,i])/T[k+1]+
                   Fp[k,i]+Fp[k+1,i]);
              End;
      writeln('Polinoamele pentru segmentele intermediare sint :');
      for k:=2 to nrpct-2 do
          Begin
            writeln('Pt Segmentul ',k);
            for j:=1 to 3 do
                writeln('F',k,j,'(t)=',Bi[k].b[1,j]:10:2,'+',Bi[k].b[2,j]:10:2,'*t+',
                Bi[k].b[3,j]:10:2,'*t^2+',Bi[k].b[4,j]:10:2,'*t^3');
            writeln;
            writeln('Apasa Enter !');
            readln;
          End;
      for i:=1 to 3 do
          Begin
             B2[1,i]:=F[nrpct-1,i];
             B2[2,i]:=Fp[nrpct-1,i];
             B2[3,i]:=(6*F[nrpct,i]-6*F[nrpct-1,i]-3*Fp[nrpct-1,i]*
                      T[nrpct])/sqr(T[nrpct]);
             B2[4,i]:=(-8*F[nrpct,i]+8*F[nrpct-1,i]+3*Fp[nrpct-1,i]*
                      T[nrpct])/(sqr(T[nrpct])*T[nrpct]);
             B2[5,i]:=(3*F[nrpct,i]-3*F[nrpct-1,i]-Fp[nrpct-1,i]*
                      T[nrpct])/(sqr(T[nrpct])*sqr(T[nrpct]));
          End;
      writeln('Polinomul de interpolare pt ultimul segment');

      for j:=1 to 3 do
          begin
          writeln('Pt CUPLA ',j:1);
          writeln('F',nrpct-1,j,'(t)=',B2[1,j]:10:2,'+',B2[2,j]:10:2,'*t+',
          B2[3,j]:10:2,'*t^2+',B2[4,j]:10:2,'*t^3+',B2[5,j]:10:2,'*t^4')
          end;
      writeln('Apasa Enter !');
      readln;
      scara:=10;
      init;
      for j:=1 to 3 do
          begin
               repeat
                     axe;
                     str(j,c);
                     outtextxy(0,0,'Cupla '+c);
                     outtextxy(0,10,'"+","-" :ZOOM');
                     {Pt primul segment}
                     contor:=0;
                     while contor<=t[2] do
                           begin
                                f1:=b1[1,j]+b1[2,j]*contor+b1[3,j]*sqr(contor)+
                                    b1[4,j]*sqr(contor)*contor+
                                    b1[5,j]*sqr(contor)*sqr(contor);
                                putpixel(round(contor*scara+maxx/2),round((-1)*F1*scara+maxy/2),white);
                                x:=round(contor*scara+maxx/2);
                                if contor=0 then
                                   outtextxy(round(x),round((-1)*F1*scara+maxy/2),'P1');
                                contor:=contor+0.1;
                           end;
                     {Pt segmentele intermediare}
                     for k:=2 to nrpct-2 do
                         begin
                              var1:=x;
                              contor:=0;
                              while contor<=t[k+1] do
                                    begin
                                         f1:=Bi[k].b[1,j]+Bi[k].b[2,j]*contor+Bi[k].b[3,j]*sqr(contor)+
                                             Bi[k].b[4,j]*sqr(contor)*contor;
                                         putpixel(round(var1+contor*scara),round((-1)*F1*scara+maxy/2),white);
                                         x1:=round(var1+contor*scara);
                                         if contor=0 then
                                            begin
                                               str(k,c);
                                               outtextxy(round(x1),round((-1)*F1*scara+maxy/2),'P'+c);
                                            end;
                                         contor:=contor+0.1;
                                    end;
                              x:=x1;
                         end;
                     {Pt ultimul segment segment}
                      contor:=0;
                     while contor<=t[nrpct] do
                           begin
                                f1:=b2[1,j]+b1[2,j]*contor+b2[3,j]*sqr(contor)+
                                    b2[4,j]*sqr(contor)*contor+
                                    b2[5,j]*sqr(contor)*sqr(contor);
                                putpixel(round(x+contor*scara),round((-1)*F1*scara+maxy/2),white);
                                if contor=0 then
                                   begin
                                        str(nrpct-1,c);
                                        outtextxy(round(x+contor*scara),round((-1)*F1*scara+maxy/2),'P'+c);
                                   end;
                                contor:=contor+0.1;
                           end;
                     str(nrpct,c);
                     outtextxy(round(x+contor*scara),round((-1)*F1*scara+maxy/2),'P'+c);
                     buf:=readkey;
                     if buf=chr(43) then
                        scara:=scara+5;
                     if (buf=chr(45)) and (scara>=5) then
                        scara:=scara-5;
                     cleardevice;
               until buf=chr(13);
          end;
      closegraph;
End.