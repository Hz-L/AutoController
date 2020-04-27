clear all;
close all;
clc
%产生输入数据和观测数据
L=15;% M序列的周期
U1=zeros(2,1);U2=zeros(2,1);
Y1=zeros(2,1);Y2=zeros(2,1);
randn('seed',100)
V=randn(2,L);
randn('seed',1000)
U=randn(2,L);

y1=[1;0];y2=[1;1];y3=[1;0];y4=[0;1];
for i=1:L;%
    x1=xor(y3,y4);
    x2=y1;
    x3=y2;
    x4=y3;
    y(1:2,i)=y4;
    if y(1,i)>0.5
        U(1,i)=-5;
    else 
        U(1,i)=5;
    end
    if y(2,i)>0.5
        U(2,i)=-5;
    else 
        U(2,i)=5;
    end
    
    y1=x1;y2=x2;y3=x3;y4=x4;
end
figure(1);%第1个图形
A1=[0.5,-0.2;-0.3,0.6];A2=[1.2,-0.6;0.1,-0.6];
B0=[1.0,0.0;0.0,1.0];B1=[0.5,-0.4;0.2,-0.3];B2=[0.3,-0.4;-0.2,0.1];
for k=1:1:L
   time(k)=k;
   Y(1:2,k)=-A1*Y1-A2*Y2+B0*U(1:2,k)+B1*U1+B2*U2+0.5*V(1:2,k);
   %Return of parameters
   U2=U1;U1=U(1:2,k);Y2=Y1;Y1=Y(1:2,k);
end
figure;
plot(time,U(1,:),'k',time,U(2,:),'b');
xlabel('时间'),ylabel('输入');
figure
plot(time,Y(1,:),'k',time,Y(2,:),'b');
xlabel('时间'),ylabel('输出');
clear time
%一般最小二乘参数辨识
for i=3:L
    %第一行参数辨识系数矩阵和观测向量
    H1(i-2,1:10)=[-Y(1,i-1),-Y(2,i-1),-Y(1,i-2),-Y(2,i-2),U(1,i),U(2,i),U(1,i-1),U(2,i-1),U(1,i-2),U(2,i-2)];
    Y1(i-2,1)=Y(1,i);
    %第二行参数辨识系数矩阵和观测向量
    H2(i-2,1:10)=[-Y(1,i-1),-Y(2,i-1),-Y(1,i-2),-Y(2,i-2),U(1,i),U(2,i),U(1,i-1),U(2,i-1),U(1,i-2),U(2,i-2)];
    Y2(i-2)=Y(2,i);
end
theat1=inv(H1'*H1)*H1'*Y1;
theat2=inv(H2'*H2)*H2'*Y2;
%分离参数
A10=[theat1(1),theat1(2);theat2(1),theat2(2)]
A1
A20=[theat1(3),theat1(4);theat2(3),theat2(4)]
A2
B00=[theat1(5),theat1(6);theat2(5),theat2(6)]
B0
B10=[theat1(7),theat1(8);theat2(7),theat2(8)]
B1
B20=[theat1(9),theat1(10);theat2(9),theat2(10)]
B2
