clear all
close all
clc
T=[20.5 26 32.7 40 51 61 73 80 88 95.7];%温度
R=[765 790 826 850 873 910 942 980 1010 1032];%阻值
[m,n]=size(T);
figure 
plot(T,R,'b+')
t=0;
z=0;
tz=0;
tt=0;
for i=1:n
    t=t+T(i);
    tt=tt+T(i)*T(i);
    z=z+R(i);
    tz=tz+T(i)*R(i);
end
a=(tt*z-t*tz)/(n*tt-t*t);
b=(n*tz-t*z)/(n*tt-t*t);
R1=a+70*b;
%最小二乘拟合
A=polyfit(T,R,1);
z=polyval(A,T);
%画图
figure
plot(T,z);
figure
plot(T,R,'b+')
hold on
plot(T,z,'r');
hold off

