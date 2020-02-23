program Radacina ;
uses crt;
const n=100; eps=0.001;
type tipfunctie = function(x:real):real;
var a,x1,x2:real;
         m :byte;
  {$F+}
 function newton(x1:real):real;
  begin
   newton:=0.5*(x1+a/x1);
  end;

 function dedekin(x1:real):real ;
  begin
   dedekin := (x1*x1*x1 + 3*a*x1)/(3*x1*x1 +a);
 end;

 function Rad(a:real; f:tipfunctie): real;
 begin
   m:=0; x1:=1;
  repeat
   x2:=f(x1);
   x1:=x2;    m:=m+1;
  until ( abs(x2-x1)>eps ) or ( m=n );
   Rad := x2;
 end;

 begin {main}
  ClrScr ;
  writeln('intr. a= '); readln(a);
  writeln('Radacina = ', Rad(a,newton):5:5);
  writeln('radacina = ', Rad(a,dedekin):5:5);
  repeat until keypressed ;
 end. {main}

