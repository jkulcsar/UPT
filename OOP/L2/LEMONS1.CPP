#include<iostream.h>
#include<iomanip.h>
#include<stdlib.h>
#include<conio.h>

class Lemon{
private:
	int totalLeft;
	int sugarTeasp;
	float total;
public:
	void init(void);
	void showTot(void);
	void buySweet(void);
	void buyUnSweet(void);
};

void Lemon::init(void)
{
	totalLeft=100;
	sugarTeasp=80;
	total=0.0;
}

void Lemon::showTot(void)
{
}

void Lemon::buySweet(void)
{
}

void Lemon::buyUnSweet(void)
{
}

void main(void)
{
	Lemon	drink;
	clrscr();
	drink.init();
	do
	{
	}
}
	
	