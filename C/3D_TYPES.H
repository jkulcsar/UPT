
 typedef struct
	    {
		  int x,y,z;
	    }  t_punct3d;

 typedef struct
	    {
		  int np;
		  int *tindex;
	    }  t_poligon3d;

 typedef t_punct3d   *t_adresa_punct3d;
 typedef t_poligon3d *t_adresa_poligon3d;

 typedef struct
	    {
		  int                ltv;
		  t_adresa_punct3d   *tv;
		  int			 ltp;
		  t_adresa_poligon3d *tp;
	    }  t_obiect3d;

 typedef t_obiect3d  *t_adresa_obiect3d;

