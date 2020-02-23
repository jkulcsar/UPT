
 #include <stdio.h>
 #include <alloc.h>
 #include <conio.h>
 #include "matrixop.h"

 float *aloca( int dim1, int dim2 )
 { float *rez;

   rez = (float*) malloc( dim1*dim2*sizeof(float) );
   return rez;
 }

 void atribuie_val( float *mat, int dim1, int dim2 )
 { float i,j;

   for(i=0;i<dim1;i++)
       for(j=0;j<dim2;j++)
	   mat[i*dim2+j] = (i+1)*(j+1);
 }

 void afiseaza( float *mat, int dim1, int dim2 )
 { int i,j;

   for(i=0;i<dim1;i++)
      {  printf("\n");
	 for(j=0;j<dim2;j++)
	     printf("%8.2f",mat[i*dim2+j]);
      }
   printf("\n");
 }

 float *inmulteste( float *x, int dim1, int dim2,
		    float *y, int dim3, int dim4 )
 { int i,j,k;
   float *z;

   z = aloca( dim1,dim4 );
   for(i=0;i<dim1;i++)
       for(j=0;j<dim4;j++)
	  {  z[i*dim4+j] = 0;
	     for(k=0;k<dim2;k++)
		 z[i*dim4+j] = z[i*dim4+j] + x[i*dim2+k]*y[k*dim4+j];
	  }
   return z;
 }

 void main(void)
 {    float *a,*b,*c;
      int lin1,col1,lin2,col2;

      do
      {  clrscr();
	 printf("\nLinii1   = "); scanf("%d",&lin1);
	 printf("\nColoane1 = "); scanf("%d",&col1);
	 printf("\nLinii2   = "); scanf("%d",&lin2);
	 printf("\nColoane2 = "); scanf("%d",&col2);
	 clrscr();

	 a = aloca(lin1,col1);
	 b = aloca(lin2,col2);
	 c = aloca(lin1,col2);

	 atribuie_val(a,lin1,col1);
	 atribuie_val(b,lin2,col2);
	 c = inmulteste( a,lin1,col1, b,lin2,col2 );

	 afiseaza(a,lin1,col1);
	 afiseaza(b,lin2,col2);
	 afiseaza(c,lin1,col2);

	 if (a!=NULL) free(a);
	 if (b!=NULL) free(b);
	 if (c!=NULL) free(c);

	 printf("\nAny key continues . . . Press 'q' to quit . . . ");
      }

 while(getch()!='q');
 }



