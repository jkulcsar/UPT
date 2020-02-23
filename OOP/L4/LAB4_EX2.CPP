#include<iostream.h>
#include<string.h>

class demo{
 public:
	demo(const char *nm);
	~demo();
 private: 
	char name[20];
};
demo::demo(const char *nm)
{
 	strncpy(name,nm,20);
 	cout<<"Constructor apelat pentru "<<name<<endl;
}
demo::~demo()
{
 	cout<<"Destructor apelat pentru "<<name<<endl;
}
void func()
{
 	demo localFuncObject("localFuncObject");
 	static demo staticObject("staticObject");

 	cout<<"In func()\n";
}
demo globalObject("globalObject");
void main(void)
{
 	demo localMainObject("localMainObject");
 	cout<<"In main(), inainte de apelul functiei func()\n";
 	func();
 	cout<<"In main(), dupa apelul functiei func()\n";
}
