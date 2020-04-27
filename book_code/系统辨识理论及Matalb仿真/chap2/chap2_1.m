clear all;
close all;
A=5.^17;  N=100;  x0=1; M=2.^42-1;  %初始化
for k=1:N  %乘同余法递推100次开始
    x2=A*x0; 
    x1=mod(x2,M); %将x2存储器的数除以M，取余数放入x1中
    v1=x1/(M+1);  %将x1存储器中的数除以 的(0,1)中的随机数
    v(:,k)=v1;  %将v1中的数存放在矩阵v中的第k列
    x0=x1;
    v0=v1;
end    %递推100次结束
v2=v   %将矩阵v中的随机数存放在v2中
 
%grapher  绘图
k1=k;
k=1:k1;
plot(k,v,k,v,'r');
xlabel('k'),ylabel('v');
title('(0,1)均匀分布的随机序列 ')
