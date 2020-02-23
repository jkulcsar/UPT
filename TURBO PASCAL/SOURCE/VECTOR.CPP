
 #include <iostream.h>
 #include <process.h>
 #include <conio.h>
 #include <stdlib.h>

 #define   nl "\n"

 class  vector
 {
   private:

      float  *pointer;
      int     dimension;
   public:

       vector(int);   // constructor
      ~vector(void);  // destructor

       float insumeaza( void );  // insumeaza elementele vectorului
       void  print(void);
 };

 vector::vector( int nrElem )
 {
   dimension = nrElem;
   pointer   = new float[nrElem];

   if(pointer == NULL )
     {
       cout<<" Memorie insuficienta la alocarea de memorie ! ";
       exit(1);
     }
   for(int i=0;i<nrElem;i++)
       pointer[i] = random(100);
 }

 vector::~vector(void)
 {
   delete[dimension] pointer;
 }

 void vector::print( void )
 {
   clrscr();
   cout<<nl<<nl<<" Sirul este :"<<nl<<nl;
   for(int i=0;i<dimension;i++)
       cout<<nl<<pointer[i];

   getch();
 }

 float vector::insumeaza( void )
 {
   float rezultat = 0;

   for( int i=0;i<dimension;i++)
	rezultat += pointer[i];

   return rezultat;
 }

 void main(void)
 {
   int   lungime;

   clrscr();
   cout<<" Tastati lungimea sirului . . .  ";
   cin>>lungime;

   vector a(lungime);

   a.print();
   cout<<nl<<nl<<" Suma elementelor este : "<<a.insumeaza();

   getch();
 }
