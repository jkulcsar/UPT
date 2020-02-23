
 typedef struct
	    {
		  int x,y,z;

	    }     t_punct3d;
 typedef struct
	    {
		  float q,w;
	    }     t_punct2d;

 typedef float  t_p_omogen[4];
 typedef t_p_omogen   *t_adresa_p_omogen;

 typedef struct
	    {
		  int np;
		  int *tindex;
	    }  t_poligon3d;

 typedef t_punct3d   *t_adresa_punct3d;
 typedef t_punct2d   *t_adresa_punct2d;
 typedef t_poligon3d *t_adresa_poligon3d;

 typedef struct
	    {
		  char               nume[32];
		  int                ltv;
		  t_adresa_punct3d   *tv;
		  int		     ltp;
		  t_adresa_poligon3d *tp;
	    }  t_obiect3d;

 typedef t_obiect3d  *t_adresa_obiect3d;

