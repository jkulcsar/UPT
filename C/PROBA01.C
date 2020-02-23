
 #include <stdio.h>
 #include <alloc.h>
 #include <conio.h>

 typedef struct
	    { int x,y,z;
	    } punct3d;

 void main(void)
 {    int     i;
	 int     ltv;
	 punct3d *tv;



	clrscr();
	printf("Lungimea tabloului de vertexuri este ="); scanf("%d",&ltv);
	tv = (punct3d*) malloc( ltv*sizeof(punct3d) );
	clrscr();
	for(i=0;i<ltv;i++)
	   {
		 printf("\ntv[%d].x = ",i); scanf("%d",&tv[i].x);
		 printf("\ntv[%d].y = ",i); scanf("%d",&tv[i].y);
		 printf("\ntv[%d].z = ",i); scanf("%d",&tv[i].z);
	   }
	clrscr();
	for(i=0;i<ltv;i++)
	   {
		printf("tv[%d].x = %d\n",i,tv[i].x);
		printf("tv[%d].y = %d\n",i,tv[i].y);
		printf("tv[%d].z = %d\n",i,tv[i].z);
	   }
	if(tv!=NULL) free(tv);
	getch();
 }