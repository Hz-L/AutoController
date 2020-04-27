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
sizes.NumOutputs     = 8;
sizes.NumInputs      = 6;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[];
str=[];
ts=[];
function sys=mdlOutputs(t,x,u)
q1=u(1);dq1=u(2);ddq1=u(3);
q2=u(4);dq2=u(5);ddq2=u(6);

m1=1;l1=1;
lc1=1/2;I1=1/12;

me=3;lce=1;Ie=2/5;deltae=0;
g=9.8;
e1=m1*l1*lc1-I1-m1*l1^2;e2=g/l1;

alfa=I1+m1*lc1^2+Ie+me*lce^2+me*l1^2;
beta=Ie+me*lce^2;
epc=me*l1*lce*cos(deltae);
eta=me*l1*lce*sin(deltae);

%alfa=6.7333;beta=3.4;epc=3.0;eta=0;
a=[alfa,beta,epc, eta];

Y=[ddq1+e2*cos(q1),ddq2-e2*cos(q1),2*cos(q2)*ddq1+cos(q2)*ddq2-2*sin(q2)*dq2*dq1-sin(q2)*dq2*dq2+e2*cos(q1+q2),2*sin(q2)*ddq1+sin(q2)*ddq2+2*cos(q2)*dq2*dq1+cos(q2)*dq2*dq2+e2*sin(q1+q2);
   0,ddq1+ddq2,cos(q2)*ddq1+sin(q2)*dq1*dq1+e2*cos(q1+q2),sin(q2)*ddq1-cos(q2)*dq1*dq1+e2*sin(q1+q2)];

%toll=Y*a';

sys(1)=Y(1,1);
sys(2)=Y(1,2);
sys(3)=Y(1,3);
sys(4)=Y(1,4);
sys(5)=Y(2,1);
sys(6)=Y(2,2);
sys(7)=Y(2,3);
sys(8)=Y(2,4);