#include <iostream.h>
#include <conio.h>
#include <stdio.h>

class location
{
	protected:
		int x;
		int y;
	public:
		void create( int xval, int yval );
		void set_x( int xval );
		void set_y( int yval );
		int get_x();
		int get_y();
};

class point : public location
{
	protected:
		int color;
	public:
		void create( int xval, int yval, int cval );
		void set_color( int cval );
		int get_color();
};

class circle : public point
{
	protected:
		int size;
	public:
		void create( int xval, int yval, int cval, int rval );
		void set_size( int rval );
		int get_size();
};

void location::create( int xval, int yval )
	{ x=xval; y=yval; }

void location::set_x( int xval ) { x=xval; }

void location::set_y( int yval ) { y=yval; }

int location::get_x() { return( x ); }

int location::get_y() { return( y ); }


void point::create( int xval, int yval, int cval )
{
	location::create( xval, yval );
	color=cval;
}

void point::set_color( int cval ) { color=cval; }

int point::get_color() { return( color ); }

void circle::create( int xval, int yval, int cval, int rval )
{
	point::create( xval, yval, cval );
	size=rval;
}

void circle::set_size( int rval ) { size=rval; }

int circle::get_size() { return(size); }

void main()
{
	location testpt;
	circle acircle;

	testpt.create( 10, 20 );
	acircle.create( 30, 40, 50, 60 );

	clrscr();

	cout<<"\n acircle.x is "<<acircle.get_x();
	cout<<"\n acircle.y is "<<acircle.get_y();
	cout<<"\n acircle.color is "<<acircle.get_color();
	cout<<"\n acircle.size is "<<acircle.get_size();
	cout<<"\n testpt.x is "<<testpt.get_x();
	cout<<"\n testpt.y is "<<testpt.get_y();
}




