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
	cout<<setprecision(2);
	cout.setf(ios::fixed);
	cout.setf(ios::showpoint);
	cout<<"\nTotal so far today is $"<<total<<"\n\n";
}

void Lemon::buySweet(void)
{
	if(totalLeft==0)
	{
		cerr<<"\nSorry, no more lemonade is left.\n\n";
	}
	else	if(sugarTeasp==0)
		{
			cerr<<"\nNo more sugar is left. Sorry.\n\n";
		}
		else
		{
			cout<<"\nEnjoy your drink!\n\n";
			totalLeft--;
			sugarTeasp-=2;
			total+=.50;
		}
}

void Lemon::buyUnSweet(void)
{
	if(totalLeft==0)
	{
		cerr<<"\nSorry, no more lemonade is left.\n\n";
	}
	else
	{
		cout<<"\nEnjoy your drink!\n\n";
		totalLeft--;
		total+=.45;
	}
}

void main(void)
{
	Lemon	drink;
	int	ans;

	clrscr();
	drink.init();
	do
	{
		cout<<"What's happening?\n\n";
		cout<<"  1. Sell a sweetened.\n";
		cout<<"  2. Sell an unsweetened.\n";
		cout<<"  3. Show total sales so far.\n";
		cout<<"  4. Quit the program.\n";
		cout<<"What do you want to do? ";
		cin>>ans;
		switch(ans)
		{
			case 1: drink.buySweet();
				break;
			case 2: drink.buyUnSweet();
				break;
			case 3: drink.showTot();
				break;
			case 4: drink.showTot();
				exit(1);
		}
	}while(ans>=1&&ans<=4);
}
	
	