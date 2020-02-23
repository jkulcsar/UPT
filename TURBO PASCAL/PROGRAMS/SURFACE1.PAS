program matrix ;
uses Graph, Crt, MyGraph ;
var               x0,y0 : word;
         xSO ,ySO ,zSO  : MatriceBaza;
            xS ,yS ,zS  : MatriceBaza;
            xR ,yR ,zR  : MatriceBaza;
              qSO, wSO  : MatriceIntr;
     pg, page, arg,Varg : word;
                 pas, s : real;
                  c,j,k : byte;
    op1,op2,op3,op4,ch  : char;

begin  { main }
   CalcVectorSinCos;
   CalcCoordBazaSuprafataOarecare( xSO, ySO, zSO, pas );
   SalveazaCoordBazaSuprafata( xSO, ySO, zSO,  xS,yS,zS, marime );
   Init;
   arg := 0;
   repeat
     ch := ReadKey;
     if ch = #68 then begin
     MeniuLinie( 10,5,630,30,5,MsgLin,ValLin );
     case ValLin of :
       1 : begin
             MeniuColoana(ValLin*120-100,50,(ValLin+1)*120-100,150,4,MsgCol,ValCol);
             case ValCol of :
               1 : begin
                     ClearWorkPort;
                     OutTextXY( 10,10,' This is not implemented yet.');
                   end;
               2 : begin
                     ClearWorkPort;
                     OutTextXY( 10,10,' This is not implemented yet.');
                   end;
        'C' : begin
                MainFrame;
                MessageFrame( ' Press any key to stop Continuos Rotation . . . ');
                page := 0;
                SetColor( Yellow );
                  repeat
                    SetActivePage( page );
                    SetVisualPage(1-page);
                    ClearViewPort;
                    RotesteSuprafata( xSO,ySO,zSO,   marime,  arg,arg,arg );
                    ProiecteazaSuprafata( xSO,ySO,zSO,  qSO,wSO,  marime );
                    TraseazaSuprafata( qSO,wSO,  marime );
                    RestaureazaCoordBazaSuprafata( xS,yS,zS,  xSO,ySO,zSO, marime );
                    arg := arg+2;
                    page := 1-page;
                    if arg = 360 then arg := 0;
                  until KeyPressed;
              end; { case 'C' }

        'M' : begin
                MainFrame;
                MessageFrame( ' Rotate by cursors . . . Esc aborts Manual Rotation   ');
                page := 0;
                   c := 0;
                SetColor( Yellow );
                repeat
                  SetActivePage( page );
                  SetVisualPage( 1-page );
                  ClearViewPort;
                       op3 := ReadKey; op3 := upcase( op3 );
                       if op3 = 'X' then RotesteSuprafata( xSO,ySO,zSO, marime, arg+c,arg,arg );
                       if op3 = 'Y' then RotesteSuprafata( xSO,ySO,zSO, marime, arg,arg+c,arg );
                       if op3 = 'Z' then RotesteSuprafata( xSO,ySO,zSO, marime, arg,arg,arg+c );
                  ProiecteazaSuprafata( xSO,ySO,zSO, qSO,wSO, marime );
                  TraseazaSuprafata( qSO,wSO, marime );
                  RestaureazaCoordBazaSuprafata( xS,yS,zS, xSO,ySO,zSO, marime );
                  page := 1-page;
                  c := c + 2;
                  if c = 360 then c := 0;
                until KeyPressed;
              end; { case 'M' }

        'S' : begin
                MainFrame;
                MessageFrame(' Scaling is coming here ! ');
                RotesteSuprafata( xSO,ySO,zSO, marime, arg,arg,arg );
                SalveazaCoordSuprafataRotita( xSO,ySO,zSO, xR,yR,zR, marime );
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
                  ScaleazaSuprafata( xSO,ySO,zSO, marime, s );
                  ProiecteazaSuprafata(  xSO,ySO,zSO, qSO,wSO, marime );
                  TraseazaSuprafata( qSO,wSO, marime );
                  RestaureazaCoordSuprafataRotita( xR,yR,zR, xSO,ySO,zSO, marime );
                  page := 1-page;
                until KeyPressed;
              end;  { case 'S' }

        'I' : begin
                MainFrame;
                MessageFrame( ' Press Esc  to return to Turbo Pascal . . . ');
                SetActivePage( 0 );
                SetVisualPage( 0 );
                RotesteSuprafata( xSO,ySO,zSO, marime, 0,325,35 );
                SalveazaCoordSuprafataRotita( xSO,ySO,zSO, xR,yR,zR, marime );
                ProiecteazaSuprafata( xSO,ySO,zSO, qSO,wSO, marime );
                TraseazaSuprafata( qSO,wSO, marime );
                RestaureazaCoordBazaSuprafata( xS,yS,zS, xSO,ySO,zSO, marime );
                repeat until KeyPressed;
             end;   {  case 'I'  }
      end; { case }
  until ch = #27
 end.   { main }

