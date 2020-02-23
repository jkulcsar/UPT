
 #include <stdio.h>
 #include <conio.h>
 #include <alloc.h>
 #include "3d_types.h"

 void main(void)
 {
	 t_adresa_obiect3d  *to;
	 int			     i,j,k,lung = 1;  /* Vom avea trei obiecte */

	 to = (t_adresa_obiect3d*) malloc(lung*sizeof(t_adresa_obiect3d));
	 for(i=0;i<lung;i++)
		to[i] = (t_obiect3d*) malloc(sizeof(t_obiect3d));

	 clrscr();
	 for(i=0;i<lung;i++)
	    {
		  clrscr();
		  printf("Lungimea tabloului de vertexuri (ltv) pentru obiectul %d : ",i);
		  scanf("%d", &to[i]->ltv);
		  printf("Lungimea tabloului de poligoane (ltp) pentru obiectul %d : ",i);
		  scanf("%d",&to[i]->ltp);
	    }

	 clrscr();
	 for(i=0;i<lung;i++)
	    {
		  printf("Pentru obiectul %d\n",i);
		  to[i]->tv = (t_adresa_punct3d*)  malloc(to[i]->ltv*sizeof(t_adresa_punct3d));
		  to[i]->tp = (t_adresa_poligon3d*) malloc(to[i]->ltp*sizeof(t_adresa_poligon3d));
		  for(j=0;j<to[i]->ltv;j++)
			{
			   to[i]->tv[j] = (t_punct3d*) malloc(sizeof(t_punct3d));
			   printf("x = "); scanf("%d",&to[i]->tv[j]->x);
			   printf("y = "); scanf("%d",&to[i]->tv[j]->y);
			   printf("z = "); scanf("%d",&to[i]->tv[j]->z);
			}
		  for(j=0;j<to[i]->ltp;j++)
			{
			   to[i]->tp[j] = (t_poligon3d*) malloc(sizeof(t_poligon3d));
			   printf("np = "); scanf("%d",&to[i]->tp[j]->np);
			   to[i]->tp[j]->tindex = (int*) malloc(to[i]->tp[j]->np*sizeof(int));
			   for(k=0;k<to[i]->tp[j]->np;k++)
				 {
				    printf("tindex[%d] = ",k);
				    scanf("%d",&to[i]->tp[j]->tindex[k]);
				 }
			}
	    }

	 clrscr();
	 for(i=0;i<lung;i++)
	    {
		  clrscr();
		  printf("Pentru obiectul numarul %d\n ",i);
		  printf("%4d\n",to[i]->ltv);
		  for(j=0;j<to[i]->ltv;j++)
			{
			   printf("%8d",to[i]->tv[j]->x);
			   printf("%8d",to[i]->tv[j]->y);
			   printf("%8d",to[i]->tv[j]->z);
			   printf("\n");
			}
		  printf("%4d\n",to[i]->ltp);
		  for(j=0;j<to[i]->ltp;j++)
			{
			   printf("%8d",to[i]->tp[j]->np);
			   for(k=0;k<to[i]->tp[j]->np;k++)
				  printf("%8d",to[i]->tp[j]->tindex[k]);
			   printf("\n");
			}
		  printf("\n Any key continues  . . . ");
		  getch();
	    }

	  for(i=0;i<lung;i++)
		{
		   for(j=0;j<to[i]->ltv;j++)
			  if(to[i]->tv[j]!=NULL) free(to[i]->tv[j]);
		   for(j=0;j<to[i]->ltp;j++)
			 {
			    if(to[i]->tp[j]->tindex!=NULL) free(to[i]->tp[j]->tindex);
			    if(to[i]->tp[j]!=NULL) free(to[i]->tp[j]);
			 }
		   if(to[i]->tp!=NULL) free(to[i]->tp);
		   if(to[i]->tv!=NULL) free(to[i]->tv);
		   if(to[i]!=NULL)  free(to[i]);
		}
	  if(to!=NULL) free(to);
 }


