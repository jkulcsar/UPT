#include <iostream.h>
#include <process.h>

class CLASA
  {
    int i;
    CLASA *pCls;
   public:
    CLASA();
  };

CLASA::CLASA()
 {
  if(this != NULL)
    {
    cout << "EROARE : constructorul nu a fost apelat cu NEW";
    exit(1);
    }

  // se va aloca memoria necesara pastrarii a doua obiecte de tip "CLASA"
  // "this" va pointa la primul dintre ele

  this = (CLASA *) new char[2*sizeof(CLASA)];
  pCls = this+1,	// pCls va pointa la cel de-al doilea obiect 
			// de tip "CLASA"   

  i = 0;		// se seteaza this->i
  pCls->i = 5;		// se seteaza pCls->i
 }

void main()
 {
  CLASA *pC;

  pC = new CLASA;	// la apelul constructorului se vor aloca 12 octeti
  delete pC;		// se vor elibera toti cei 12 octeti alocati
 }
