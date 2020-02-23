#include <iostream.h>
#define MAX_NUME 25

typedef struct _persoana
{
  char nume[MAX_NUME], prenume_1[MAX_NUME];
  char prenume_2[MAX_NUME], initiala_tatalui;
  int virsta, cod;
  float inaltime;
} persoana;
persoana sir_persoane[20];

void tipareste_persoana(persoana& p)
{
  cout << p.nume << " " << p.initiala_tatalui << ". " << p.prenume_1 << " " 
       << p.prenume_2 << "\n";
  cout << " virsta :  " << p.virsta << " , cod = " << p.cod << ", inaltimea = "
		 << p.inaltime << "\n\n";
}

void actualizeaza_virsta(persoana& refPersoana)
{
  refPersoana.virsta++;
}

persoana& cauta_persoana_de_50_ani(void)
{
  for(int i=0; i<20;i++)
	 if(sir_persoane[i].virsta == 50)
	return sir_persoane[i];
}

void main(void)
{
  cout << "\n\n\n\t\tProgram demonstrativ : REFERINTE\n\n";
  persoana James_Bond = {"Bond","James","",'K',40,007,1.88};

  persoana& ref_pers1 = James_Bond;
  tipareste_persoana(ref_pers1);

  persoana Ion_Ion = James_Bond;
  persoana& ref_pers2 = Ion_Ion;
  tipareste_persoana(ref_pers2);
  
  actualizeaza_virsta(ref_pers2);
  tipareste_persoana(ref_pers2);

  tipareste_persoana(James_Bond);
  persoana aa = {"Iftode","Ilie","",'K',40,007,1.88};

  for(int i=0; i<20; i++)
  {
    persoana& ref_pers3 = sir_persoane[i];
    sir_persoane[i] = aa;
    for(int j=-1; j<i; j++)
	actualizeaza_virsta(ref_pers3);
  }
  cout << "\n\nPersoana de 50 de ani : \n";
  tipareste_persoana(cauta_persoana_de_50_ani());  
}