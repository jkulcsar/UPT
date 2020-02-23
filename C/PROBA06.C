
 #include <stdio.h>
 #include <conio.h>
 #include <alloc.h>
 #include "tipuri3d.h"

 void afiseaza_tablou_obiecte3d( t_adresa_obiect3d *tablou );
 void dealoca_tablou_obiecte3d(  t_adresa_obiect3d *tablou );
 t_adresa_obiect3d *citeste_tablou_obiecte3d(  void );

 void afiseaza_tablou_obiecte3d( t_adresa_obiect3d *tablou )
 {
	 int i,j,k,lung = 1;

	 clrscr();
	 for(i=0;i<lung;i++)
	    {
		  clrscr();
		  printf("Pentru obiectul numarul %d\n ",i);
		  printf("%4d\n",tablou[i]->ltv);
		  for(j=0;j<tablou[i]->ltv;j++)
			{
			   printf("%8d",tablou[i]->tv[j]->x);
			   printf("%8d",tablou[i]->tv[j]->y);
			   printf("%8d",tablou[i]->tv[j]->z);
			   printf("\n");
			}
		  printf("%4d\n",tablou[i]->ltp);
		  for(j=0;j<tablou[i]->ltp;j++)
			{
			   printf("%8d",tablou[i]->tp[j]->np);
			   for(k=0;k<tablou[i]->tp[j]->np;k++)
				  printf("%8d",tablou[i]->tp[j]->tindex[k]);
			   printf("\n");
			}
	    }
 }

 void dealoca_tablou_obiecte3d( t_adresa_obiect3d *tablou )
 {
	  int i,j,lung = 1;

	  for(i=0;i<lung;i++)
		{
		   for(j=0;j<tablou[i]->ltv;j++)
			  if(tablou[i]->tv[j]!=NULL) free(tablou[i]->tv[j]);
		   for(j=0;j<tablou[i]->ltp;j++)
			 {
			    if(tablou[i]->tp[j]->tindex!=NULL) free(tablou[i]->tp[j]->tindex);
			    if(tablou[i]->tp[j]!=NULL) free(tablou[i]->tp[j]);
			 }
		   if(tablou[i]->tp!=NULL) free(tablou[i]->tp);
		   if(tablou[i]->tv!=NULL) free(tablou[i]->tv);
		   if(tablou[i]!=NULL)  free(tablou[i]);
		}
	  if(tablou!=NULL) free(tablou);
 }

 t_adresa_obiect3d *citeste_tablou_obiecte3d( void )
 {
	 int i,j,k, lung = 1;
	 t_adresa_obiect3d *tablou;

	 tablou = (t_adresa_obiect3d*) malloc(lung*sizeof(t_adresa_obiect3d));
 	 for(i=0;i<lung;i++)
		tablou[i] = (t_obiect3d*) malloc(sizeof(t_obiect3d));

	 clrscr();
	 for(i=0;i<lung;i++)
	    {
		  clrscr();
		  printf("Lungimea tabloului de vertexuri (ltv) pentru obiectul %d : ",i);
		  scanf("%d", &tablou[i]->ltv);
		  printf("Lungimea tabloului de poligoane (ltp) pentru obiectul %d : ",i);
		  scanf("%d",&tablou[i]->ltp);
	    }

	 clrscr();
	 for(i=0;i<lung;i++)
	    {
		  printf("Pentru obiectul %d\n",i);
		  tablou[i]->tv = (t_adresa_punct3d*)  malloc(tablou[i]->ltv*sizeof(t_adresa_punct3d));
		  tablou[i]->tp = (t_adresa_poligon3d*) malloc(tablou[i]->ltp*sizeof(t_adresa_poligon3d));
		  for(j=0;j<tablou[i]->ltv;j++)
			{
			   tablou[i]->tv[j] = (t_punct3d*) malloc(sizeof(t_punct3d));
			   printf("x = "); scanf("%d",&tablou[i]->tv[j]->x);
			   printf("y = "); scanf("%d",&tablou[i]->tv[j]->y);
			   printf("z = "); scanf("%d",&tablou[i]->tv[j]->z);
			}
		  for(j=0;j<tablou[i]->ltp;j++)
			{
			   tablou[i]->tp[j] = (t_poligon3d*) malloc(sizeof(t_poligon3d));
			   printf("np = "); scanf("%d",&tablou[i]->tp[j]->np);
			   tablou[i]->tp[j]->tindex = (int*) malloc(tablou[i]->tp[j]->np*sizeof(int));
			   for(k=0;k<tablou[i]->tp[j]->np;k++)
				 {
				    printf("tindex[%d] = ",k);
				    scanf("%d",&tablou[i]->tp[j]->tindex[k]);
				 }
			}
	    }
	 return tablou;
 }

 void main(void)
 {
	 t_adresa_obiect3d  *to;

	 to = citeste_tablou_obiecte3d();
	 afiseaza_tablou_obiecte3d( to );
	 dealoca_tablou_obiecte3d(  to );

	 printf("\n Press any key to terminate  . . . ");
	 getch();
 }


