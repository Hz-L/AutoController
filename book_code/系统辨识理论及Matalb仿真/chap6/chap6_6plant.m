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
global M
M=3;
sizes = simsizes;
sizes.NumContStates  = 2;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 8;
sizes.NumInputs      = 1;
sizes.DirFeedthrough = 0;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[0.5,0.5];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
global M

ut=u;
if M==1
    A=[-0.9425 12.56;
       -12.56 -0.9425]*(1+0.1*sin(2*pi*0.025*t));
    B=[1;2];
elseif M==2
    A=[0 1;0 -25]*(1+0.1*sin(0.25*2*pi*t));
    B=[0;133]*(1+0.1*sin(0.1*2*pi*t));
elseif M==3
    A=[0 1;0 -25];
    B=[0;133];
end
sys=A*x+B*ut;
function sys=mdlOutputs(t,x,u)
global M
if M==1
    A=[-0.9425 12.56;
       -12.56 -0.9425]*(1+0.1*sin(2*pi*0.025*t));
    B=[1;2];
elseif M==2
    A=[0 1;0 -25]*(1+0.1*sin(0.25*2*pi*t));
    B=[0;133]*(1+0.1*sin(0.1*2*pi*t));
elseif M==3
    A=[0 1;0 -25];
    B=[0;133];
end

sys(1)=x(1);
sys(2)=x(2);
sys(3)=A(1,1);
sys(4)=A(1,2);
sys(5)=A(2,1);
sys(6)=A(2,2);
sys(7)=B(1);
sys(8)=B(2);