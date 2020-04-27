function [sys,x0,str,ts] = Differentiator(t,x,u,flag)  %chap8_4integral
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 1,
    sys=mdlDerivatives(t,x,u);
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 3;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [0 0 0];
str = [];
ts  = [0 0];
function sys=mdlDerivatives(t,x,u)
x1=u(1);
x1p=x(1);

epc=0.005;
R=1/epc;
a1=10;a2=10;a3=10;

sys(1)=x(2);
sys(2)=x(3);
sys(3)=-R^3*a1*(x1p-x1)-R^2*a2*x(2)-R*a3*x(3);
function sys=mdlOutputs(t,x,u)
sys=x;