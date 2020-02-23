  program PunctFix ;
  uses Crt ,Printer;
  const R = 200           ;
        U = 10            ;

  var   i                             : real ;
        Va                            : real ;
        Aa                            : real ;
        Omega                         : real ;
        Omega1                        : real ;
        Epsilon                       : real ;
        Epsilon1                      : real ;
        x1,y1,z1                      : real ;
        cc                            : byte ;
        A,B,C, Alfa                   : real ;

  procedure CalcOmegaIn_SRA( var t:real );
  var OmegaX,OmegaY,OmegaZ : real ;
   begin
     OmegaX := b*sin(c)*sin(a*t) ;
     OmegaY := b*sin(c)*cos(a*t) ;
     OmegaZ := b*cos(c)+a        ;
     Omega  := sqrt( OmegaX*OmegaX+OmegaY*OmegaY+OmegaZ*OmegaZ );
   end;

  procedure CalcOmegaIn_SRF( var t:real );
  var OmegaX1,OmegaY1,OmegaZ1 : real ;
   begin
     OmegaX1 :=  a*sin(c)*sin(b*t)  ;
     OmegaY1 := -a*sin(c)*cos(b*t)  ;
     OmegaZ1 :=  a*cos(c)+b         ;
     Omega1  :=  sqrt( OmegaX1*OmegaX1+OmegaY1*OmegaY1+OmegaZ1*OmegaZ1 );
   end;

  procedure CalcEpsilonIn_SRA( var t:real );
  var EpsilonX,EpsilonY,EpsilonZ : real ;
   begin
     EpsilonX :=  a*b*sin(c)*cos(a*t)  ;
     EpsilonY := -a*b*sin(c)*sin(a*t)  ;
     EpsilonZ :=  0                    ;
     Epsilon  :=  sqrt( EpsilonX*EpsilonX+EpsilonY*EpsilonY+
                      EpsilonZ*EpsilonZ );
   end;

  procedure CalcEpsilonIn_SRF( var t:real );
  var  EpsilonX1,EpsilonY1,EpsilonZ1 : real ;
   begin
     EpsilonX1 :=  a*b*sin(c)*cos(b*t)  ;
     EpsilonY1 :=  a*b*sin(c)*sin(b*t)  ;
     EpsilonZ1 :=  0                    ;
     Epsilon1  :=  sqrt( EpsilonX1*EpsilonX1+EpsilonY1*EpsilonY1+
                 +EpsilonZ1*EpsilonZ1 );
   end;

  procedure CalcCoordIn_SRF( var t:real );
  begin
    x1        :=  ( R/sin( alfa )-u*t)*  sin(c)*sin(b*t);
    y1        :=  ( R/sin( alfa )-u*t)*(-cos(b*t)*sin(c));
    z1        :=  ( R/sin( alfa )-u*t)* cos(c);
  end;

  procedure CalcVitezaAbsoluta( var t:real );
  var Vax1,Vay1,Vaz1 : real;
    begin
    Vax1 := -u*sin(c)*sin(b*t)-z1*a*sin(c)*cos(b*t)-y1*(a*cos(c)+b)      ;
    Vay1 :=  u*cos(b*t)*sin(c)+x1*(a*cos(c)+b)-z1*a*sin(c)*sin(b*t)      ;
    Vaz1 :=  u*cos(c)+x1*a*sin(c)*cos(b*t)+y1*a*sin(c)*sin(b*t) ;
    Va   :=  sqrt( Vax1*Vax1+Vay1*Vay1+Vaz1*Vaz1 )     ;
 end;

procedure CalcAccAbsoluta( var t:real );
var Aax1,Aay1,Aaz1 : real ;
 begin
   Aax1 :=  z1*a*b*sin(c)*sin(b*t)-2*z1*a*sin(c)*cos(b*t)-
            -2*y1*(a*cos(c)+b);
   Aay1 := -z1*a*b*sin(c)*cos(b*t)+2*x1*(a*cos(c)+b)-
           -2*z1*a*sin(c)*sin(b*t);
   Aaz1 :=  y1*a*b*sin(c)*cos(b*t)-x1*a*b*sin(c)*sin(b*t)+
              +2*x1*a*sin(c)*cos(b*t)+2*y1*a*sin(c)*sin(b*t);
      Aa   :=  sqrt( Aax1*Aax1+Aay1*Aay1+Aaz1*Aaz1 );
  end;

  begin  { main }
    ClrScr;
    write(' Introduceti A . . . . .'); readln(a);
    write(' Introduceti B . . . . .'); readln(b);
    write(' Introduceti C . . . . .'); readln(c);
    write(' Introduceti Alfa  . . .'); readln(alfa);
    a := a*pi/180; b:=b*pi/180; c := c*pi/180;
    alfa := alfa*pi/180;
    i := 0;
    writeln(lst,' Valorile de mai jos sint exprimate in centimetri . . . ');
    writeln(lst);
    writeln(lst,' Omg','     Omg1','    Eps  ',' Eps1   ','  x1  ',
                  '     y1  ','       z1 ','       Va ','     Aa '  );
    for cc:=1 to 75 do write(lst,'=');
    writeln(lst);
    repeat
             CalcOmegaIn_SRA(i);
             CalcOmegaIn_SRF(i);
           CalcEpsilonIn_SRA(i);
           CalcEpsilonIn_SRF(i);
             CalcCoordIn_SRF(i);
          CalcVitezaAbsoluta(i);
          CalcAccAbsoluta   (i);
        writeln(lst,Omega:4:2,' | ',Omega1:4:2,' | ',Epsilon:4:2,' | ',
                 Epsilon1:4:2,' | ',x1:7:3,' | ',y1:8:3,' | ',
                 z1:6:3,' | ',Va:5:3,' | ',Aa:6:3);
        i := i+0.1;
     until i>=6;
     readln;
  end.   { main }