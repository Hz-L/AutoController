function J=evaluate_objective(B,tol,Y,N) %计算个体目标函数值
  J=0;
  m=B(1);
  epc0=B(2);
  Ix=B(3);
  
  a1=1/m;
  a2=epc0/m;
  a3=1/Ix;
  A=[a1 0;0 a2;0 a3];
for j=1:1:N
    YY=[Y(j,1);Y(j,2);Y(j,3)];
    Yp=A*tol(j,:)';
    E(:,j)=YY-Yp;
end

for j=1:1:N
    Ej(j)=sqrt(E(1,j)^2+E(2,j)^2+E(3,j)^2);
    J=J+0.5*Ej(j)*Ej(j);
end
end