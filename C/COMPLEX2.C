
 #include <stdio.h>
 #include <alloc.h>
 #include <conio.h>
 #include <math.h>

 typedef struct
	    {
		 float real;
		 float imaginar;
	    } t_complex;

 

 float ModulComplex( t_complex *nr );
 t_complex *PlusComplex(  t_complex *a, t_complex *b );

 float ModulComplex( t_complex *nr )
 {
	  return  sqrt( nr->real*nr->real + nr->imaginar*nr->imaginar );
 }

 t_complex *PlusComplex( t_complex *a, t_complex *b )
 {
    t_complex *rezultat;

    rezultat = (t_complex*) malloc( sizeof(t_complex) );
    rezultat->real     = a->real     + b->real;
    rezultat->imaginar = a->imaginar + b->imaginar;
    return rezultat;
 }

 void main(void)
 {
   int     i,lung = 7;
   typedef t_complex *t_adresa;
   t_adresa  *tablou;

   do
   {
	 tablou = (t_adresa*) malloc( lung*sizeof(t_adresa) );
	 clrscr();
	 for(i=0;i<lung;i++)
		tablou[i] = (t_complex*)  malloc( sizeof(t_complex) );
	 for(i=0;i<lung;i++)
	    {
		  printf("Real     = ");scanf("%f",&tablou[i]->real);
		  printf("Imaginar = ");scanf("%f",&tablou[i]->imaginar);
	    }
	 clrscr();
	 for(i=0;i<lung;i++)
		printf("Modul    =%8.2f\n",ModulComplex(tablou[i]));
	 for(i=0;i<lung;i++)
		if(tablou[i]!=NULL) free(tablou[i]);
	 if(tablou[i]!=NULL) free(tablou);
	 printf("\nAny key continues . . . 'q' to quit . . . ");
   }
   while(getch()!='q');
 }

