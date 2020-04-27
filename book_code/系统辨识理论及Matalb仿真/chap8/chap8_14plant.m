function [sys,x0,str,ts]=s_function(t,x,u,flag)
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
sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 4;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0,0,0,0,0,0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
u1=u(1);
u2=u(2);
g=9.8;m=68.6;epsilon0=0.5;Ix=123.1;
a1=1/m;
a2=epsilon0/m;
a3=1/Ix;

sys(1)=x(2);
sys(2)=a1*sin(x(5))*u1-a2*cos(x(5))*u2;
sys(3)=x(4);
sys(4)=-a1*cos(x(5))*u1-a2*sin(x(5))*u2+g;
sys(5)=x(6);
sys(6)=a3*u2;
function sys=mdlOutputs(t,x,u)
u1=u(1);
u2=u(2);
g=9.8;m=68.6;epsilon0=0.5;Ix=123.1;
a1=1/m;
a2=epsilon0/m;
a3=1/Ix;

dx2=a1*sin(x(5))*u1-a2*cos(x(5))*u2;
dx4=-a1*cos(x(5))*u1-a2*sin(x(5))*u2+g;
dx6=a3*u2;

sys(1)=dx2;
sys(2)=dx4;
sys(3)=dx6;
sys(4)=x(5);