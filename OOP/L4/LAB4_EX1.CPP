#include<iostream.h>		//lista FIFO de nmax numere intregi
class fifo{
	int nmax;		//dimensiunea listei
	int *tab;		//adresa tabloului listei
	int ncrt;		//numarul curent de elemente din lista
	int prim;		//indexul primului element din lista

public:
	fifo(int);		//constructor 1

	fifo();			//constructor 2

	~fifo();		//destructor

	int adaug(int);		//adauga un element la sfirsit

	int extrag(int &);	//extrage primul element


//functii inline

	int nl_vida()		//not lista vida
	{
	  	return(ncrt>0);
	}			//ncrt==0 --> lista vida

	int nl_plina()		//not lista plina
	{
	  	return(ncrt<nmax);
	}			//ncrt==nmax --> lista plina
};

//definitiile functiilor membre ale clasei fifo

fifo::fifo(int n)		//constructor 1, lista de n elemente
{
  	nmax=n;
  	tab=new int[n];
  	ncrt=prim=0;
  	cout<<"Constructor 1, lista de "<<nmax<<" elemente\n";
}

fifo::fifo()			//constructor 2, implicit
{				
  	nmax=100;		//lista de 100 elemente
  	tab=new int[100];
  	ncrt=prim=0;
  	cout<<"Constructor 2, lista de 100 elemente\n";
}

fifo::~fifo()			//destructor
{
  	cout<<"Destructor, lista de ";
  	cout<<nmax<<" elemente\n";
  	delete tab;
}

int fifo::adaug(int k)
{
  	if(nl_plina())
  	{
    		tab[(prim+ncrt)%nmax]=k;
    		ncrt++;
	 	cout<<"Lista are "<<ncrt<<" elemente\n";
	 	return 1;
  	}
  	else
  	{
    		cout<<"Lista plina!\n";
    		return 0;
  	}
}

int fifo::extrag(int &k)
{
  	if(nl_vida())
  	{
    		k=tab[prim];
    		prim=(prim+1)%nmax;
    		ncrt--;
	 	cout<<"Lista are "<<ncrt<<" elemente\n";
	 	return 1;
  	}
  	else
  	{
    		cout<<"Lista vida!\n";
    		return 0;
  	}
}

//programul demonstrativ

void fct(int);			//functie de test
fifo ls(10);			//obiect global fifo (static)

void main()
{
  	cout<<"\nIncepe main()\n";
  	fifo la;		//obiect automatic
  	fifo *lp;		//pointer catre un obiect fifo
  	lp=new fifo(20);	//creare obiect dinamic fifo
  	fct(30);
  	fct(40);
  	delete lp;
  	cout<<"Final main()\n";
}

void fct(int i)
{
  	cout<<"Incepe fct("<<i<<")\n";
  	fifo lf(i);
  	cout<<"Final fct("<<i<<")\n";
}

