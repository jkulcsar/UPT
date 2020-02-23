  program Grafic3 ;
  uses graph, crt ;
  var
   graphdriver, graphmode, i : integer ;
   t1, t2, scalX, scalY      : integer ;
   a, b, val1                : real    ;
   ch                        : char    ;
   MaxX, MaxY                : integer ;
 { ------------------------------------- }
   function f ( x:real )     : real    ;
   begin
    { f := 5.0 * exp( -0.3*x )+ 15.0 * exp( -0.1*x )-20.0*exp( -0.2*x );}
     f := ( sin(x) + sin(2*x) + sin(3*x)  )*exp( -0.1*x );
   end ;

  procedure AXE ;
   begin
    SetLineStyle ( DottedLn, 0, NormWidth );
    moveto ( MaxX div 2,(MaxY div 2)-((MaxY div 2)-10) ) ; lineto( MaxX div 2,(MaxY div 2)+((MaxY div 2)-5));
    moveto ( (MaxX div 2)-((MaxX div 2)-10),MaxY div 2 ) ; lineto( (MaxX div 2)+(MaxX div 2), MaxY div 2);
   end;

  procedure DrawBorder ;
  var
   ViewPort : ViewPortType ;
  begin
   SetLineStyle (SolidLn , 0, NormWidth );
   GetViewSettings ( ViewPort );
   with ViewPort do
    Rectangle ( 0, 0, GetMaxX, GetMaxY );
   end;


  procedure MainWindow ( Msg : string );
   begin
    ClearDevice ;
    SetTextStyle ( DefaultFont, HorizDir, 1 );
    SetTextJustify ( CenterText, TopText );
    OutTextXY (MaxX div 2 , 2, Msg );
     { Draw main window }
        SetViewPort ( 0, TextHeight( 'M' )+4, MaxX, MaxY-(TextHeight('M')+4), ClipOn );
        DrawBorder ;
        SetViewPort( 1, TextHeight('M')+5, MaxX-1,MaxY-(TextHeight('M')+5), ClipOn);
   end;

   begin { main }
    ClrScr ;
    writeln (' Program pentru trasarea graficului unei functii ');
    writeln (' Pentru continuare tastati orice tasta ! ');
    ch := readkey ;

    graphdriver := detect ;
    initgraph ( graphdriver, graphmode, 'g:\public\tp6\bgi');
    SetBkColor (0); SetColor (10);
    MaxX := GetMaxX ; MaxY := GetMaxY ;
    SetLineStyle ( SolidLn, 0, NormWidth );
    { MainWindow(' f(x)= [ sin(x) + sin(3x) ]*exp(-x/10) ');}
    a := -2.07*pi ; b :=  6*pi/2 ;
          { se traseaza graficul functiei }
    scalX := 40 ; scalY := 40 ;  { scalare pe X si Y }
    t1 := round (a) * scalX ;
    t2 := round (b) * scalX ;
    moveto ( (t1+(MaxX div 2)), (round( f(a)*scalY)+(MaxY div 2)) );
     for i := t1 + 1 to t2 do
      begin
        val1 := i/scalX ;
        lineto (( round ( val1*scalX )+(MaxX div 2) ),((MaxY div 2)-round ( f(val1)*scalY )) );
      end;
      SetTextStyle ( SmallFont, HorizDir, 5 );
      SetTextJustify (LeftText, BottomText );
      OutTextXY ((MaxX-300), (MaxY-10), 'f(x)=(sin(x)+sin(2x)+sin(3x))*exp(-x/10)');
      Rectangle ( 0,0, GetMaxX, GetMaxY );
    AXE ;
    ch := readKey ;
    closegraph ;
    end.

