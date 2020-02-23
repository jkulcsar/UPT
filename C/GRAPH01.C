
 #include <graphics.h>
 #include <stdio.h>
 #include <conio.h>
 #include <process.h>

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
    initgraph(&GraphDriver, &GraphMode,"C:\TC\BGI");
    GraphError = graphresult();
    if(GraphError<0)
	 {
	   printf("\nInitgraph error : %s ",grapherrormsg(GraphError));
	   exit(1);
	 }
 }

 void draw_something(void)
 {
    maxX = getmaxx();
    maxY = getmaxy();
    cleardevice();
    circle(maxX/2,maxY/2,80);
 }

 void main(void)
 {
	 start_graph();
	 draw_something();
	 getch();
	 closegraph();
 }