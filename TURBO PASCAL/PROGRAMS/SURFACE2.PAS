program matrix ;
uses Graph, Crt, MyGraph ;
label 10, 20;
var               x0,y0 : word;
            x  ,y  ,z   : MatriceBaza;
            xS ,yS ,zS  : MatriceBaza;
            xR ,yR ,zR  : MatriceBaza;
                q,  w   : MatriceIntr;
                    s   : real       ;
     pg, page, arg,Varg : word       ;
     chRA, chS, op4, ch : char       ;

begin  { main }
   CalcVectorSinCos;
   Init;
   InitMeniu;
   SetDesign;
   arg := 0;
   repeat
10:   DM  := 1;
   ValCol := 1;
   ValLin := 1;
   MeniuLinie( 10,round(GetMaxY*0.014286),630,round(GetMaxY*0.06), 2, ValCol );
   MeniuColoana( (ValCol*250-250)+7,round(GetMaxY*0.1),(ValCol+1)*250-250,100,4,ValLin);
   SetFillStyle( SolidFill, Black );
   Bar( 0,0,640,25 );
   case ValCol of
     1 : begin
           case ValLin of
              2 : begin
                    Message('Hermite curves are not implemented yet. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    Goto 10;
                  end;
              3 : begin
                    Message('Bezier curves are not implemented yet. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    GoTo 10;
                  end;
              4 : begin
                    Message('B-Spline curves are not implemented yet. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    GoTo 10;
                  end;
              5 : begin
                    Message('Y=Y(X) functions are not implemented yet. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    GoTo 10;
                  end;
           end;
         end;
     2 : begin
           case ValLin of
              2 : begin
                    Message('Hermite surfaces are not implemented yet. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    GoTo 10;
                  end;
              3 : begin
                    Message('Bezier surfaces are implemented, but later. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    GoTo 10;
                  end;

              4 : begin
                    Message('B-Spline surfaces are not implemented yet. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    GoTo 10;
                  end;
              5 : begin
                    Message(' Wait, please . . . I am computing. ');
                    CalcCoordBazaSuprafataOarecare( x,y,z,0.1 );
                    SalveazaCoordBaza( x,y,z,xS,yS,zS, Linii, Coloane );
                    Message('');
                  end;
           end; { case ValLin from option 'Suprafete' }
         end;
   end; { case ValCol from the first menu }

   DM  := DM + 1;        { Se trece la meniul al doilea, cel al operatiilor }
20 :   ValLin := 1;
       ValCol := 1;
   MeniuLinie(  10,round(GetMaxY*0.014286),630,round(GetMaxY*0.06), 3, ValCol );
   if ValCol = 1 then MeniuColoana(ValCol*175-150,50,(ValCol+1)*175-150,120,3,ValLin );
   SetFillStyle( SolidFill, Black );
   Bar(0,0,640,25);
   case ValCol of
     1 : begin
           case ValLin of
              2 : begin
                    page := 0;
                    Message(' Esc - Operation Menu     Enter - Main Menu ');
                    ClearWorkPort;
                    SetWorkPort;
                    SetColor( Yellow );
                    repeat
                      SetActivePage( page );
                      SetVisualPage(1-page);
                      ClearViewPort;
                      Roteste( x,y,z,   Linii,Coloane,  arg,arg,arg );
                      Proiecteaza( x,y,z,  q,w,  Linii,Coloane );
                      Traseaza( q,w,  Linii,Coloane );
                      RestaureazaCoordBaza( xS,yS,zS,  x,y,z, Linii,Coloane );
                      arg := arg+2;
                      page := 1-page;
                      if arg = 360 then arg := 0;
                    until KeyPressed;
                    ExitWorkPort;
                    SetActivePage( page );
                    SetVisualPage( page );
                    chRA := ReadKey;
                    Message('');
                    if chRA = #27 then GoTo 20;
                    if chRA = #13 then GoTo 10;
                  end;
              3 : begin
                    Message(' Manual rotation is not implemented yet. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    GoTo 20;
                  end;
              4 : begin
                    Message(' Rotation by fix angles is not implemented yet. Press any key . . .');
                    repeat until KeyPressed;
                    Message('');
                    GoTo 20;
                  end;
              end;
         end; { case Valcol = 1 from the second menu }
     2 : begin
           ClearWorkPort;
           Message(' Use  +  or   -  keys . . . Esc stops');
           SetWorkPort;
           Roteste( x,y,z, Linii,Coloane, arg,arg,arg );
           SalveazaCoordRotite( x,y,z, xR,yR,zR, Linii,Coloane );
           page := 0;
              s := 1;
              repeat
                SetActivePage( page );
                SetVisualPage( 1-page );
                ClearViewPort;
                  op4 := ReadKey;
                      if op4 = #43 then s := s + 0.1;
                      if op4 = #45 then s := s - 0.1;
                      if s <= 0.1 then s := 0.1;
                  Scaleaza( x,y,z, Linii,Coloane, s );
                  Proiecteaza(  x,y,z, q,w, Linii,Coloane );
                  Traseaza( q,w, Linii,Coloane );
                  RestaureazaCoordRotite( xR,yR,zR, x,y,z, Linii,Coloane );
                  page := 1-page;
                until op4 = #27;
                ExitWorkPort;
                Message( ' Esc - Operation Menu     Enter - Main Menu');
                chS := ReadKey;
                Message('');
                if chS = #27 then GoTo 20;
                if chS = #13 then GoTo 10;
         end;
     3 : begin
           Message(' Translation is not implemented yet.');
           repeat until KeyPressed;
           Message('');
           GoTo 20;
         end;
   end; { case ValCol from the second menu }
   ch := ReadKey;
   until ch = #27;
end. { main }


