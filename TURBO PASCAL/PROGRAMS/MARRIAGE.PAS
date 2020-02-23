program relatia_stabila;
const n=8;
type baiat=1..n;
     fata=1..n;
     ordin=1..n;
var b:baiat;
    f:fata;
    o:ordin;
    prefb:array[baiat,ordin] of fata;
    preff:array[fata,ordin] of baiat;
    ofb:array[baiat,fata] of ordin;
    obf:array[fata,baiat] of ordin;
    x:array[baiat] of fata;
    y:array[fata] of baiat;
    neales:array[fata] of boolean;

procedure tipareste;
var b1:baiat;
    ob,of1:integer;
begin
     ob:=0;of1:=0;
     for b1:=1 to n do begin
         write(x[b1]);
         ob:=ob+ofb[b1,x[b1]];
         of1:=of1+obf[x[b1],b1];
     end;
     writeln(ob,of1);
end; {tipareste}

procedure incearca(b:baiat);
var o:ordin;
    f:fata;
    function stabil:boolean;
    var bp:baiat;
        fp:fata;
        i,lim:ordin;
        s:boolean;
    begin
         s:=true;
         i:=1;
         while (i<o) and s do begin
               fp:=prefb[b,i];
               i:=i+1;
               if not neales[fp] then s:=obf[fp,b]>obf[fp,y[fp]]
         end;
         i:=1;
         lim:=obf[f,b];
         while (i<lim) and s do begin
               bp:=preff[f,i];
               i:=i+1;
               if bp<b then s:=ofb[bp,f]>ofb[bp,x[bp]];
         end;
         stabil:=s;
    end; {stabil}
    begin {incearca}
          for o:=1 to n do begin
              f:=prefb[b,o];
              if neales[f] then if stabil then begin
                 x[b]:=f;
                 y[f]:=b;
                 neales[f]:=false;
                 if b<n then incearca(succ(b)) else
                 tipareste;
                 neales[f]:=true;
              end
          end
    end; {incearca}

begin {main}
      for b:=1 to n do
          for o:=1 to n do begin
              read(prefb[b,o]);
              ofb[b,prefb[b,o]]:=o;
          end;
      for f:=1 to n do
          for o:=1 to n do begin
              read(preff[f,o]);
              obf[f,preff[f,o]]:=o;
          end;
      for f:=1 to n do neales[f]:=true;
      incearca(1);
end.

