
	#include <stdio.h>
	#include <dos.h>

	typedef void interrupt intfunc();
	intfunc *oldclock;

	typedef unsigned char screen_type[25][80][2];
	screen_type far *screen;

	int cnt = 0;

	void interrupt count()
	{
		 (*oldclock)();
		 enable();

		 cnt++;

		 (*screen)[0][50][0] = (cnt/1000)+'0';
		 (*screen)[0][51][0] = ((cnt/100)%10)+'0';
		 (*screen)[0][52][0] = ((cnt/10)%10)+'0';
		 (*screen)[0][53][0] = (cnt%10)+'0';

	}

	void main(void)
	{
		int i;

		screen = (unsigned char far *) 0xb8000000;

		oldclock = (intfunc *)getvect(0x8);

		setvect(0x8, count);

		printf("\nHit any key to start countdown . . . ");
		getch();

		for(i=100;i>=0;i--)
			printf("\nThe value of 'i' is %d, 'cnt' is %d .", i,cnt );

	}