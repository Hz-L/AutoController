function [sys,x0,str,ts] = spacemodel(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2,4,9}
    sys=[];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
global cij bj c
sizes = simsizes;
sizes.NumContStates  = 5;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 2;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys = simsizes(sizes);
x0 = 0*ones(1,5);
str = [];
ts  = [];
cij=[-2 -1 0 1 2;
   -2 -1 0 1 2];
bj=5;c=5;
function sys=mdlDerivatives(t,x,u)
global cij bj c
xd=sin(t);
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);
e=x1-xd;
de=x2-dxd;
s=c*e+de;

xi=[x1;x2];

h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj*bj));
end
gama=850;
W=[x(1) x(2) x(3) x(4) x(5)]';
for i=1:1:5
    sys(i)=gama*s*h(i);
end
function sys=mdlOutputs(t,x,u)
global cij bj c
xd=sin(t);
dxd=cos(t);
ddxd=-sin(t);

x1=u(2);
x2=u(3);
e=x1-xd;
de=x2-dxd;
s=c*e+de;

xi=[x1;x2];
h=zeros(5,1);
for j=1:1:5
    h(j)=exp(-norm(xi-cij(:,j))^2/(2*bj*bj));
end
W=[x(1) x(2) x(3) x(4) x(5)]';
fxp=W'*h;

if t<=1.5
    xite=1.0;
else
    xite=0.10;
end
ut=-c*de-fxp+ddxd-xite*sign(s);
sys(1)=ut;
sys(2)=fxp;