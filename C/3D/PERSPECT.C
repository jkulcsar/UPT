
 #include <stdio.h>
 #include <alloc.h>
 #include "tipuri3d.h"
 #include "matrix.h"
 #include "perspect.h"

 t_adresa_punct2d  *proiecteaza_obiectul3d( int nr_ord,
					   t_adresa_obiect3d *tablou )
 {
    int   ii,jj,kk;
    float *pomog;
    float *persp;
    float *pout;
    t_adresa_punct2d  *ttqw;
    int   z0;

    pomog = aloca(4,1);
    persp = aloca(4,4);
    pout  = aloca(4,1);
    z0    = 2000;

    ttqw = (t_adresa_punct2d*) malloc( tablou[nr_ord]->ltv*sizeof(t_adresa_punct2d));
    for(ii=0;ii<tablou[nr_ord]->ltv;ii++)
       ttqw[ii] = (t_punct2d*) malloc( sizeof(t_punct2d) );

    for(ii=0;ii<tablou[nr_ord]->ltv;ii++)
       {
	   pomog[0*1+0] = tablou[nr_ord]->tv[ii]->x;
	   pomog[1*1+0] = tablou[nr_ord]->tv[ii]->y;
	   pomog[2*1+0] = tablou[nr_ord]->tv[ii]->z;
	   pomog[3*1+0] = 1;

	   for(jj=0;jj<4;jj++)
	      for(kk=0;kk<4;kk++)
	      {
		     persp[jj*4+kk] = 0;
		     if(jj==0)
		       {  if(kk==0)
			  persp[jj*4+kk] = z0/(z0-tablou[nr_ord]->tv[ii]->z);
		       }
		     if(jj==1)
		       {  if(kk==1)
			  persp[jj*4*kk] = z0/(z0-tablou[nr_ord]->tv[ii]->z);
		       }
		     if(jj==3)
		       {  if(kk==3)
			  persp[jj*4*kk] = 1;
		       }
	      }

	   pout = inmulteste( persp,4,4, pomog,4,1 );

	   ttqw[ii]->q = pout[0*1+0];
	   ttqw[ii]->w = pout[1*1+0];
       }
       if(pomog!=NULL) free(pomog);
       if(persp!=NULL) free(persp);
       if(pout !=NULL) free(pout );

       return ttqw;
 }
