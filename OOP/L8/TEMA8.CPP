  Dindu-se clasa de baza Lista, sa se construiasca doua clase derivate Stiva 
si Coada, folosind functiile virtuale store() (adauga un element in stiva sau coada)
si retrieve() (sterge un element din stiva sau coada).

// creaza o clasa generica de tip lista de intregi
#include <iostream.h>
#include <stdlib.h>
#include <ctype.h>

class LIST 
{
public:
   LIST *first;
   LIST *last;
   LIST *next;
   int valoare;
   LIST () { first=last=next=NULL; }
   virtual void store (int i) = 0;
   virtual int retrieve() = 0;
};

// creaza o lista de tip coada
class QUEUE : public LIST
{
public:
   void store (int i);
   int retrieve();
};

void QUEUE::store (int i)
{
}

int QUEUE::retrieve()
{
}

// creaza o lista de tip stiva
 
class STIVA : public LIST
{
public: 
   void store (int i);
   int retrieve();
};
   
void STIVA::store (int i)
{
}

int STIVA::retrieve()
{
}

void main()
{
  LIST *p;
  STIVA s;
  QUEUE q;
  char ch;
  int i;

  for (i=0;i<10;i++)
  {
    cout << "Stiva sau Coada ? (S/C) : ";
    cin >>ch;
    ch= tolower(ch);
    if (ch=='c') p = &s;
    else p = &q;
    p->store (i);
  }
  cout << "Introduceti T pentru a termina\n";
  for (;;)
  {
    cout <<"sterge din stiva sau din coada ? (S/C):";
    cin >>ch;
    ch = tolower (ch);
    if (ch=='t') break;
    if (ch=='c') p = &q;
    else p = &s;
    cout << p->retrieve() <<'\n';
  }
  cout << '\n';

}

