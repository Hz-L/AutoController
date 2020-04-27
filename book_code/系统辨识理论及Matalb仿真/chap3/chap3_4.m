clear all;
close all;
clc
%产生输入数据和观测数据
u_1=0.0;u_2=0.0;
y_1=0.0;y_2=0.0;
randn('seed',100)
num=randn(1,1000);
randn('seed',1000)
num1=randn(1,1000);
for k=1:1:1000
   time(k)=k;
   u(k)=num1(k);
   %Linear model
   kesi=0.5*num(1,k);
   a0=1.6;   a1=-0.7;   b0=1;   b1=0.5;
   y(k)=a0*y_1+a1*y_2+b0*u_1+b1*u_2+kesi;
   %Return of parameters
  u_2=u_1;u_1=u(k);y_2=y_1;y_1=y(k);
end
figure;
plot(time,u,'k');
xlabel('时间'),ylabel('输入');
figure
plot(time,y,'k');
xlabel('时间'),ylabel('输出');
clear time
%递推阻尼最小二乘参数辨识
beta=0.95;
miu=0.95;
theta_1=zeros(4,1);   %theta=[a1,b0 b1]
theta_2=zeros(4,1);
alfa=10000;
P_1=alfa*eye(4);

for k=3:1:1000
  time(k)=k;
  fai=[y(k-1) y(k-2) u(k-1) u(k-2)]';
  P=inv(miu*eye(4)-beta*miu*eye(4)+beta*inv(P_1)+fai*fai');
  theta=theta_1+beta*miu*P*(theta_1-theta_2)+P*fai*(y(k)-fai'*theta_1);
  a0(k)=theta(1);
  a1(k)=theta(2);
  b0(k)=theta(3);
  b1(k)=theta(4);
  theta_2=theta_1;
  theta_1=theta;
  P_1=P;
end
figure
plot(time,a0,'k');
hold on
plot(time,a1,'b');
plot(time,b0,'r');
plot(time,b1,'g');
hold off
