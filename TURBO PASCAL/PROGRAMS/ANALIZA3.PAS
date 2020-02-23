program eval_expresie;
uses crt,graph;
type pnod=^nod;
     nod=record
               at:char;
               sting,drept:pnod
     end;
     lit='a'..'z';
     func=string[6];

const ls:array[1..6] of func=('sin','cos','tg','arctan','ln','exp');
      ls1:array[1..6] of char=('!','@','#','$','%','&');
      functii=['!','@','#','$','%','&'];
      litere=['a'..'z'];

var radacina:pnod;
    operanzi:set of lit;
    v_oper:array[lit] of real;
    ch:char;
    s,s1,s2:string;
    i,j,gd,gm,index:integer;
    rezultat,rezultat_final,x,pozy:real;
    tab_val:array[1..640] of real;

procedure limitare;
var i:integer;
    lim,max:real;
begin
     max:=tab_val[1];
     for i:=2 to 640 do
         if max<tab_val[i] then max:=tab_val[i];
     lim:=100/max;
     for i:=1 to 640 do tab_val[i]:=tab_val[i]*lim;
end;


procedure inlocuieste_expresie(inlocuitor:string);
var poz:integer;
begin
for ch:='a' to 'z' do if ch in operanzi then else begin
    operanzi:=operanzi+[ch];
    case inlocuitor[1] of
         '!':v_oper[ch]:=sin(rezultat);
         '@':v_oper[ch]:=cos(rezultat);
         '#':v_oper[ch]:=sin(rezultat)/cos(rezultat);
         '$':v_oper[ch]:=arctan(rezultat);
         '%':v_oper[ch]:=ln(rezultat);
         '&':v_oper[ch]:=exp(rezultat)
    end;
    poz:=pos(inlocuitor,s);
    delete(s,poz,length(inlocuitor));
    insert(ch,s,poz);
    ch:='z';
    end
end;


procedure prelucreaza_expresie;
var i,poz:integer;
    gasit:boolean;
begin
     repeat
     gasit:=false;
     for i:=1 to 6 do begin
             poz:=pos(ls[i],s);
             if poz<>0 then begin
                delete(s,poz,length(ls[i]));
                insert(ls1[i],s,poz);
                gasit:=true;
             end
     end;
     until not gasit;
end;

procedure getcar;
begin
     ch:=s[index];
     if ch in litere then operanzi:=operanzi+[ch];
     index:=index+1;
     s1:=s1+ch
end;

procedure expresie(var r:pnod);
var p:pnod;
    procedure termen(var r:pnod);
    var p:pnod;
        procedure factor(var r:pnod);
        begin
             if ch='(' then begin
                getcar;
                expresie(r);
             {   getcar;}
             end
             else begin
                  new(r);
                  with r^ do begin
                       at:=ch;
                       sting:=nil;
                       drept:=nil
                  end;
                  getcar
             end
        end;
    begin
         factor(r);
         p:=r;
         while ch in ['*','/'] do begin
               new(r);
               with r^ do begin
                    at:=ch;
                    getcar;
                    factor(drept);
                    sting:=p
               end;
               p:=r
         end
    end;
    begin {expresie}
          termen(r);
          p:=r;
          while ch in ['+','-'] do begin
                new(r);
                with r^ do begin
                     at:=ch;
                     getcar;
                     termen(drept);
                     sting:=p
                end;
                p:=r;
          end
    end;

procedure valori;
var ch:char;
    i:integer;
begin
     for i:=1 to length(s) do if s[i] in litere then
         operanzi:=operanzi+[s[i]];
     for ch:='a' to 'z' do if ch in operanzi then
         begin
              write(ch,'=');
              readln(v_oper[ch])
         end
end;

function eval(r:pnod):real;
var temp1,temp2:real;
begin
     with r^ do if at in litere then eval:=v_oper[at] else begin
          temp1:=eval(sting);
          temp2:=eval(drept);
          case at of
               '+':eval:=temp1+temp2;
               '-':eval:=temp1-temp2;
               '*':eval:=temp1*temp2;
               '/':eval:=temp1/temp2
          end
     end;
     dispose(r)
end;

procedure calculeaza;
begin
         operanzi:=[];
         s:=s2;
         index:=1;
         repeat
             s1:='';
             if ch in functii then begin
                s1:=s1+ch;
                getcar;
                expresie(radacina);
                rezultat:=eval(radacina);
                inlocuieste_expresie(s1);
                index:=index-length(s1);
             end else getcar;
         until index>=length(s);
         index:=1;
         getcar;
         expresie(radacina);
         rezultat_final:=eval(radacina);
end;

begin   {main}
         operanzi:=[];
         valori;
         writeln;
         write('introduceti expresia ');
         readln(s);
         prelucreaza_expresie;
         s2:=s;
         writeln(s);
         valori;
         gd:=3;gm:=0;x:=0;
         initgraph(gd,gm,'');
         repeat
         gotoxy(0,100);
         for j:=1 to 640 do begin
             x:=x+0.05;
             v_oper['x']:=x;
             calculeaza;
             lineto(j,100+trunc(rezultat_final*30));
         end;
         ch:=readkey;
         cleardevice;
         until ch=#27;
         ch:=readkey;
end.
