
 #include <graphics.h>
 #include <stdio.h>
 #include <conio.h>
 #include <alloc.h>
 #include <process.h>
 #include "tipuri3d.h"
 #include "filehndl.h"
 #include "perspect.h"

 int GraphDriver, GraphMode, GraphError;
 int maxX, maxY, minX, minY;

 void start_graph(void)
 {
    detectgraph( &GraphDriver, &GraphMode );
    if(GraphDriver<0)
	 {
	    printf("\n No graphics hardware detected .");
	    exit(1);
	 }
    initgraph(&GraphDriver, &GraphMode,"");
    GraphError = graphresult();
    if(GraphError<0)
	 {
	   printf("\nInitgraph error : %s ",grapherrormsg(GraphError));
	   exit(1);
	 }
 }

 void draw_something(void)
 {
    int i;

    maxX = getmaxx();
    maxY = getmaxy();
    cleardevice();
    i = 0;
    do
      {
         circle(maxX/2,maxY/2,i);
	 i = i + 10;
      }
    while(i<=200);
 }

 void main(void)
 {

    int                  i;
    t_adresa_obiect3d   *to;
    t_adresa_punct2d    *tqw;


    to = citeste_tablou_obiecte3d();
    afiseaza_tablou_obiecte3d( to );
    printf("\n  Press any key . . . ");
    getch();
    clrscr();

    tqw = (t_adresa_punct2d*) malloc( to[0]->ltv*sizeof(t_adresa_punct2d) );
    for(i=0;i<to[0]->ltv;i++)
       tqw[i] = (t_punct2d*) malloc( sizeof(t_punct2d) );
    tqw = proiecteaza_obiectul3d( 0, to );
    for(i=0;i<to[0]->ltv;i++)
       printf("\n %5.5f    %5.5f", tqw[i]->q, tqw[i]->w);

    for(i=0;i<to[0]->ltv;i++)
       if(tqw[i]!=NULL) free(tqw[i]);
    if(tqw!=NULL) free(tqw);

    printf("\n  Press any key . . . ");
    getch();

    dealoca_tablou_obiecte3d(  to );


 }