program matrix ;
uses Graph, Crt, MyGraph ;
var               x0,y0 : word;
         xSO ,ySO ,zSO  : MatriceBaza;
            xS ,yS ,zS  : MatriceBaza;
              qSO, wSO  : MatriceIntr;
              page, arg : word;
                    pas : real;
                    j,k : byte;

 procedure ReadData;
 var     j,k : byte;
     ch, chr : char;
        nume : string[20];
           f : file of MatriceData;
 begin
          ClrScr;
          write(' Pasul de parcurgere este . . . '); readln( pas );
 end; { ReadData }

begin  { main }
   {ReadData;}
   CalcVectorSinCos;
   CalcCoordBazaSuprafataOarecare( xSO,ySO,zSO,  pas );
   SalveazaCoordBazaSuprafata( xSO,ySO,zSO,  xS,yS,zS, marime );
   Init;
   SetColor( LightRed );
   SetActivePage( 0 );
      Rectangle( 0,0,540,300 );
   SetActivePage( 1 );
      Rectangle( 0,0,540,300 );
   page := 0;
   arg  := 0;
   SetColor( Yellow );
   repeat
     SetActivePage( page );
     SetVisualPage(1-page);
     SetViewPort( 1,1,539,299, true );
     ClearViewPort;
     RotesteSuprafata( xSO,ySO,zSO,   marime,  arg,arg,arg );
     ProiecteazaSuprafata( xSO,ySO,zSO,  qSO,wSO,  marime );
     TraseazaSuprafata( qSO,wSO,  marime );
     RestaureazaCoordBazaSuprafata( xS,yS,zS,  xSO,ySO,zSO, marime );
     arg := arg+2;
     page := 1-page;
     if arg = 360 then arg := 0;
   until  KeyPressed;
   repeat until KeyPressed;
end.   { main }

