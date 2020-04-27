%BP Training for Modeling off-line
clear all;
close all;

ts=0.01;
sys=tf(133,[1,25,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;
y_1=0;y_2=0;

xite=0.50;
alfa=0.05;

w2=rands(6,1);
w2_1=w2;w2_2=w2_1;

w1=rands(2,6);
w1_1=w1;w1_2=w1;
dw1=0*w1;

I=[0,0,0,0,0,0]';
Iout=[0,0,0,0,0,0]';
FI=[0,0,0,0,0,0]';

k=0;
NS=200;
for s=1:1:NS   %Samples  
	u(s)=0.5*sin(2*pi*s*ts);
%Linear model
   y(s)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
   
   u_2=u_1;u_1=u(s);
	y_2=y_1;y_1=y(s);
end

for k=1:1:1000
k=k+1;   
time(k)=k*ts;

for s=1:1:NS
  
x=[u(s),y(s)];
for j=1:1:6   
    I(j)=x*w1(:,j);
    Iout(j)=1/(1+exp(-I(j)));
end
yn(s)=w2'*Iout;

e(s)=y(s)-yn(s);
e1=0.5*e(s)^2;
e1s(s)=e1;

E=0;
if s==NS
   for s=1:1:NS
      E=E+e1s(s);
   end
end

w2=w2_1+xite*Iout*e(s)+alfa*(w2_1-w2_2);

for j=1:1:6
   S=1/(1+exp(-I(j)));
   FI(j)=S*(1-S);
end

for i=1:1:2
   for j=1:1:6
       dw1(i,j)=xite*FI(j)*x(i)*e(s)*w2(j,1); 
   end
end
w1=w1_1+dw1+alfa*(w1_1-w1_2);

w1_2=w1_1;w1_1=w1;
w2_2=w2_1;w2_1=w2;
end   %End of NS
Ek(k)=E;
end   %End of k
figure(1);
plot(time,Ek,'r');
xlabel('time');ylabel('E');

save wfile w1 w2;