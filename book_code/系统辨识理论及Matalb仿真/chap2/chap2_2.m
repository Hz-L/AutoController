clear all;
close all;
n=4;
N=2^n-1;
a=0.5;
delta=0.6
A1=1;A2=1;A3=1;A4=0; %设置初始值
for i=1:3*N
    X1=xor(A3,A4);  %对第三级和第四级移位寄存器输出进行模二相加
    X2=A1;
    X3=A2;
    X4=A3;
    OUT(i)=A4;     %移位寄存器最后一级输出
    t(i)=delta*i;
    if OUT(i)>0.5   
        u(i)=-a;   %确定电平幅值
    else u(i)=a;
    end
    A1=X1;A2=X2;A3=X3;A4=X4;    
end
figure(1);          %绘制M序列曲线
stairs(t,u,'-')     
axis([1 20 -0.6 0.6]);
