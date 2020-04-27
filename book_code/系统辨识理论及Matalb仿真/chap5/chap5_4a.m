% Transfer function identification with frequency test
clear all;
close all;

ts=0.001;
a=25;b=133;c=10;
sys=tf(b,[1,a,c]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');
Am=0.5; 

q=1;
for F=1:0.5:10
u_1=0.0;u_2=0.0;
y_1=0;y_2=0;

for k=1:1:20000
time(k)=k*ts;

u(q,k)=Am*sin(1*2*pi*F*k*ts);        % Sine Signal with different frequency
y(q,k)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
   
uk(k)=u(q,k);
yk(k)=y(q,k);

u_2=u_1;u_1=u(q,k);
y_2=y_1;y_1=y(q,k);
end
q=q+1;

plot(time,uk,'r',time,yk,'b');
pause(0.2);
end
save idenfile y;