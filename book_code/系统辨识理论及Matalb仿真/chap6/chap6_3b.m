
%Online BP Etimation for Plant
clear all;
load wfile w1 w2;

ts=0.01;
sys=tf(133,[1,25,0]);
dsys=c2d(sys,ts,'z');
[num,den]=tfdata(dsys,'v');

u_1=0;u_2=0;
y_1=0;y_2=0;

I=[0,0,0,0,0,0]';
Iout=[0,0,0,0,0,0]';

for s=1:1:1000
   time(s)=s; 
   M=2;
   if M==1
      u(s)=0.5*sin(2*pi*s*ts);
   elseif M==2
      u(s)=0.15*sin(2*pi*s*ts);
   elseif M==3
      u(s)=0.015*sin(2*pi*s*ts);
   elseif M==4
      u(s)=0.2*sin(2*pi*s*ts)+0.3*cos(pi*s*ts);
   elseif M==5
      u(s)=0.35*sign(sin(2*pi*s*ts));
   end
%Linear model
   y(s)=-den(2)*y_1-den(3)*y_2+num(2)*u_1+num(3)*u_2;
   
   x=[u(s),y_1];
for j=1:1:6   
    I(j)=x*w1(:,j);
    Iout(j)=1/(1+exp(-I(j)));
end
yp(s)=w2'*Iout;

u_2=u_1;u_1=u(s);
y_2=y_1;y_1=y(s);
end

figure(1);
plot(time,y,'r',time,yp,'b');
xlabel('time');ylabel('y and yp');