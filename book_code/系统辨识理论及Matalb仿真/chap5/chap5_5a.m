% Closed-loop system identification with frequency test (2008/1/31)
clear all;
close all;

ts=0.001;
Am=0.5;
Gp=tf(5.235e005,[1,87.35,1.047e004,0]);
zGp=c2d(Gp,ts,'z');
[num,den]=tfdata(zGp,'v');

kp=0.70;
kk=0;
u_1=0.0;u_2=0.0;u_3=0.0;
y_1=0;y_2=0;y_3=0;
for F=0.5:0.5:8
kk=kk+1;
FF(kk)=F;

for k=1:1:2000
time(k)=k*ts;

yd(k)=Am*sin(1*2*pi*F*k*ts);        % Tracking Sine Signal with different frequency
y(kk,k)=-den(2)*y_1-den(3)*y_2-den(4)*y_3+num(2)*u_1+num(3)*u_2+num(4)*u_3;

e(k)=yd(k)-y(kk,k);

u(k)=kp*e(k);   %P Controller

u_3=u_2;u_2=u_1;u_1=u(k);
y_3=y_2;y_2=y_1;y_1=y(kk,k);
end
    plot(time,yd,'r',time,y(kk,:),'b');
    pause(0.6);
end
Y=y;
save saopin_data Y;  %Save Y with different Frequency
save closed.mat kp;