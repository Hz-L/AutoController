%alfa=6.7333;beta=3.4;epc=3.0;eta=0;
%a=[alfa,beta,epc, eta];
save para_file told Y;
clear all;
close all;

load para_file;

n=size(told);
N=n(1);
for i=1:1:N
YY=[Y(i,1) Y(i,2) Y(i,3) Y(i,4);
    Y(i,5) Y(i,6) Y(i,7) Y(i,8)];
y11(i)=YY(1,1);
y12(i)=YY(1,2);
y13(i)=YY(1,3);
y14(i)=YY(1,4);
y21(i)=YY(2,1);
y22(i)=YY(2,2);
y23(i)=YY(2,3);
y24(i)=YY(2,4);

toldi=told(i,:);
told1(i)=toldi(1);
told2(i)=toldi(2);
end
%J=sum(ei);
y=[y11' y12' y13' y14';
   y21' y22' y23' y24'];
Told=[told1 told2]';
a=y'*inv(y*y')*Told