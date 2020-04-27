function E=evaluate_objective(B,tol,Y,N) %计算个体目标函数值
E=0;
J=B(1);

for j=1:1:N
    Yj=Y(j,1);
    Yp=1/J*tol(j,:)';
    e(j)=Yj-Yp;
end
for j=1:1:N
    E=E+0.5*e(j)*e(j);
end
end