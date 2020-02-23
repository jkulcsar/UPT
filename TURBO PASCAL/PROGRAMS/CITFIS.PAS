  program CitireFisiere;
  uses Crt;
  type   persoana = record
                     nume : string[20];
                     virsta:byte;
                     vechimea:byte;
                    end;
   var   p   : persoana;
         fis : file of persoana;
         i   : byte;
   begin
     assign(fis,'personal.prb');
     reset(fis); { deschidere pt. citire }
     i:=1; ClrScr;
     while not eof(fis) do begin
       read( fis,p);
       writeln(' Persoana nr.',i:3);
       with p do begin
         writeln(' Numele   : ',nume);
         writeln(' Virsta   : ',virsta);
         writeln(' Vechimea : ',vechimea);
       end; { with }
       i:=i+1;
     end; { while }
     close(fis);
     repeat until KeyPressed;
   end.
