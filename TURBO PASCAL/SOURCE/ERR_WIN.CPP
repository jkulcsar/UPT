
  #include <graphics.h>
  #include <process.h>
  #include <conio.h>

  #include "e_win_cl.dat"

  #define MARGINE 8

  void error_window::create_error_window( char *error_msg )
  {
    char *mesaj,msg[] = "Mesaj de eroare prea lung! ";
    int lung, inalt, x = getmaxx()/2, y = getmaxy()/2;


    lung = textwidth(error_msg)/2;
    inalt = textheight(error_msg);
    mesaj = error_msg;

    // daca mesajul este unul prea lung, este inlocuit cu unul de avertizare
    if(lung+MARGINE > x)
      {
	lung = textwidth(msg);
	inalt = textheight(msg);
	mesaj = msg;
      }


    create_window(" EROARE ",x-lung-MARGINE,y-2*inalt,
			     x+lung+MARGINE,y+3*inalt);

    outtextxy( x-lung,y+2*inalt, mesaj );
  }

  void error_window::destroy_error_window()
  {
    destroy_window();
  }
