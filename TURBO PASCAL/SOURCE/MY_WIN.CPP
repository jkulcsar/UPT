
  #include <conio.h>
  #include <stdio.h>
  #include <process.h>
  #include <graphics.h>

  #include "e_win_cl.dat"

  void init_graph( void )
  {
    int gdriver = DETECT, gmode, err;

    initgraph( &gdriver, &gmode, "C:\\TCPP\\BGI");

    err = graphresult();

    if(err!=grOk)
      {
	printf(" GRAPHICS ERROR : %s\n", grapherrormsg(err));
	exit(1);
      }
  }

  void creaza_scena()
  {
    char txt[]  = "Este";
    char txt1[] = "un program";
    char txt2[] = "demonstrativ al cartii de C++";

    circle(50,50,50);
    circle(80,80,80);
    circle(120,120,120);

    settextjustify( LEFT_TEXT, LEFT_TEXT );
    settextstyle( TRIPLEX_FONT, HORIZ_DIR,10 );

    outtextxy((getmaxx()/2)-(textwidth(txt)/2),(getmaxy()/3)+
					       (textheight(txt)/2),txt);
    settextstyle(  TRIPLEX_FONT, HORIZ_DIR,2);
    outtextxy((getmaxx()/2)-(textwidth(txt1)/2),getmaxy()-2*textheight(txt1),txt1);
    settextstyle(GOTHIC_FONT, HORIZ_DIR, 4 );
    outtextxy((getmaxx()/2)-(textwidth(txt2)/2),getmaxy()-2,txt2);
  }

  void actiune( void )
  {
    general_window gw1;
    general_window gw2;
    general_window gw3;

    gw1.create_window(" Fereastra numarul 1 ",5,5,200,200);
    outtextxy(500,30,"A");
    gw2.create_window(" Numarul 2 ", 10,10,100,100);
    outtextxy(500,60,"B");
    gw3.create_window(" Numarul 3 ", 50,50,150,150);
    outtextxy(500,90,"C");
    getch();

    gw3.destroy_window();
    getch();
    gw2.destroy_window();
    getch();
    gw1.destroy_window();
    getch();

    outtextxy(500,120,"D");
    gw1.create_window(" Numarul 1 ",5,5,200,200);
    gw2.create_window(" Numarul 2 ", 10,10,100,100);
    gw3.create_window(" Numarul 3 ", 50,50,150,150);

    error_window ew1;
    ew1.create_error_window(" Disc protejat la scriere ! ");
    outtextxy(500,150,"E");
    getch();

    error_window ew2;
    ew1.create_error_window(" Memorie insuficienta ! ");
    outtextxy(500,180,"F");
    getch();

    ew2.destroy_error_window();
    getch();
    ew1.destroy_error_window();
    getch();
  }

  void main( void )
  {
    init_graph();
    creaza_scena();
    actiune();

    closegraph();
  }