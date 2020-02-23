  program Grafica3D;
  uses    Graph,Crt;
  type    Tablou        = array[1..8] of integer;
  var     X,Y,Z         : Tablou  ;
          GraphDriver   : integer ;
          GraphMode     : integer ;
          x0,y0         : word    ;
          Fi,Teta,Psi,L : byte    ;
          ch            : char    ;

  procedure Init;
  begin
      GraphDriver := Detect;
      InitGraph( GraphDriver,GraphMode,'d:\');
      x0 := GetMaxX div 2;
      y0 := GetMaxY div 2;
      SetBkColor(0);
      SetColor(14);
  end;

  procedure CalcCoordInit( var lat:byte );
  var q     : byte   ;
  begin
      q    :=  trunc(lat/2);
    { Coordonatele X }
      x[1] :=  q;   x[2] :=  q;   x[3] := -q;   x[4] := -q;
      x[5] :=  q;   x[6] :=  q;   x[7] := -q;   x[8] := -q;
    { Coordonatele Y }
      y[1] := -q;   y[2] :=  q;   y[3] :=  q;   y[4] := -q;
      y[5] := -q;   y[6] :=  q;   y[7] :=  q;   y[8] := -q;
    { Coordonatele Z }
      z[1] := -q;   z[2] := -q;   z[3] := -q;   z[4] := -q;
      z[5] :=  q;   z[6] :=  q;   z[7] :=  q;   z[8] :=  q;
  end;  { CalcCoord }

  procedure TraseazaCub( X,Y,Z : tablou );
   var i:byte;
   begin
        PutPixel( x[4]-x[1]+x0,y[4]-y[1]+y0,14 );
        PutPixel( x[5]-x[1]+x0,y[5]-y[1]+y0,14 );
        PutPixel( x[2]-x[1]+x0,y[2]-y[1]+y0,14 );
        PutPixel( x[7]-x[3]+x0,y[7]-y[3]+y0,14 );
        PutPixel( x[4]-x[3]+x0,y[4]-y[3]+y0,14 );
        PutPixel( x[2]-x[3]+x0,y[2]-y[3]+y0,14 );
        PutPixel( x[7]-x[6]+x0,y[7]-y[6]+y0,14 );
        PutPixel( x[5]-x[6]+x0,y[5]-y[6]+y0,14 );
        PutPixel( x[2]-x[6]+x0,y[2]-y[6]+y0,14 );
        PutPixel( x[7]-x[8]+x0,y[7]-y[8]+y0,14 );
        PutPixel( x[5]-x[8]+x0,y[4]-y[8]+y0,14 );
        PutPixel( x[4]-x[8]+x0,y[4]-y[8]+y0,14 );
   end;


  procedure CalcCoordNoi( var a,b,c:byte );
  var f,i   : byte;
      xt,yt : real;
  begin
     f := 0;
     for i:=1 to 8 do begin
         xt   := x[i];
         x[i] := trunc(x[i]*cos(pi*a/180) + y[i]*sin(pi*a/180)) ;
         y[i] := trunc(-xt*sin(pi*a/180)  + y[i]*cos(pi*a/180))
     end; { for }
     if f=1 then TraseazaCub(X,Y,Z);
     for i:=1 to 8 do begin
         yt   := y[i];
         y[i] := trunc(y[i]*cos(pi*b/180)+z[i]*sin(pi*b/180)) ;
         z[i] := trunc(-yt*sin(pi*b/180)+z[i]*cos(pi*b/180))
     end; { for }
     for i:=1 to 8 do begin
         xt   := x[i];
         x[i] := trunc(x[i]*cos(pi*c/180)+y[i]*sin(pi*c/180));
         y[i] := trunc(-xt*sin(pi*c/180)+y[i]*cos(pi*c/180))
     end; { for }
  end; { CalcCoordNoi }

  begin  { main }
     ClrScr;
     write('Introduceti latura cubului                     ...  ');
     readln(L);
     write('Introduceti unghiurile de rotire Fi, Teta, Psi ...  ');
     readln(fi,teta,psi);
     Init;
     CalcCoordInit(L);
     CalcCoordNoi(fi,teta,psi);
     ClearDevice;
     TraseazaCub(x,y,z);
     ch := ReadKey;
  end.





