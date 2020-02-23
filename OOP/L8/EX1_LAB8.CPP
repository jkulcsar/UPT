#include <iostream.h>

class BAZA
{
  protected :
	 int valoare;
  public :
	 void set_val(int a)
	 {
		valoare = a;
	 }
	 virtual void tipareste_valoare(void)
	 {
		cout<<"Element BAZA cu VALOARE = "<<valoare<<"\n";
	 }
};

class DERIVAT_1 : public BAZA
{
  public :
	 void tipareste_valoare(void)
	 {
		cout<<"Element DERIVAT_1 cu VALOARE = "<<valoare<<"\n";
	 }
};

class DERIVAT_2 : BAZA
{
  public :
	 BAZA :: set_val;

	 void tipareste_valoare(void)
	 {
		cout<<"Element DERIVAT_2 cu VALOARE = "<<valoare<<"\n";
	 }
};

class LISTA_ETEROGENA
{
	BAZA *pB;
 public :
	void set(BAZA *p)
	{
	  pB = p;
	}

	void tipareste_valoare(void)
	{
	  pB->tipareste_valoare();
	}
};

void main(void)
{
  BAZA a[2];
  DERIVAT_1 b1;
  DERIVAT_2 b2;
  LISTA_ETEROGENA p[4];

  a[0].set_val(1);
  a[1].set_val(2);
  b1.set_val(3);
  b2.set_val(4);

  p[0].set(&a[0]);
  p[1].set(&b1);
  p[2].set((BAZA *) &b2);
  p[3].set(&a[1]);

  for(int i=0; i < 4; i++)
	 p[i].tipareste_valoare();
}