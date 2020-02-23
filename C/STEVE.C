
 #include <stdio.h>
 #include <conio.h>

 typedef struct
 {
    int id;
    char name[80];
    float earnings;
    char *comments;
}t_employee;

void print_employee( t_employee *emp1)
{    printf("Records for %s\n", emp1 -> name);
	printf("Employee %d\n",emp1 -> id);
	printf("%s earned $%g\n", emp1 -> name, emp1 -> earnings);
	printf(emp1 -> comments);
}

void main(void)
{ t_employee steve;

  clrscr();
  steve.id = 109;
  strcpy(steve.name,"Steve");
  steve.earnings = 1021.212 ;
  steve.comments = "Goofs off too much !";
  print_employee(&steve);
  getch();
}

