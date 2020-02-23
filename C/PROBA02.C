
 #include <stdio.h>
 #include <alloc.h>
 #include <conio.h>
 #include <fcntl.h>
 #include "3d_types.h"

 void main(void)
 {   int      i,j,cltp;
	obiect3d *to;
	FILE     *f;
	char		ch='p';

	f = fopen("proba02.dat","r");
	if(f)
	{
	   to = (obiect3d*) malloc( sizeof(obiect3d) );
	   fscanf(f,"%s", to[0].nume);
	   fscanf(f,"%d",&to[0].ltv);
	   to[0].tv = (punct3d*) malloc( to[0].ltv*sizeof(punct3d) );
	   for(i=0;i<to[0].ltv;i++)
	   {
		 fscanf(f,"%d",&to[0].tv[i].x);
		 fscanf(f,"%d",&to[0].tv[i].y);
		 fscanf(f,"%d",&to[0].tv[i].z);
	   }

	   cltp = 0;
	   while(!feof(f))
	   {
		  to[0].tp = (poligon3d*) malloc( sizeof(poligon3d) );
		  fscanf(f,"%c",ch);
		  while(ch=='p')
		  {
			cltp++ ;
			to[0].tp=(poligon3d*) realloc(to[0].tp,cltp*sizeof(poligon3d));
			fscanf(f,"%d",&to[0].tp[cltp-1].np);
			to[0].tp[cltp-1].index = (int*) malloc(to[0].tp[cltp-1].np*sizeof(int));
			for(i=0;i<to[0].tp[cltp-1].np;i++)
			   fscanf(f,"%d",&to[0].tp[cltp-1].index[i]);
		  }
		  to[0].ltp = cltp;
	   }

	   if(f!=NULL) fclose(f);

	   clrscr();
	   printf("%s\n", to[0].nume);
	   printf("%4d\n",to[0].ltv);
	   for(i=0;i<to[0].ltv;i++)
	   {
		 printf("%4d",  to[0].tv[i].x);
		 printf("%4d",  to[0].tv[i].y);
		 printf("%4d\n",to[0].tv[i].z);
	   }
	   printf("%4d\n",to[0].ltp);
	   for(i=0;i<to[0].ltp;i++)
	   {
		 printf("%4d",to[0].tp[i].np);
		 for(j=0;j<to[0].tp[i].np;j++)
			printf("%4d",to[0].tp[i].index[j]);
	   }
	}
	else printf("Error opening file for reading !");



	if(to[0].tv!=NULL)		         free(to[0].tv);

	for(i=0;i<to[0].ltp;i++)
		 if(to[0].tp[i].index!=NULL) free(to[0].tp[i].index);
	if(to[0].tp!=NULL)                free(to[0].tp);
	if(to!=NULL)                      free(to);

	getch();
 }