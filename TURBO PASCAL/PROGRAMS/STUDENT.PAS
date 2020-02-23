  program Articole; uses Crt;
  const Nmax=100; Nnote=5;
  linie='------------------------------------------------------------------------------';
  type  tipnote = array[1..nnote] of byte;
           stud = record
                    nume : string[30];
                    nota : tipnote;
                    media: real ;
                 restante: byte;
                  end;
           studenti=array[1..nmax] of stud;
   var n,flag:integer;
       student : studenti;
       ch : char;

   procedure CitSiVerif( var n:integer; var student:studenti );
   var i,j,t:integer; corect : boolean;
     { numere: set of 0..9; }
     function NumeCorect( nume:string):boolean;
      begin
        j:=1;Corect:=true;
        while corect and ( j<=length(nume) ) do
          begin
            nume[j]:=upcase(nume[j]);
            if (nume[j]<'A') or (nume[j] >'Z')   then corect := False;
            j:=j+1;
          end;
         NumeCorect:=corect;
       end;    { NumeCorect }
   begin { CitSiVerif }
     repeat
       write(' Numar studenti : 1-- ',nmax,' ');
       readln(n);
     until (n>=1) and (n<=nmax);
     writeln(' Numele si notele studentilor : ');
     for i:=1 to n do begin
      writeln(' Studentul(a) nr. ',i:3,' : ');
   with student[i] do begin
         repeat
           write('   Numele : ');readln(nume);
           until(NumeCorect(nume));
         writeln('   Notele lui : ');
         for t:=1 to nnote do begin
          write(' nota ',t,' . ');readln(nota[t]);
         end;
   end; end;
   end;  { CitSiVerif }

   procedure CalcMediaSiRest(n:integer; var student:studenti);
   var i,t,c,suma:byte;
   begin { CalcMedia }
     for i:=1 to n do begin
       with student[i] do begin
             suma:=0;c:=nnote;restante:=0;
             for t:=1 to nnote do begin
               if nota[t]=0 then c:=c-1 else suma:=suma+nota[t];
               if nota[t]<=4 then restante:=restante+1;
             end;
             media := suma/c;
       end;end;
   end;  { CalcMedia }

   procedure Ordoneaza(n:integer; var student:studenti);
 { Ordoneaza lista dupa medii; daca medii egale => ord. alfabetic }
   var i:integer;
       aux:stud; schimbare:boolean;
   begin  { Ordoneaza }
     repeat
       schimbare:=false;
       for i:=1 to n-1 do
         if (student[i].media<student[i+1].media) or
            (student[i].media=student[i+1].media) and
            (student[i].nume >student[i+1].nume ) then
                 begin
                   aux:=student[i];
                   student[i]:=student[i+1];
                   student[i+1]:=aux;
                   schimbare:=true;
                 end;
     until not schimbare;
   end;

   procedure ListaGen(n:integer; student:studenti);
 { Listeza numele tuturor studentilor in ord.desc. a mediilor }
   var i:byte;
   begin  { Tipareste }
     ClrScr;writeln(linie);
     writeln('*',' Lista studentilor ,media si restantele fiecaruia sint: ','*');
     writeln(linie);
     for i:=1 to n do
       with student[i] do begin
        writeln(i:3,' . ',nume,media:10:2,restante:10);writeln(linie);end;
   end;   { ListaGen }

   procedure ListaAlfaBetic(n:integer; student:studenti);
   var i:byte;
      aux:stud; schimbare:boolean;
   begin { ListaAlfaBetic }
     repeat
       schimbare:=false;
       for i:=1 to n-1 do
            if (student[i].nume >student[i+1].nume ) then
                 begin
                   aux:=student[i];
                   student[i]:=student[i+1];
                   student[i+1]:=aux;
                   schimbare:=true;
                 end;
     until not schimbare;
     ClrScr;
     writeln('*',linie,'*');writeln('Ordinea alfabetica : ');writeln('*',linie,'*');
     for i:=1 to n do begin
                       writeln('*',i:3,'  ',student[i].nume,student[i].media:10:2,student[i].restante:5);
                       writeln(linie);end;
   end;  { ListaAlfabetic }


   begin  { main }
    repeat
      CitSiVerif(n,student);
      CalcMediaSiRest(n,student);
      ClrScr; writeln('Optiuni asupra modului de afisare: ');
              writeln(' 1 = Lista generala ( in ord. desc. a mediilor ');
              writeln(' 2 = Lista in ord. alfabetica ( indif de medii si restante');
              write(' Optiunea Dvs. ? '); readln(flag);
        case flag of
           1: begin
                Ordoneaza(n,student);
                ListaGen(n,student); end;
           2: ListaAlfabetic(n,student);
        end;
        write(' Mai doriti o lista ? (y/n) ');
        readln(ch);
    until ch='n'
   end.   { main }



