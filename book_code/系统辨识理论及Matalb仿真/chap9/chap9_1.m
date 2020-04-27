% Grey model identification
clear all;
close all;

ts=0.001;
n=2;
N=n+2;

A=[0 1;0 -25];
b=[0;133];

V=[0.10 0.20 0.30];

xk_1=[0;0];
for k=1:1:N+1
time(k)=k*ts;
   
x1(k)=xk_1(1);
x2(k)=xk_1(2);
      
u(k)=sin(k*ts);

D(k)=V(1)*x1(k)+V(2)*x2(k)+V(3);
xk=A*xk_1+b*u(k)+b*D(k);
xk_1=xk;
end

% Grey identification
y1(1)=x1(1)+x1(2);y2(1)=x2(1)+x2(2);
B=[y1(1) y2(1) 2];   %B2

for k1=2:1:N-1   %From B2 to B(N-2)
    y1(k1)=y1(k1-1)+x1(k1+1);
    y2(k1)=y2(k1-1)+x2(k1+1);
    B=[B;y1(k1) y2(k1) k1+1];
end

D=0;
for k1=1:1:N
   D(k1)=1/b*([x1(k1+1);x2(k1+1)]-A*[x1(k1);x2(k1)])-u(k1);
end
D1(1)=D(1)+D(2);

for k1=2:1:N-1
   D1(k1)=D1(k1-1)+D(k1+1);
end
Vp=inv(B'*B)*B'*D1';
Vp=Vp'

inv(B'*B)
display('V=');disp(V);