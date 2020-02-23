
 #include <conio.h>
 #include <process.h>
 #include <graphics.h>
 #include <stdlib.h>
 #include <alloc.h>


 #include "window.dat"

 void init_graph( void )
 {
   int gdriver = DETECT, gmode;

   initgraph( &gdriver, &gmode, "C:\\TCPP\\BGI");
 }

 void creaza_scena( void )
 {
   for(int i=0;i<20;i++)
      {
	setcolor(i);
	circle( random(640), random(480), i*random(10) );
      }
 }

 void actiune( void )
 {
   general_window win1;
   char           liber[20];


   getch();
   ltoa( farcoreleft(), liber, 10 );
   outtextxy(10,450,liber);
   getch();
   win1.create_window( " Window #1" ,10,10,150, 100 );
   getch();
     ltoa( farcoreleft(), liber, 10 );
     outtextxy(10,10,liber);
     getch();
     creaza_scena();
   getch();
   win1.destroy_window();
   getch();
 }

 void main( void )
 {
   init_graph();
   creaza_scena();
   actiune();

   closegraph();
 }