  program Menu ;
  uses    Crt,Graph  ;
  const   Nmax  =  10;
  type    DMM   =  1..2;
          ML    =  1..5;
          MC    =  1..5;
   MsgMeniuType = array[ DMM,ML,MC ] of string[20];
  var     GraphDriver, GraphMode : integer   ;
          x0, y0                 : word      ;
          MsgMeniu               : MsgMeniuType ;
          DM                     : byte      ;
       ValCol, ValLin            : byte      ;
       VL, VC, DMDM              : string    ;
       car                       : char      ;

  procedure Init;
  begin
    GraphDriver := 9;
    GraphMode   := 2;
    InitGraph( GraphDriver, GraphMode,'c:\');
    x0 := GetMaxX div 2;
    y0 := GetMaxY div 2;
    ClearDevice;
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

  procedure Desen;
  var Radius : byte;
  begin
     Radius := 1;
     repeat
        Circle( x0,y0,Radius );
        Radius := Radius + 10;
     until Radius >= 200;
   end;

  procedure DrawBar( x1,y1,x2,y2,BarColor : word; Message : string);
  begin
    SetFillStyle( SolidFill, BarColor );
    Bar( x1+3,y1+2,x2-3,y2-2 );
    SetTextStyle(   SmallFont, HorizDir, 1 );
    SetTextJustify( LeftText, BottomText  );
    OutTextXY( x1+10, y1+2*(TextHeight('M')+1), Message );
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

  begin { main }
    Init;
    InitMeniu;
    DM     := 1;
    ValCol := 1;
    ValLin := 1;
    Line(0,40,640,40);
    MeniuLinie(  10,5,630,30, 2, ValCol );
    MeniuColoana( ValCol*175-150,50,(ValCol+1)*175-150,150,4,ValLin);
    Str( DM, DMDM );   OutTextXY( 10,380,DMDM );
    Str( ValLin, VL ); OutTextXY( 50,380,VL );
    Str( ValCol, VC ); OutTextXY( 90,380,VC );
      DM := DM + 1;
      ValLin := 1;
      ValCol := 1;
    MeniuLinie( 10,5,630,30, 3,  ValCol );
    MeniuColoana(ValCol*175-150,50,(ValCol+1)*175-150,150,3,ValLin );
    Str( DM, DMDM );   OutTextXY( 10,400,DMDM );
    Str( ValLin, VL ); OutTextXY( 50,400,VL );
    Str( ValCol, VC ); OutTextXY( 90,400,VC );
    Line(0,GetMaxY-15,640,GetMaxY-15);
    OutTextXY(0,GetMaxY,' This is it ');
    repeat until KeyPressed;
    CloseGraph;
  end. { main }
