function [sys,x0,str,ts]=s_function(t,x,u,flag)
switch flag,
case 0,
    [sys,x0,str,ts]=mdlInitializeSizes;
case 3,
    sys=mdlOutputs(t,x,u);
case {2, 4, 9 }
    sys = [];
otherwise
    error(['Unhandled flag = ',num2str(flag)]);
end
function [sys,x0,str,ts]=mdlInitializeSizes
sizes = simsizes;
sizes.NumContStates  = 0;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 3;
sizes.NumInputs      = 4;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
g=9.8;
dx2=u(1);dx4=u(2);dx6=u(3);
x5=u(4);
A=[dx2 dx4-g dx6]';
B=[sin(x5) -cos(x5) 0;-cos(x5) -sin(x5) 0;0 0 1];
Y=B*A;
sys(1)=Y(1,1);
sys(2)=Y(2,1);
sys(3)=Y(3,1);
