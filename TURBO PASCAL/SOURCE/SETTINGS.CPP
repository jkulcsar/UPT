
  #include <graphics.h>

  #include "settings.dat"

  // functia put_settings() restaureaza atributele modului de lucru
  // grafic salvate anterior

  void settings::put_settings( void )
  {
    settextstyle( txt.font, txt.direction, txt.charsize );
    settextjustify( txt.horiz, txt.vert );

    setfillstyle( fll.pattern, fll.color );

    setcolor( cul );
    setbkcolor( bkcul );
  }


  // functia get_settings() salveaza atributele curente ale modului grafic

  void settings::get_settings( void )
  {
    gettextsettings( &txt );
    getfillsettings( &fll );
    cul   = getcolor();
    bkcul = getbkcolor();
  }
