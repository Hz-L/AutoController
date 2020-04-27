function f=obj(A,told,Y,N)%****计算个体目标函数值
  J=0;
  a=A;%the ith sample
  alfa=a(1);
  beta=a(2);
  ep=a(3);
  eta=a(4);
  ai=[alfa beta ep eta];
for j=1:1:N
    YY=[Y(j,1) Y(j,2) Y(j,3) Y(j,4);
        Y(j,5) Y(j,6) Y(j,7) Y(j,8)];
    tol=YY*ai';
    tol1(j)=tol(1);
    tol2(j)=tol(2);
end
tol=[tol1;tol2]';
E=tol-told;
for j=1:1:N
    Ej(j)=sqrt(E(j,1)^2+E(j,2)^2);
    J=J+0.5*Ej(j)*Ej(j);
end
f=J;
end