 unit  MyGraph;
 interface
 uses  Crt,Graph;
 const Nmax = 30; NMmax = 10;

 type       MatriceData = array[1..4,1..4] of real ;
            MatriceBaza = array[1..Nmax,1..Nmax] of real;
            MatriceIntr = array[1..Nmax,1..Nmax] of integer;
             VectorBaza = array[1..Nmax] of real;
             VectorIntr = array[1..Nmax] of real;
                     ML = 1..5;
                     MC = 1..5;
           MsgMeniuType = array[1..2,ML,MC] of string[20];

 var           MsgMeniu : MsgMeniuType;
                 x0, y0 : word;
             MaxX, MaxY : word;
             DM         : byte;
         Linii, Coloane : byte;
         ValCol, ValLin : byte;
          Sinus,Cosinus : array[0..360] of real;

 procedure CalcCoordBazaSuprafataBezier( var xxQb, yyQb, zzQb : MatriceData;
                                         var xxB,  yyB,  zzB  : MatriceBaza;
                                             p : real );
 procedure CalcCoordBazaSuprafataOarecare( var xxSO, yySO, zzSO : MatriceBaza;
                                               p : real );
 procedure CalcCoordBazaCurbaHermite( xAh, yAh, zAh, lAh, mAh, nAh : real;
                                      xBh, yBh, zBh, lBh, mBh, nBh : real;
                                 var  xxH, yyH, zzH : MatriceBaza; pas:real );
 procedure Proiecteaza( var xx,yy,zz : MatriceBaza;
                        var qq,ww : MatriceIntr;
                            mm,nn  :  byte );
 procedure Scaleaza(    var xxSc,yySc,zzSc : MatriceBaza;
                                   mm,  nn : byte;
                                     Scale : real );
 procedure ProiecteazaCurba( var xP1, yP1, zP1 : VectorBaza;
                             var qqH, wwH : VectorIntr;
                                 nn : byte );
 procedure CalcVectorSinCos;
 procedure InitMeniu;

 procedure SetWorkPort;
 procedure ExitWorkPort;
 procedure ClearWorkPort;

 procedure SetDesign;
 procedure Message( Msg : string );
 procedure MeniuLinie(   LXmin,LYmin,LXmax,LYmax : word;
                         Latime                  : byte;
                         var       Col           : byte      );
 procedure MeniuColoana( CXmin,CYmin,CXmax,CYmax : word;
                         Lungime                 : byte;
                         var       Lin           : byte       );

 procedure Roteste( var xxB, yyB, zzB : MatriceBaza;
                              mm,  nn : byte;
                          a,   b,   c : word         );
 procedure SalveazaCoordBaza( var xxxB,yyyB,zzzB,xxxS,yyyS,zzzS : MatriceBaza;
                                    mm,nn  :  byte );
 procedure SalveazaCoordRotite( var    xxR, yyR, zzR  : MatriceBaza;
                                var    xxRS,yyRS,zzRS : MatriceBaza;
                                              mm,  nn : byte );
 procedure RestaureazaCoordRotite( var xxRS,yyRS,zzRS : MatriceBaza;
                                   var xxR, yyR, zzR  : MatriceBaza;
                                             mm,   nn : byte );
 procedure RestaureazaCoordBaza( var xxxS,yyyS,zzzS,xxxB,yyyB,zzzB : MatriceBaza;
                                       mm,  nn  :  byte  );
 procedure Init;
 procedure Traseaza( var qqq,www : MatriceIntr;
                          mm, nn : byte );
 procedure TraseazaCurba( var qqqH,wwwH : MatriceIntr;
                               mm, nn : byte );


 implementation

 procedure CalcCoordBazaSuprafataBezier( var xxQb,yyQb,zzQb : MatriceData;
                                         var xxB, yyB, zzB  : MatriceBaza;
                                             p : real );
 var j,k : byte;
       c : byte;  { Contorul marimii }
     S1,S2,S3,S4 : real;
     SX1,SX2,SX3,SX4, SY1,SY2,SY3,SY4, SZ1,SZ2,SZ3,SZ4 : real;
     ps, pt : real;
 begin
   ps := 0;
   j  := 1;
   c  := 0;
   repeat
      S1 := -ps*ps*ps + 3*ps*ps - 3*ps + 1;
      S2 := 3*ps*ps*ps - 6*ps*ps + 3*ps*ps;
      S3 := -3*ps*ps*ps + 3*ps*ps;
      S4 := ps*ps*ps;

     SX1 := S1*xxQb[1,1]+S2*xxQb[2,1]+S3*xxQb[3,1]+S4*xxQb[4,1];
     SX2 := S1*xxQb[1,2]+S2*xxQb[2,2]+S3*xxQb[3,2]+S4*xxQb[4,2];
     SX3 := S1*xxQb[1,3]+S2*xxQb[2,3]+S3*xxQb[3,3]+S4*xxQb[4,3];
     SX4 := S1*xxQb[1,4]+S2*xxQb[2,4]+S3*xxQb[3,4]+S4*xxQb[4,4];

     SY1 := S1*yyQb[1,1]+S2*yyQb[2,1]+S3*yyQb[3,1]+S4*yyQb[4,1];
     SY2 := S1*yyQb[1,2]+S2*yyQb[2,2]+S3*yyQb[3,2]+S4*yyQb[4,2];
     SY3 := S1*yyQb[1,3]+S2*yyQb[2,3]+S3*yyQb[3,3]+S4*yyQb[4,3];
     SY4 := S1*yyQb[1,4]+S2*yyQb[2,4]+S3*yyQb[3,4]+S4*yyQb[4,4];

     SZ1 := S1*zzQb[1,1]+S2*zzQb[2,1]+S3*zzQb[3,1]+S4*zzQb[4,1];
     SZ2 := S1*zzQb[1,2]+S2*zzQb[2,2]+S3*zzQb[3,2]+S4*zzQb[4,2];
     SZ3 := S1*zzQb[1,3]+S2*zzQb[2,3]+S3*zzQb[3,3]+S4*zzQb[4,3];
     SZ4 := S1*zzQb[1,4]+S2*zzQb[2,4]+S3*zzQb[3,4]+S4*zzQb[4,4];

      pt := 0;
      k  := 1;
      repeat

        xxB[j,k] := (-SX1+3*SX2-3*SX3)*pt*pt*pt +
                  (3*SX1-6*SX2+3*SX3)*pt*pt   +
                  (-3*SX1+3*SX2)*pt           +  SX1 ;
        yyB[j,k] := (-SY1+3*SY2-3*SY3)*pt*pt*pt +
                  (3*SY1-6*SY2+3*SY3)*pt*pt   +
                  (-3*SY1+3*SY2)*pt           +  SY1 ;
        zzB[j,k] := (-SZ1+3*SZ2-3*SZ3)*pt*pt*pt +
                  (3*SZ1-6*SZ2+3*SZ3)*pt*pt   +
                  (-3*SZ1+3*SZ2)*pt           +  SZ1 ;

        k := k + 1;
       pt := pt+ p;
     until   pt >= (1-p);
     j  := j + 1;
     c  := c + 1;
     ps := ps+ p;
   until ps >= (1-p);
   Linii := c;
   Coloane := c;     { Se stabileste marimea struct. de date }
 end; { CalcCoordBazaSuprafataBezier }

  procedure CalcCoordBazaSuprafataOarecare( var xxSO, yySO, zzSO : MatriceBaza;
                                                p : real );
  var    i,j               : byte;
         ScalX,ScalY,ScalZ : byte;
         PasX, PasY        : real;
         Xmin, Xmax        : real;
         Ymin, Ymax        : real;
      XDivision, Ydivision : byte;
       XRange, YRange      : real;


  function  Z( x,y:real ):real;
  begin
    Z := sin( x*x+y*y );
  end;

  begin
    ScalX:=60; ScalY:=60;ScalZ:=60;
    Xmin := -1.5; Xmax := 1.5;
    Ymin := -1.5; Ymax := 1.5;
    XDivision := 20;
    YDivision := 20;
    XRange    := Xmax-Xmin;
    YRange    := Ymax-Ymin;
   for i := 1 to XDivision do
       for j := 1 to YDivision do
           begin
             xxSO[i,j] :=  ( Xmin + i*XRange/Xdivision )*ScalX;
             yySO[i,j] :=  ( Ymin + j*YRange/YDivision )*ScalY;
             zzSO[i,j] := Z( Xmin + i*XRange/Xdivision,
                             Ymin + j*YRange/YDivision  )*ScalZ;
          end; { for  j }
   Linii := XDivision;
   Coloane := YDivision;
 end; { procedure }



  procedure CalcCoordBazaCurbaHermite( xAh, yAh, zAh, lAh, mAh, nAh : real;
                                       xBh, yBh, zBh, lBh, mBh, nBh : real;
                                   var xxH, yyH, zzH  : MatriceBaza;
                                       pas   : real );
  var j : byte;
      p : real;
      c : byte;
  begin
      j := 1;
      p := 0;
      c := 0;
      repeat
        xxH[1,j] := ( 2*xAh-2*xBh+lAh+lBh )*p*p*p +
                  ( -3*xAh+3*xBh-2*lAh-lBh)*p*p + lAh*p + xAh ;
        yyH[1,j] := ( 2*yAh-2*yBh+mAh+mBh )*p*p*p +
                  ( -3*yAh+3*yBh-2*mAh-mBh)*p*p + mAh*p + yAh ;
        zzH[1,j] := ( 2*zAh-2*zBh+nAh+nBh )*p*p*p +
                  ( -3*zAh+3*zBh-2*nAh-nBh)*p*p + nAh*p + zAh ;
        j := j+1;
        p := p+pas;
        c := c+1;
     until p >= 1;
     Linii := 1;    { o curba fiind numai un vector }
     Coloane := c;
  end; { CalcCoordBazaCurbaHermite }

 procedure Proiecteaza( var xx, yy,zz : MatriceBaza ;
                        var qq, ww    : MatriceIntr;
                            mm, nn    :  byte  );
 var  j,k  : byte;
      z0   : word;
      Fp   : real;        { Factorul Fp apare in formulele de proiectare }
 begin
      z0 := 10000;
   for j := 1 to mm do
       for k := 1 to nn do begin
          Fp    := z0/(z0-zz[j,k]);
         qq[j,k] := trunc( xx[j,k]*Fp );
         ww[j,k] := trunc( yy[j,k]*Fp );
       end; { for }
  end;  { Proiecteaza }

  procedure ProiecteazaCurba( var xP1, yP1, zP1 : VectorBaza;
                              var qqH, wwH      : VectorIntr;
                                   nn  : byte  );
  var z0   : word;
       j   : byte;
      Fp   : real;  { Factorul de proiectare }
  begin
    z0 := 1000;
    for   j := 1 to nn do begin
         Fp := z0/(z0-zP1[j]);
    qqH[j]  := trunc( xP1[j]*Fp );
    wwH[j]  := trunc( yP1[j]*Fp );
    end { for }
  end; { ProiecteazaCurba }

  procedure CalcVectorSinCos;
  var i : word;
      j : real;
  begin
    for i := 0 to 360 do begin
        j := i*pi/180;
        Sinus[i] := sin(j);
        Cosinus[i] := cos(j);
    end { for }
  end;  { begin }

  procedure Roteste( var xxB,yyB,zzB : MatriceBaza;
                              mm, nn : byte;
                           a,  b,  c : word         );
  var Xt,Yt,Zt : real;
      j,k      : byte;
      alfa     : array[1..3,1..3] of real;
      sa,sb,sc : real;
      ca,cb,cc : real;
  begin
            sa :=  Sinus[a]; ca := Cosinus[a];
            sb :=  Sinus[b]; cb := Cosinus[b];
            sc :=  Sinus[c]; cc := Cosinus[c];
     alfa[1,1] :=  ca*cc-sc*sa*cb;
     alfa[1,2] :=  ca*sc+cc*sa*cb;
     alfa[1,3] :=  sa*sb;
     alfa[2,1] := -sa*cc-sc*ca*cb;
     alfa[2,2] := -sa*sc+cc*ca*cb;
     alfa[2,3] :=  sb*ca;
     alfa[3,1] :=  sc*sb;
     alfa[3,2] := -sb*cc;
     alfa[3,3] :=  cb;
     for j := 1 to mm do
         for k := 1 to nn do begin
            Xt := xxB[j,k];
            Yt := yyB[j,k];
            Zt := zzB[j,k];
      xxB[j,k] := xt*alfa[1,1]+yt*alfa[1,2]+zt*alfa[1,3] ;
      yyB[j,k] := xt*alfa[2,1]+yt*alfa[2,2]+zt*alfa[2,3] ;
      zzB[j,k] := xt*alfa[3,1]+yt*alfa[3,2]+zt*alfa[3,3] ;
     end  { for }
  end; { RotesteSuprafata }

  procedure SalveazaCoordBaza( var xxxB,yyyB,zzzB,xxxS,yyyS,zzzS : MatriceBaza;
                                     mm,  nn : byte );
  var j,k : byte;
  begin
    for j := 1 to mm do
        for k := 1 to nn do
        begin
          xxxS[j,k] := xxxB[j,k];
          yyyS[j,k] := yyyB[j,k];
          zzzS[j,k] := zzzB[j,k]
        end
  end;  { SalveazaCoordBazaSuprafata }

  procedure SalveazaCoordRotite( var xxR, yyR, zzR  : MatriceBaza;
                                 var xxRS,yyRS,zzRS : MatriceBaza;
                                            mm,  nn : byte );
  var j,k : byte;
  begin
    for j := 1 to mm do
        for k := 1 to nn do
        begin
          xxRS[j,k] := xxR[j,k];
          yyRS[j,k] := yyR[j,k];
          zzRS[j,k] := zzR[j,k];
        end;
  end; { SalveazaCoordRotite }

  procedure RestaureazaCoordRotite( var xxRS,yyRS,zzRS : MatriceBaza;
                                    var xxR, yyR, zzR  : MatriceBaza;
                                              mm,   nn : byte );
  var j,k : byte;
  begin
    for j := 1 to mm do
        for k := 1 to nn do
        begin
          xxR[j,k] := xxRS[j,k];
          yyR[j,k] := yyRS[j,k];
          zzR[j,k] := zzRS[j,k];
        end
  end; { RestaureazaCoordSuprafataRotita }

  procedure SalveazaCoordBazaCurba( var xxxH,yyyH,zzzH,xxxHS,yyyHS,zzzHS : VectorBaza;
                                        nn : byte );
  var  j : byte;
  begin
    for j := 1 to nn do begin
        xxxHS[j] := xxxH[j];
        yyyHS[j] := yyyH[j];
        zzzHS[j] := zzzH[j];
    end;  { for }
  end;  { SalveazaCoordBazaCurba }

  procedure RestaureazaCoordBaza( var xxxS,yyyS,zzzS,xxxB,yyyB,zzzB : MatriceBaza;
                                        mm,  nn : byte );
  var  j,k : byte;
  begin
    for j := 1 to mm do
        for k := 1 to nn do
        begin
          xxxB[j,k] := xxxS[j,k];
          yyyB[j,k] := yyyS[j,k];
          zzzB[j,k] := zzzS[j,k]
        end
   end; { RestaureazaCoordBazaSuprafata }

   procedure RestaureazaCoordBazaCurba( var xxxHS,yyyHS,zzzHS,xxxH,yyyH,zzzH : VectorBaza ;
                                            nn : byte );
   var j : byte;
   begin
     for     j := 1 to nn do begin
       xxxH[j] := xxxHS[j];
       yyyH[j] := yyyHS[j];
       zzzH[j] := zzzHS[j];
     end  { for }
   end; { RestaureazaCoordBazaCurba }

 procedure Scaleaza( var xxSc,yySc,zzSc : MatriceBaza;
                                mm,  nn : byte;
                                  Scale : real    );
 var j,k : byte;
 begin
   for j := 1 to mm do
       for k := 1 to nn do
       begin
         xxSc[j,k] := xxSc[j,k]*Scale;
         yySc[j,k] := yySc[j,k]*Scale;
         zzSc[j,k] := zzSc[j,k]*Scale;
       end;
 end; { Scaleaza }

 procedure Init;
 var GraphDriver, GraphMode : integer;
     MaxXX, MaxYY             : word;
 begin
   GraphDriver := 3;
   GraphMode   := 1;
   InitGraph( GraphDriver, GraphMode, 'C:\TP7\BGI' );
   MaxX  := GetMaxX;
   MaxY  := GetMaxY;
     x0 :=  550 div 2;
     y0 :=  (300 div 2);
 end;  { Init }

 procedure Traseaza( var qqq, www : MatriceIntr;
                          mm,  nn  : byte  );
 var              j,k : byte;
       GraphX, GraphY : word;
       sc             : real;
 begin
   sc := 1.0;
   j := 0;
   repeat
     j := j+1;
     k := 0;
     repeat
       k := k+1;
       GraphX := trunc( qqq[j,k] * sc ) + x0;
       GraphY := trunc( www[j,k] * sc ) + y0;
       if ( (j=1) and (k=1) ) or ( k=1 ) then MoveTo( GraphX, GraphY )
                                         else LineTo( GraphX, GraphY );
     until k = nn;
   until j = mm;

   k := 0;
   repeat
     k := k+1;
     j := 0;
     repeat
       j := j+1;
       GraphX :=  trunc( qqq[j,k] * sc ) + x0;
       GraphY :=  trunc( www[j,k] * sc ) + y0;
       if ( (j=1) and (k=1) ) or ( j=1 ) then MoveTo( GraphX, GraphY )
                                         else LineTo( GraphX, GraphY );
     until j = nn;
   until k = mm;
 end;  { TraseazaSuprafata }

 procedure TraseazaCurba( var qqqH,wwwH : MatriceIntr;
                                mm,  nn : byte );
 var j  : byte;
     sc : real;
     GraphX, GraphY : word;
 begin
  sc := 1.00;
   j := 0;
   repeat
     j := j+1;
     GraphX := trunc( qqqH[1,j] * sc ) + x0 ;
     GraphY := trunc( wwwH[1,j] * sc ) + y0 ;
     if (j=1) then MoveTo( GraphX, GraphY )
              else LineTo( GraphX, GraphY );
   until j = nn;
 end; { TraseazaCurba }

 procedure ClearWorkPort;
 var pg,c : byte;
 begin
   SetViewPort( 0,0,MaxX,MaxY,True );
   SetViewPort( 2,31,549,329, True );
    c := 0;
   pg := 0;
   repeat
     SetActivePage( pg );
     SetVisualPage( 1-pg );
     ClearViewPort;
     pg := 1-pg;
     c  := c+1;
  until c = 2;
  SetViewPort( 0,0,MaxX,MaxY,True );
