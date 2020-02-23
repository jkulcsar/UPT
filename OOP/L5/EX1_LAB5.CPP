
class rational;	  // declarare incompleta

class complex 
  {
    double p_reala, p_imaginara;
    friend complex& ponderare(complex&,rational&);
  public:
    complex(double r,double i) : p_reala(r),p_imaginara(i) {}
    double get_real(void)   { return p_reala; } 
    double get_imaginar(void)  { return p_imaginara; }
  };

class rational
  {
    int numarator, numitor;
    double val;
  public:
    friend complex& ponderare8complex&,rational&);

    rational(int n1,int n2) : numarator(n1)
    {
      numitor = n2!=0 ? n2 : 1;
      val = ((double)numarator)/numitor;
    }

    double get_valoare(void)  { return val; }
  };

// fiind "friend", functia ponderare are acces la membrii privati ai 
// claselor "complex" si "rational"

complex& ponderare(complex& c,rational& r)
  {
    complex* t = new complex(c.p_reala*r.val,c.p_imaginara*r.val);
    return *t;
  }

// nefiind "friend", "ponderare_ineficienta" nu are acces la membrii
// privati ai claselor "complex" si "rational"

complex& ponderare_ineficienta(complex& c,rational& r)
  {
    complex* t = new complex(c.get_real()*r.get_valoare(),
			     c.get_imaginar()*r.get_valoare());
    return *t;
  }
  
void main(void)
 {
  complex a(2,4),b(6,9);
  rational d(1,2),e(1,3);

  a = ponderare(a,d);
  b = ponderare(b,e);

  a = ponderare_ineficienta(a,d);
  b = ponderare_ineficienta(b,e);
 }  
