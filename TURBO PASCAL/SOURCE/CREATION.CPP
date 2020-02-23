
 #include <iostream.h>
 #include <process.h>
 #include <string.h>
 #include <alloc.h>
 #include <conio.h>

 enum  mod_de_creare
       {
	   OBIECT_CREAT_STATIC,
	   OBIECT_CREAT_DINAMIC_FARA_A_ALOCA_MEMORIE,
	   OBIECT_CREAT_DINAMIC_CU_ALOCARE_DE_MEMORIE
       };

 class persoana
       {
	 private:
	    char  nume[20];
	    char  a[1000];
	    int   virsta;

	    mod_de_creare  indicator;

	 public:
	    persoana( mod_de_creare,  char *, int, persoana *);
	    ~persoana(void);
       };

 // creaza in unul din cele 3 moduri posibile un "persoana"

 persoana::persoana( mod_de_creare modCreare,
		     char *pNume, int _virsta,  persoana *pPersoana=NULL )
 {
   switch(modCreare)
   {
     case OBIECT_CREAT_STATIC :
	  // initializari
	  if(this!=NULL)
	    {
	      strcpy(nume,pNume);
	      virsta = _virsta;
	    }
	    else
	    {
	      cout<<" Eroare : obiect static cu this == NULL";
	      exit(1);
	    }
     break;

     case OBIECT_CREAT_DINAMIC_FARA_A_ALOCA_MEMORIE :
	  if(this == NULL )
	    if(pPersoana!=NULL)
	      {
		this = pPersoana;

		// initializari
		strcpy(nume,pNume);
		virsta = _virsta;
	      }
	      else
	      {
		cout<<" Nu exista 'persoana' la care sa";
		cout<<" se faca 'legatura' (referirea) !! ";
		cout<<" Eroare : this ramine NULL ! ";
		exit(1);
	      }
	    else
	    {
	      cout<<" Constructorul nu a fost apelat de un 'NEW' !";
	      cout<<" Eroare : this nu este NULL !";
	      exit(1);
	    }
     break;

     case OBIECT_CREAT_DINAMIC_CU_ALOCARE_DE_MEMORIE :
	  if(this==0)
	    {
	      // Urmeaza alocarea memoriei necesare si
	      // testarea corectitudinii acestei operatii

	      this = (persoana *) new char[sizeof(persoana)];
	      if(this==NULL)
		{
		  cout<<" Memorie insuficienta la alocarea de memorie !";
		  exit(1);
		}

	      // initializari
	      strcpy(nume,pNume);
	      virsta = _virsta;
	    }
	    else
	    {
	      cout<<" Constructorul nu a fost apelat din 'NEW' !!";
	      cout<<" Eroare : this nu este NULL !";
	      exit(1);
	    }
     break;

     indicator = modCreare;
   }
 }

 persoana::~persoana( void )
 {
   // Nu se permite eliberarea memoriei decit pentru
   // obiectele la care nu exista "referinte".
   // In cazul obiectelor "referite" de alti pointeri,
   // se scurtcircuiteaza mecanismul de eliberare a memoriei
   // prin "this = NULL".

   if(indicator == OBIECT_CREAT_DINAMIC_FARA_A_ALOCA_MEMORIE)
      this = NULL;
 }

 unsigned long m;

 void action(void)
 {
   persoana  p1(OBIECT_CREAT_STATIC, "Janos",21);
   persoana *p2 = new persoana(OBIECT_CREAT_DINAMIC_FARA_A_ALOCA_MEMORIE,
			       "p",34, &p1);
   persoana *p3 = new persoana(OBIECT_CREAT_DINAMIC_CU_ALOCARE_DE_MEMORIE,
			       "V",55);
   persoana *p4 = new persoana(OBIECT_CREAT_DINAMIC_FARA_A_ALOCA_MEMORIE,
			       "A",43, p3 );
   persoana *p5 = new persoana(OBIECT_CREAT_DINAMIC_CU_ALOCARE_DE_MEMORIE,
			       "o", 79 );

   m = farcoreleft();
   cout<<" \nMemoria libera initiala : "<<m<<" bytes ";
   getch();

   delete p2;
   m = farcoreleft();
   cout<<" \nMemoria libera dupa ce s-a incercat stergerea lui p2 : "<<m<<" bytes ";
   getch();

   delete p3;
   m = farcoreleft();
   cout<<" \nMemoria libera dupa ce s-a incercat stergerea lui p3 : "<<m<<" bytes ";
   getch();

   delete p4;
   m = farcoreleft();
   cout<<" \nMemoria libera dupa ce s-a incercat stergerea lui p4 : "<<m<<" bytes ";
   getch();

   delete p5;
   m = farcoreleft();
   cout<<" \nMemoria libera dupa ce s-a sters p5 : "<<m<<" bytes ";
   getch();
 }

 void main(void)
 {
   clrscr();
   action();
 }