end;


  procedure SetWorkPort;
  begin
    SetViewPort( 2,31,549,329, True )
  end;

  procedure ExitWorkPort;
  begin
    SetViewPort(0,0,GetMaxX,GetMaxY,True )
  end;

  procedure SetDesign;
  var pg : byte;
  begin
    pg := 0;
    repeat
      SetActivePage( pg );
      SetVisualPage( pg );
      ClearDevice;
      SetColor( LightRed );
      SetLineStyle( SolidLn,0,ThickWidth );
      Rectangle( 1,30,550,330 );
      SetLineStyle( SolidLn,0,NormWidth );
      SetColor( White );
      Line( 0,339,GetMaxX,339 );
      pg := pg + 1;
    until pg = 2;
  end;

  procedure Message( Msg : string );
  var pg,c : byte;
  begin
    pg := 0;
    repeat
      SetVisualPage( pg );
      SetActivePage( pg );
      SetFillStyle( SolidFill, Black );
      Bar( 0,340,600,GetMaxY );
      OutTextXY( 0,GetMaxY,Msg );
      pg := pg+1;
    until pg = 2;
  end;

  procedure DrawBar( x1,y1,x2,y2,BarColor : word; Message : string);
  begin
    SetFillStyle( SolidFill, BarColor );
    Bar( x1+5,y1+3,x2-2,y2-3 );
    SetTextStyle(   SmallFont, HorizDir, 1 );
    SetTextJustify( LeftText, BottomText  );
    OutTextXY( x1+10, y1+2*(TextHeight('M')-2), Message );
  end;

  procedure InitMeniu;
  begin
    MsgMeniu[1,1,1] := 'Curbe';      MsgMeniu[1,1,2] := 'Suprafete';
    MsgMeniu[1,2,1] := 'Hermite';    MsgMeniu[1,2,2] := 'Hermite';
    MsgMeniu[1,3,1] := 'Bezier';     MsgMeniu[1,3,2] := 'Bezier';
    MsgMeniu[1,4,1] := 'B-Spline';   MsgMeniu[1,4,2] := 'B-Spline';
    MsgMeniu[1,5,1] := 'Y = Y(X)';   MsgMeniu[1,5,2] := 'Z = Z(X,Y)';

    MsgMeniu[2,1,1] := 'Rotatie';    MsgMeniu[2,1,2] := 'Scalare';     MsgMeniu[2,1,3] := 'Translatie';
    MsgMeniu[2,2,1] := 'Automat';    MsgMeniu[2,2,2] := '';            MsgMeniu[2,2,3] := '';
    MsgMeniu[2,3,1] := 'Manual';     MsgMeniu[2,3,2] := '';            MsgMeniu[2,3,3] := '';
    MsgMeniu[2,4,1] := 'Unghiuri fixe';MsgMeniu[2,4,2] := '';          MsgMeniu[2,4,3] := '';
  end;

  procedure MeniuColoana( CXmin,CYmin,CXmax,CYmax : word;
                          Lungime                 : byte;
                          var  Lin                : byte       );

  var Xdiv, Ydiv , c, color, i        : word;
      BarXmin,BarXmax,BarYmin,BarYmax : word;
      ch1                             : char;
      Fereastra                       : pointer;
      MarFer                          : word;     { Marime ferestra }
  begin
    MarFer := ImageSize( CXmin,CYmin,CXmax,CYmax );
    GetMem( Fereastra, MarFer );
    GetImage( CXmin,CYmin,CXmax,CYmax, Fereastra^ );

    SetFillStyle( SolidFill, Black );
    Bar( CXmin,CYmin,CXmax,CYmax );
    Rectangle( CXmin,CYmin,CXmax,CYmax );
    Ydiv := trunc( (CYmax-CYmin)/lungime );
    c := 1; color := Black;
    BarXmin := CXmin   ;  BarXmax := CXmax           ;
    BarYmin := CYmin   ;  BarYmax := BarYmin + Ydiv ;
    repeat
       c := c + 1;
       DrawBar( BarXmin,BarYmin,BarXmax,BarYmax,color,MsgMeniu[DM,c,ValCol]);
       BarYmin := BarYmin + Ydiv;
       BarYmax := BarYmin + Ydiv;
    until c >= lungime+1;

 { Implementarea partii mobile a meniului }

    Lin := 2;
    BarYmin := CYmin;
    BarYmax := BarYmin + Ydiv;
    DrawBar( BarXmin,BarYmin,BarXmax,BarYmax,LightRed,MsgMeniu[DM,Lin,ValCol] );
    repeat
       ch1 := ReadKey;
       DrawBar( BarXmin,BarYmin,BarXmax,BarYmax,Black,MsgMeniu[DM,Lin,ValCol] );
       if ch1 = #13 then
          begin
             DrawBar( BarXmin,BarYmin,BarXmax,BarYmax, White, MsgMeniu[DM,Lin,ValCol]);
             Delay(50);
             DrawBar( BarXmin,BarYmin,BarXmax,BarYmax, Black,MsgMeniu[DM,Lin,ValCol] );
             Delay(25);
             DrawBar( BarXmin,BarYmin,BarXmax,BarYmax, White,MsgMeniu[DM,Lin,ValCol] );
             Delay(50);
             DrawBar( BarXmin,BarYmin,BarXmax,BarYmax, Black,MsgMeniu[DM,Lin,ValCol] );
          end;
       case ch1 of
         #72 : begin
                  Lin := Lin - 1;
                  if Lin = 1 then Lin := lungime+1;
                  BarYmin := CYmin+((Lin-2)*Ydiv) ; BarYmax := BarYmin + Ydiv;
                  DrawBar( BarXmin,BarYmin,BarXmax,BarYmax, LightRed,MsgMeniu[DM,Lin,ValCol] );
               end;
         #80 : begin
                  Lin := Lin + 1;
                  if Lin = lungime+2 then Lin := 2;
                  BarYmin := CYmin+((Lin-2)*Ydiv) ; BarYmax := BarYmin + Ydiv;
                  DrawBar( BarXmin,BarYmin,BarXmax,BarYmax, LightRed,MsgMeniu[DM,Lin,ValCol] );              end;
       end; { case }
       ValLin := Lin;
    until ch1 = #13;

    PutImage( CXmin,CYmin, Fereastra^, CopyPut );
    FreeMem(  Fereastra, MarFer );
  end;

  procedure MeniuLinie(   LXmin,LYmin,LXmax,LYmax : word;
                          Latime                  : byte;
                          var  Col                : byte    );

  var Xdiv,  cc, color, i, ii             : word;
      BarLXmin,BarLXmax,BarLYmin,BarLYmax : word;
      indice                              : byte;
      ch2                                 : char;
  begin

    SetFillStyle( SolidFill, Black );
    Bar3D( LXmin,LYmin,LXmax,LYmax,5,True );
    Xdiv := trunc( (LXmax-LXmin)/latime );
    cc := 0;
    color := Black;
    BarLXmin := LXmin   ;  BarLXmax := BarLXmin + Xdiv           ;
    BarLYmin := LYmin   ;  BarLYmax := LYmax   ;
    repeat
       cc := cc + 1;
       DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax,color,MsgMeniu[DM,ValLin,cc]);
       BarLXmin := BarLXmin + Xdiv;
       BarLXmax := BarLXmin + Xdiv;
    until cc >= Latime;

 { Implementarea partii mobile a meniului }

    Col := 1;
    BarLXmin := LXmin;
    BarLXmax := BarLXmin + Xdiv;
    DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax,LightRed,MsgMeniu[DM,ValLin,Col] );
    repeat
       ch2 := ReadKey;
       DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax, Black, MsgMeniu[DM,ValLin,Col]);
       if ch2 = #13 then
          begin
             DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax, White, MsgMeniu[DM,ValLin,Col]);
             Delay(50);
             DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax, Black,MsgMeniu[DM,ValLin,Col] );
             Delay(25);
             DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax, White,MsgMeniu[DM,ValLin,Col] );
             Delay(50);
             DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax, Black,MsgMeniu[DM,ValLin,Col] );
          end;
       case ch2 of
         #75 : begin
                  Col := Col - 1;
                  if Col = 0 then Col := latime;
                  BarLXmin := LXmin+((Col-1)*Xdiv) ;
                  BarLXmax := BarLXmin + Xdiv;
                  DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax, LightRed,MsgMeniu[DM,ValLin,Col] );
               end;
         #77 : begin
                  Col := Col + 1;
                  if Col >= latime+1 then Col := 1;
                  BarLXmin := LXmin+((Col-1)*Xdiv) ;
                  BarLXmax := BarLXmin + Xdiv;
                  DrawBar( BarLXmin,BarLYmin,BarLXmax,BarLYmax, LightRed,MsgMeniu[DM,ValLin,Col] );
              end;
       end; { case }
    until ch2 = #13;
    ValCol := Col;
  end;

  begin
  end.