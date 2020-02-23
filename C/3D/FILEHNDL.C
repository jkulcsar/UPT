
 #include <stdio.h>
 #include <conio.h>
 #include <alloc.h>
 #include "tipuri3d.h"

 void afiseaza_tablou_obiecte3d( t_adresa_obiect3d *tablou )
 {
	 int i,j,k,lung=1;

	 clrscr();
	 printf("Lungimea tabloului de obiecte este : %d ",lung);
	 for(i=0;i<lung;i++)
	    {
		  clrscr();
		  printf("Pentru obiectul numarul : %d \n",i);
		  printf("Numele obiectului  este : %s \n ",tablou[i]->nume);
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
			  if(tablou[i]->tv[j]!=NULL)  free(tablou[i]->tv[j]);
		   for(j=0;j<tablou[i]->ltp;j++)
			 {
			    if(tablou[i]->tp[j]->tindex!=NULL) free(tablou[i]->tp[j]->tindex);
			    if(tablou[i]->tp[j]!=NULL) free(tablou[i]->tp[j]);
			 }
		   if(tablou[i]->tp!= NULL) free(tablou[i]->tp);
		   if(tablou[i]->tv!= NULL) free(tablou[i]->tv);
		   if(tablou[i]!=NULL)  free(tablou[i]);
		}
	  if(tablou!=NULL) free(tablou);
 }

 t_adresa_obiect3d *citeste_tablou_obiecte3d( void )
 {
	 int i,j,k, lung ;
	 t_adresa_obiect3d *tablou;
	 FILE *f;

      f = fopen("DATAFILE.DAT","r");
      if(f)
       {
	 fscanf(f,"%d",&lung);
	 tablou = (t_adresa_obiect3d*) malloc(lung*sizeof(t_adresa_obiect3d));
 	 for(i=0;i<lung;i++)
		tablou[i] = (t_obiect3d*) malloc(sizeof(t_obiect3d));

	 clrscr();
	 for(i=0;i<lung;i++)
	    {
		  fscanf(f,"%s",&tablou[i]->nume);
		  fscanf(f,"%d", &tablou[i]->ltv);
		  tablou[i]->tv  = (t_adresa_punct3d*)  malloc(tablou[i]->ltv*sizeof(t_adresa_punct3d));
		  for(j=0;j<tablou[i]->ltv;j++)
			{
			   tablou[i]->tv[j]  = (t_punct3d*) malloc(sizeof(t_punct3d));
			   fscanf(f,"%d",&tablou[i]->tv[j]->x);
			   fscanf(f,"%d",&tablou[i]->tv[j]->y);
			   fscanf(f,"%d",&tablou[i]->tv[j]->z);
			}
		  fscanf(f,"%d",&tablou[i]->ltp);
		  tablou[i]->tp = (t_adresa_poligon3d*) malloc(tablou[i]->ltp*sizeof(t_adresa_poligon3d));
		  for(j=0;j<tablou[i]->ltp;j++)
			{
			   tablou[i]->tp[j] = (t_poligon3d*) malloc(sizeof(t_poligon3d));
			   fscanf(f,"%d",&tablou[i]->tp[j]->np);
			   tablou[i]->tp[j]->tindex = (int*) malloc(tablou[i]->tp[j]->np*sizeof(int));
			   for(k=0;k<tablou[i]->tp[j]->np;k++)
				    fscanf(f,"%d",&tablou[i]->tp[j]->tindex[k]);
			}
	    }
       fclose(f);
       }
       else printf(" Error opening file for reading ! ");
       return tablou;
 }


