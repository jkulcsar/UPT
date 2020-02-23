
 #include <stdio.h>
 #include <alloc.h>
 #include <conio.h>

 typedef struct
	    { int x;
		 int y;
		 int z;
	    } punct3d;

 typedef struct
	    { int np;
		 int *tindex;
	    } poligon3d;


 typedef struct
	    { char      *nume;        /* Numele   obiectului             */
		 int		  culoare;     /* Culoarea obiectului             */
		 int		  ltv;         /* Lungimea tabloului de vertexuri */
		 int        ltp;         /* Lungimea tabloului de poligoane */
		 punct3d   *tv;          /* Tabloul de vertexuri            */
		 poligon3d *tp;          /* Tabloul de poligoane            */
	    } obiect3d;

 void main(void)
 {
   int i,j;
   FILE *f;
   obiect3d *to;

   f = fopen("datafile.dat","r");
   if(f)
   {
	to = (obiect3d*) malloc( sizeof(obiect3d) );
	fscanf(f,"%s",to[0].nume);
	fscanf(f,"%d",&to[0].culoare);
	fscanf(f,"%d",&to[0].ltv);

	to[0].tv = (punct3d*) malloc(to[0].ltv*sizeof(punct3d));
	for(i=0; i<to[0].ltv; i++)
	   {
		 fscanf(f,"%d",&to[0].tv[i].x);
		 fscanf(f,"%d",&to[0].tv[i].y);
		 fscanf(f,"%d",&to[0].tv[i].z);
	   }
   }
   else printf("\nError opening datafile for reading !");

   clrscr();
   printf("%8s\n", to[0].nume);
   printf("%8d",  to[0].culoare);
   printf("%8d\n",to[0].ltv);
   for(i=0; i<to[0].ltv; i++)
	 {
	    printf("%8d",  to[0].tv[i].x);
	    printf("%8d",  to[0].tv[i].y);
	    printf("%8d\n",to[0].tv[i].z);
	 }

   if(f!=NULL) fclose(f);

   if(to[0].tv!=NULL) free(to[0].tv);
   if(to!=NULL)       free(to);
   getch();
 }