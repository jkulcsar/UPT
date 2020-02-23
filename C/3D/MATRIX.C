
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

 float *inmulteste( float *mat1, int dim1, int dim2,
		    float *mat2, int dim3, int dim4 )
 { int i,j,k;
   float *mat3;

   mat3 = aloca( dim1,dim4 );
   for(i=0;i<dim1;i++)
       for(j=0;j<dim4;j++)
	  {  mat3[i*dim4+j] = 0;
	     for(k=0;k<dim2;k++)
		 mat3[i*dim4+j] = mat3[i*dim4+j] + mat1[i*dim2+k]*mat2[k*dim4+j];
	  }
   return mat3;
 }




