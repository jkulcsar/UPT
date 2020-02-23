
 #include <stdio.h>
 #include <alloc.h>
 #include <conio.h>
 #include <math.h>

 typedef struct t_complex
	    {
		 float real;
		 float imaginar;
	    } *complex;

 float ModulComplex( complex nr );
 complex PlusComplex(  complex a, complex b );

 float ModulComplex( complex nr )
 {
	  return  sqrt( nr->real*nr->real + nr->imaginar*nr->imaginar );
 }

 complex PlusComplex( complex a, complex b )
 {
    complex rezultat;

    rezultat = (complex) malloc( sizeof(struct t_complex) );
    rezultat->real     = a->real     + b->real;
    rezultat->imaginar = a->imaginar + b->imaginar;
    return rezultat;
 }

 void main(void)
 {
   float   modul;
   complex *tablou;
   int	 i,lung;

   clrscr();
   printf("Lungimea tabloului de numere complexe este :");
   scanf("%d",&lung);
   tablou =  (complex) malloc( lung*sizeof(struct t_complex) );
   for(i=0;i<lung;i++)
	 {
	   tablou[i]->real     = i;
	   tablou[i]->imaginar = i;
	 }
   for(i=0;i<lung;i++)
	 {
	    modul = ModulComplex(tablou[i]);
	    printf("Modul = %8.2f\n",modul);
	 }
   if(tablou!=NULL) free(tablou);
   getch();
 }

