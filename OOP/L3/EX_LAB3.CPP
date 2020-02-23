#include <iostream.h>

class exemplu
{
	int i;
  public:
	static int contor;	// variabila membru statica

	void inc(void)		{	i++;		}
	void inc_contor(void)	{	contor++;	}
	void init(void)		{	i=0;		}

	static void functie(exemplu *);	// metoda statica
} ob1, ob2, ob3;

int exemplu::contor=0; 	// initializarea variabilei statice

void exemplu::functie(exemplu *ptrEx)
{
// i+=76 // EROARE nu se cunoaste obiectul care il poseda pe i
	ptrEx->i++;	// CORECT
	contor++;	// CORECT
}

void main(void)
{
	ob1.init();
	ob2.init();
	ob3.init();

	ob1.inc();
	ob2.inc();
	ob3.inc();

	ob1.functie(&ob1);	  // CORECT
	exemplu::functie(&ob2);	// CORECT

//   functie();	// INCORECT (in afara de cazul in care exista o
						// procedura ne-membru cu acest nume

	ob1.inc_contor();
	ob2.inc_contor();
	ob3.inc_contor();

	exemplu::contor+=6;
	cout<<"valoarea contorului este: ";
	cout<<exemplu::contor;
}