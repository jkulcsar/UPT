#include <iostream.h>
#include <process.h>

class CLASA
  {
    int i;
    CLASA *pCls;
   public:
    CLASA();
    ~CLASA();
  };

CLASA::CLASA()
 {
  // pCls = new CLASA;
  // EROARE:s-ar provoca un apel recursiv infinit al constructorului

  // urmeaza varianta corecta de alocare a memoriei pentru
  // entitati "pointate" de membri ai unui obiect
  
  pCls = (CLASA *) new char[sizeof(CLASA)];

  // s-au mai alocat 6 octeti pentru obiectul pointat de "pCls"

  i = 0;
  pCls->i = 6;
 }

CLASA::~CLASA()
 {
  // delete pCls;
  // EROARE:s-ar provoca un apel recursiv infinit al destructorului

  // urmeaza varianta corecta de eliberare a memoriei necesare
  // unor entitati "pointate" de membri unui obiect
  
     delete[sizeof(CLASA)] (char *) pCls;

  // s-au eliberat cei 6 octeti la care pointa "pCls"

 }

void main()
 {
  CLASA *pC;

  pC = new CLASA;	// se aloca 6 octeti pentru obiectul nou creat
  delete pC;		// se elibereaza cei 6 octeti ocupati de obiect
 }
