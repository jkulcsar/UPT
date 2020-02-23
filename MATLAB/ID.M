disp('Program de estimare a parametrilor');
%generarea unui semnal de intrare
rand('normal');
int=0;
while int==0
	k=menu('NR.ITERATII','ales','impus(200)','rulare continua');
	if k==1
		it=input('Introduceti numarul de iteratii it=');
		int=1;
	end
	if k==2
		it=200;
		int=1;
	end
	if k==3
		it=200;
		int=1;
	end%	
	end %	
	u=rand(it,1);plot(u);grid;title('Semnal de intrare');
	y=rand(it,1);
	y1=rand(it,1);
	pause;
	%generarea semnalului aleator perturbator
	rand('normal');
	pert1=rand(it,1);
	for i=1:it
		pert(i)=pert1(i)/1000;
	end;
	%generarea iesirii y si a iesirii y1 perturbate;
	k=4;
	for i=5:it
		% termenii ecuatiei
		t4u=0.08*u(i-k);
		t4y=0.89*y(i-k);
		t4y1=0.89*y1(i-k);
		k=k-1;
		t3u=0.065*u(i-k);
		t3y=3.473*y(i-k);
		t3y1=3.473*y1(i-k);
		k=k-1;
		t2u=0.074*u(i-k);
		t2y=5.255*y(i-k);
		t2y1=5.255*y1(i-k);
		k=k-1;
		t1u=0.083*u(i-k);
		t1y=3.671*y(i-k);
		t1y1=3.671*y1(i-k);
		
		y(i)=-t4y+t3y-t2y+t1y+t4u-t3u-t2u+t1u;
		y1(i)=-t4y1+t3y1-t2y1+t1y1+t4u-t3u-t2u+t1u+pert(i);
		k=4;
	end
		ies=0;
		while ies==0
			k=menu('IESIRI','neperturbat','perturbat','exit');
			if k==1
				plot(y);grid;
				pause;
			end;
			if k==2
				plot(y1);grid;
				pause;
			end;
			if k==3
				ies=1;
			end;
				
%formarea matricii masuratorilor (A) si a vectorului termenilor liberi (b)
m=input('Introduceti nr. de ecuatii (minim 8)   m=');
b=zeros(1,m);
A=zeros(m,8);
for k=1:m
	b(k)=y(k);
	for j=1:4
 		if k<j-4
		A(k,j)=y1(k-j);
	end
		end
	for j=5:8
		if k<j-8
		A(k,j)=u(k-j+4);
	end
		end
		        %A(k,1)=y1(k-1);
		        %A(k,2)=y1(k-2);
			%A(k,3)=y1(k-3);
			%A(k,4)=y1(k-4);
			%A(k,5)=u(k-1);
			%A(k,6)=u(k-2);
			%A(k,7)=u(k-3);
			%A(k,8)=u(k-4);
end
	%initializare matrici;
	%matricea factor ortogonala
	Q=zeros(m,m);
	for i=1:m-1
		Q(i,i)=1;
	end
	for k=4:8
		for l=k+1:m-1
			r0=sqrt(A(k,k)*A(k,k)+A(l,k)*A(l,k));
			c=A(k,k)/r0;
			s=-A(l,k)/r0;
				for j=k:8
					t(j)=c*A(k,j)-s*A(l,j);
					A(l,j)=s*A(k,j)+c*A(l,j);
					A(k,j)=t(j);
				end	
			v=c*b(k)-s*b(l);
			b(l)=s*b(k)+c*b(l);
			b(k)=v;	
		end
	end
	for o=1:it
		m=m+1;
		l=m; 
		for k=4:8
		r0=sqrt(A(k,k)*A(k,k)+A(l,k).*A(l,k));
		c=A(k,k)/r0;
		s=-A(l,k)/r0;
		for j=k:8
			t(j)=c*A(k,j)-s*A(l,j);
			A(l,j)=s*A(k,j)+c*A(l,j);
			A(k,j)=t(j);
		end
		v=c*b(k)-s*b(l);
		b(l)=s*b(k)+c*b(l);
		b(k)=v;
		end
	end
	%obtinerea estimatorului, rezolvarea sistemului
	xs=zeros(8,it);
	for i=8:i
		for j=i+1:8
			s=A(i,j)*x(j);
		end;
		x(i)=(b(i)-s)/A(i,i);
		xs(i,it)=x(i);
		%salvarea parametrului dat xs
	end;
	%afisare grafica
	for k=1:it
		x1(k)=xs(1,k); 
		x2(k)=xs(2,k); 
		x3(k)=xs(3,k); 
		x4(k)=xs(4,k); 
		x5(k)=xs(5,k); 
		x6(k)=xs(6,k); 
		x7(k)=xs(7,k); 
		x8(k)=xs(8,k); 
	end
	af=0
	while af==0
		k1=menu('AFISARE','parametrul ales','toti parametrii','exit');
		if k1==1
			par=0
			while par==0
				k2=menu('PARAMETRII','X1','X2','X3','X4','X5','X6','X7','X8','QUIT');
					if k2==1
						plot(x1);grid;
						pause;
					end
					if k2==2
						plot(x2);grid;
						pause;
					end
					if k2==3
						plot(x3);grid;
						pause;
					end
					if k2==4
						plot(x4);grid;
						pause;
					end
					if k2==5
						plot(x5);grid;
						pause;
					end
					if k2==6
						plot(x6);grid;
						pause;
					end
					if k2==7
						plot(x7);grid;
						pause;
					end
					if k2==8
						plot(x8);grid;
						pause;
					end
					if k2==9
						par=1
					end
			end
		end
		if k1==2
			subplot(331);plot(x1);grid;title('X1');
			subplot(332);plot(x2);grid;title('X2');
			subplot(333);plot(x3);grid;title('X3');
			subplot(334);plot(x4);grid;title('X4');
			subplot(335);plot(x5);grid;title('X5');
			subplot(336);plot(x6);grid;title('X6');
			subplot(337);plot(x7);grid;title('X7');
			subplot(338);plot(x8);grid;title('X8');
			pause
		end;
		
		if k1==3
			af=1
		end
end
end