//Sa se creeze o lista simplu inlantuita de siruri de caractere, un element
//din lista fiind o instanta a urmatoarei clase:
#include <iostream.h>
#include <stdio.h>
#include <string.h>

#define NULL 0
class node{
	static node *head;	//pointer la lista
	node *next;		//legatura la urmatorul elem. din lista
	char *info;		//sirul de caractere a unui elem. din lista
   public:
	node(char * = NULL);	//declararea constructorului
	void display_all();	//afiseaza nodurile listei
};

node::node(char *ptr)
{
	if(ptr != 0)	//se insereaza noul nod in lista
		{
		info = new char[strlen(ptr)+1];
		strcpy(info,ptr);
		next = 0;
		node *cursor=head;
		while(cursor->next != 0)
			cursor=cursor->next;

		cursor->next = this;
		}
	else
		{
		info = new char[strlen("root")+1];
		strcpy(info,"root");
		next = 0;
		head = this;
		}
}

void node::display_all()
{
	//se parcurge lista, afisandu-se cimpul de informatii al fiecarui nod
	node *cursor=head;
	while(cursor != 0)
		{
		printf("*%s\n",cursor->info);
		cursor = cursor->next;
		}
}

void main()
{
	node a(NULL);
	char buffer[201];

	printf("Introduceti sirul de caractere ");
	gets(buffer);
	node b(buffer);
	printf("Introduceti sirul de caractere ");
	gets(buffer);
	node c(buffer);
	printf("Introduceti sirul de caractere ");
	gets(buffer);
	node d(buffer);
	b.display_all();
}