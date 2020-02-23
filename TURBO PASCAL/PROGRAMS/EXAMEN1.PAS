        PROGRAM CORNE1;
        USES CRT;
        VAR A,B,APLUSB,AORIB:STRING;
            A10,B10,SUMA,PROD:INTEGER;
            C:CHAR;  EROARE:BOOLEAN;
        FUNCTION CONV810(X:STRING):INTEGER;
                 VAR I,VAL:INTEGER;
                 BEGIN
                      VAL:=0;
                      FOR I:=1 TO LENGTH(X) DO VAL:=VAL*8+ORD(X[I])-ORD('0');
                      CONV810:=VAL;
                 END;
        FUNCTION CONV108(Y:INTEGER):STRING;
                 VAR CIT,REST,D:INTEGER;
                     VALS:STRING;
                 BEGIN
                      VALS:='';
                      D:=Y;
                      REPEAT
                            REST:=D MOD 8;
                            CIT:=D DIV 8;
                            VALS:=CHR(ORD('0')+REST)+VALS;
                            D:=CIT
                      UNTIL CIT=0;
                      CONV108:=VALS;
                 END;

        BEGIN
        REPEAT
             WRITELN('PROGRAMUL CALCULEAZA SUMA SI PRODUSUL A DOUA NUMERE DATE,IN BAZA 8');
             WRITELN('INTRODUCETI CELE DOUA NUMERE');WRITELN;
             WRITE('A=');READLN(A);
             WRITELN;
             WRITE('B=');READLN(B);
             A10:=CONV810(A);
             B10:=CONV810(B);
             SUMA:=A10+B10;
             PROD:=A10*B10;
             APLUSB:=CONV108(SUMA);
             AORIB:=CONV108(PROD); WRITELN;WRITELN;
             WRITELN('SUMA NUMERELOR ESTE ',APLUSB,' (IN BAZA 8)');
             WRITELN('PRODUSUL NUMERELOR ESTE ',AORIB,' (IN BAZA 8)');
             WRITELN;
             WRITELN('DORITI REPETAREA ? D/N');
             READLN(C);
             CLRSCR
        UNTIL C='N';
        END.