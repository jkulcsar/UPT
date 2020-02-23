program eval_expresie;
uses crt;
type pnod=^nod;
     nod=record
               at:char;
               sting,drept:pnod;
     end;
     lit='a'..'z';
     func=string[6];

const ls:array[1..6] of func=('sin','cos','tg','arctan','ln','exp');
      ls1:array[1..6] of char=('!','@','#','$','%','&');

var radacina:pnod;
    operanzi:set of lit;
    functii:set of char;
    v_oper:array[lit] of real;
    litere:set of lit;
    s:string;
    ch:char;
    i:integer;

procedure inlocuieste_functii;
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
               end;
           end;
     until not gasit;
end;

procedure getcar;
begin
     ch:=s[i];
     if ch in litere then operanzi:=operanzi+[ch];
     i:=i+1;
end;

procedure expresie(var r:pnod);
var p:pnod;
    procedure termen(var r:pnod);
    var p:pnod;
        procedure factor(var r:pnod);
        var p:pnod;
            procedure functie(var r:pnod);
            begin
                 if ch in functii then begin
                    getcar;
                    new(r);
                    with r^ do begin
                         at:=ch;
                         sting:=p;
                         expresie(drept);
                    end;
                 end;
            end;
        begin  {factor}
             p:=r;
             if ch='(' then begin
                getcar;
                functie(r);
                getcar;
             end
             else begin
                  new(r);
                  with r^ do begin
                       at:=ch;
                       sting:=nil;
                       drept:=nil;
                  end;
                  getcar;
             end;
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
                    sting:=p;
               end;
               p:=r;
         end;
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
                     sting:=p;
                end;
                p:=r;
          end;
    end;


procedure valori;
var ch:char;
begin
     for ch:='a' to 'z' do if ch in operanzi then begin
            write(ch,'=');
            readln(v_oper[ch]);
         end;
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
               '/':eval:=temp1/temp2;
          end;
     end;
     dispose(r);
end;

begin   {main}
        operanzi:=[];
        functii:=['!','@','#','$','%','&'];
        litere:=['a'..'z'];
        writeln;
        write('introduceti expresia ');
        readln(s);
        i:=1;
        inlocuieste_functii;
        writeln(s);
        expresie(radacina);
        valori;
        write('valoarea expresiei = ',eval(radacina));
        ch:=readkey;
end.