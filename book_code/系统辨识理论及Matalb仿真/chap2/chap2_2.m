clear all;
close all;
n=4;
N=2^n-1;
a=0.5;
delta=0.6
A1=1;A2=1;A3=1;A4=0; %���ó�ʼֵ
for i=1:3*N
    X1=xor(A3,A4);  %�Ե������͵��ļ���λ�Ĵ����������ģ�����
    X2=A1;
    X3=A2;
    X4=A3;
    OUT(i)=A4;     %��λ�Ĵ������һ�����
    t(i)=delta*i;
    if OUT(i)>0.5   
        u(i)=-a;   %ȷ����ƽ��ֵ
    else u(i)=a;
    end
    A1=X1;A2=X2;A3=X3;A4=X4;    
end
figure(1);          %����M��������
stairs(t,u,'-')     
axis([1 20 -0.6 0.6]);
