#include <iostream.h>
#include <string.h>

typedef struct elem_list
{
	char sir[20];
	struct elem_list *next;
}elem_list;

class lista
{
	elem_list *cap, *coada;
	friend void afisare(lista &);
public:
//	friend void afisare(lista &);
	lista()
	{
		cap = NULL;
		coada = NULL;
	}
	void insert_in_list(char *);
	void delete_last_item();
	~lista();
};

lista::~lista()
{
	elem_list *crt;
	crt = cap;
	while(crt)
	{
		cap = crt->next;
		delete (crt);
		crt = cap;
	}
}

void lista::insert_in_list(char *s)
{
	elem_list *crt;
	crt = new elem_list;
	strcpy(crt->sir, s);
	crt->next = NULL;
	if(!cap)
	{
		cap = crt;
		coada = crt;
	}
	else
	{
		coada->next = crt;
		coada = crt;
	}
}

void lista::delete_last_item()
{
	elem_list *crt;
	crt = cap;
	if(!crt)
		return;
	if(!crt->next)
	{
		delete crt;
		cap = coada = NULL;
		return;
	}
	while(crt->next->next)
		crt = crt->next;
	coada = crt;
	coada->next = NULL;
	delete crt->next;
}

void afisare(lista &ls)
{
	elem_list *crt;
	crt = ls.cap;
	while(crt)
	{
		cout<<crt->sir;
		cout<<"\n";
		crt = crt->next;
	}
}

main()
{
	lista list;
	char sir[20];
	cout<<"Introdu siruri de maxim 20 de caractere (0 pt. oprire)\n";
	for(;;)
	{
		cin>>sir;
		if(sir[0] == '0')
			break;
		list.insert_in_list(sir);
	}
	afisare(list);
	list.delete_last_item();
	afisare(list);

}