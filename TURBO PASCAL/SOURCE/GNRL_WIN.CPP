
 #include <iostream.h>
 #include <graphics.h>
 #include <process.h>
 #include <string.h>

 #include "g_win_cl.dat"     // contine declaratia clasei


 // salvare imagine de "sub" ferastra
 void general_window::get_image()
 {
   image_size  = imagesize(x,y,dx,dy);
   store_image = new char[image_size];

   if (store_image == NULL )
      {
	cout<<" Out of memory in GENERAL_WINDOW\n";
	exit(1);
      }
   getimage(x,y,dx,dy,store_image);
 }

 // setarea modului de lucru grafic
 void general_window::my_settings( int bk_color, int color )
 {
   get_settings();  // APEL METODA MOSTENITA ! Salveaza caract. mod grafic

   settextstyle( DEFAULT_FONT, HORIZ_DIR, 1);
   settextjustify( LEFT_TEXT, LEFT_TEXT );

   setfillstyle( SOLID_FILL, bk_color );
   setcolor( color );
 }

 // desenare ferestra
 void general_window::draw_window()
 {
   // afisarea numelui ferestrei
   bar( x,y,dx, y+9 );
   outtextxy( (dx-x)/2 + x - textwidth(window_name)/2, y+9, window_name );

   // desenarea corpului ferestrei
   setcolor( WHITE );
   setfillstyle( SOLID_FILL, BLACK );
   bar( x,y+9,dx,dy );
   rectangle( x,y+10,dx,dy );
   rectangle( x+2,y+12,dx-2,dy-2 );
 }

   // seteaza abscisele si ordonatele colturilor stinga-sus (x,y) si
   // dreapta_jos (dx,dy) la valorile implicite
   void general_window::set_xy( void )
   {
     x  = getmaxx()/2 - 150;
     y  = getmaxy()/2 - 80;
     dx = getmaxx()/2 +150;
     dy = getmaxy()/2 +80;
   }

 int general_window::bad_coord( int x1, int y1, int x2, int y2 )
 {
   if( x1<0 || y1<0 || x2<0 || y2<0 || x2>getmaxx() ||
	    y2>getmaxy() || x1>=x2 || y1>=y2 )         return 1;
   return 0;
 }

 void general_window::create_window( char *win_name, int x1=-1, int y1=-1,
						     int x2=-1, int y2=-1 )
 {
   if(bad_coord(x1,y1,x2,y2)) set_xy();   // Seteaza valorile implicite
   else
   {
     // initializeaza la coordonatele transmise ca parametri
     x  = x1;   y = y1;
     dx = x2;  dy = y2;
   }

   get_image();
   my_settings( RED, BLACK );

   int lung = textwidth( win_name );
   if( dx-x-2*MARGINE>=lung)
     {
       name_size = strlen(win_name)+1;
       window_name = new char[name_size];
       strcpy( window_name, win_name );
     }
     else
     {
       name_size = 2;
       window_name = new char[name_size];
       strcpy(window_name," ");
     }

   draw_window();
   put_settings();   // restaurare optiuni utilizator
 }

 void general_window::destroy_window( void )
 {
   put_settings();
   putimage(x,y,store_image, COPY_PUT);
   delete[image_size] store_image;
   delete[name_size] window_name;
 }
