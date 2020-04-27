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
vt=u(1);

R=1000;
a0=10;b0=10;c0=10;

s10=x(1)-vt;

sys(1)=x(2);
sys(2)=x(3);
sys(3)=-R^3*a0*s10-R^2*b0*x(2)-R*c0*x(3);
function sys=mdlOutputs(t,x,u)
sys = x;