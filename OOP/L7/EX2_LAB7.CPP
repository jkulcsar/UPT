#include <iostream.h>
#include <process.h>
#include <conio.h>

class test
{
int i;
public:
test(void *pointer = NULL)
{
	if(this == NULL)
	{
		this = (test *)pointer;
		i = 10;
	}
	else
	{
	     // this = this;
	     i=-10;
	}
}

};

class BAZA
{
public :
	BAZA(void *pointer = NULL)
	{
	cout<<"\n\t\t La apelul constructorului BAZA() this = "<<this;
	if(this==NULL)
	  if(pointer != NULL)
		 this = (BAZA *) pointer;
	  else
		 {
		 cout<<"\n EROARE : in \"BAZA() \" se forteaza this = NULL ";
		 exit(1);
		 }
	else
	  this = this;
	}
};

class DERIVAT : public BAZA
{
public:
	DERIVAT(void *pointer = NULL)
	{
	  cout<<"\n\t\t LA apelul constructorului DERIVAT() this = "<<this;
	  if(this==NULL)
		 if(pointer != NULL)
			this = (DERIVAT *) pointer;
		 else
			{
			cout<<"\n EROARE : in \"DERIVAT() \" se forteaza this = NULL ";
			exit(1);
			}
	  else
			this = this;
	 cout<<"\n\t\t La iesirea din DERIVAT() this = "<<this<<"\n\n";
  }
};

void main(void)
{
  clrscr();
  test t1;
  test *t = new test(&t1);
  cout<< "OBIECTE CREATE FARA ALOCARE DINAMICA DE MEMORIE : \n\n";
  cout<<"\tBAZA";
  BAZA b1;
  cout<<"\n\tDERIVAT\n";
  DERIVAT d1;
  cout<< "OBIECTE CREATE PRIN ALOCARE DINAMICA DE MEMORIE : \n\n";
  cout<<"\tBAZA";
  new BAZA(&b1);

  cout<<"\n\tDERIVAT\n";
  new DERIVAT(&d1);

  // new BAZA(NULL);
  // new BAZA();
  // new DERIVAT(NULL);
  // new DERIVAT();
}


