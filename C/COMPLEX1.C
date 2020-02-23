
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
   complex element;


   do
   {
	 clrscr();
	 element =   malloc( sizeof(struct t_complex) );
	 printf("Real     = ");scanf("%f",&element->real);
	 printf("Imaginar = ");scanf("%f",&element->imaginar);
	 modul = ModulComplex(element);
	 printf("\nModul=%8.2f\n",modul);
	 if(element!=NULL) free(element);
	 printf("\nAny key continues . . . 'q' to quit . . . ");
   }
   while(getch()!='q');
 }

