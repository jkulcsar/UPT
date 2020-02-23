class student {
	char *name;
	int year;
   public:
	void display();   // afisarea inform. (nume si an de studiu) pentru un student
	student(char *, int);  //constructorul 
	~student();	       //destructorul
};

class on_campus : student {
	char *dorm,
	     *room;
   public:
	void a_disp();  // afiseaza inform. (nume, an de studiu, camin, camera)
			// pentru un student
	on_campus(char *, int, char *, char *); // constructorul clasei
	~on_campus();	// destructorul clasei
};

class off_campus : student {
	// campuri care indica adresa off_campus (strada, oras, nr.) a unui student 
   	// constructorul clasei
	// destructorul
	// functie de afisare a inform. (nume, an de studiu, adresa) a unui student
};

main()
{
// se declara cite o instanta a fiecarei clase
// sa se afiseze informatiile referitoare la fiecare persoana declarata
}
