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
sizes.NumContStates  = 4;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      = 2;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 0;
sys=simsizes(sizes);
x0=[-pi/2,0,0,0];
str=[];
ts=[];
function sys=mdlDerivatives(t,x,u)
tol=[u(1);u(2)];

q1=x(1);dq1=x(2);
q2=x(3);dq2=x(4);

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
a=[alfa,beta,epc,eta];

H=[alfa+2*epc*cos(q2)+2*eta*sin(q2),beta+epc*cos(q2)+eta*sin(q2);
   beta+epc*cos(q2)+eta*sin(q2),beta];
C=[(-2*epc*sin(q2)+2*eta*cos(q2))*dq2,(-epc*sin(q2)+eta*cos(q2))*dq2;
   (epc*sin(q2)-eta*cos(q2))*dq1,0];
% G=[epc*e2*cos(q1+q2)+eta*e2*sin(q1+q2)+(alfa-beta+e1)*e2*cos(q1);
%    epc*e2*cos(q1+q2)+eta*e2*sin(q1+q2)];
G=[epc*e2*cos(q1+q2)+eta*e2*sin(q1+q2)+(alfa-beta)*e2*cos(q1);
   epc*e2*cos(q1+q2)+eta*e2*sin(q1+q2)];
S=inv(H)*(tol-C*[dq1;dq2]-G);

sys(1)=x(2);
sys(2)=S(1);
sys(3)=x(4);
sys(4)=S(2);
function sys=mdlOutputs(t,x,u)
tol=[u(1);u(2)];

q1=x(1);dq1=x(2);
q2=x(3);dq2=x(4);

m1=1;l1=1;
lc1=1/2;I1=1/12;

me=3;lce=1;Ie=2/5;deltae=0;
g=9.8;
e1=m1*l1*lc1-I1-m1*l1^2;e2=g/l1;

alfa=I1+m1*lc1^2+Ie+me*lce^2+me*l1^2;
beta=Ie+me*lce^2;
epc=me*l1*lce*cos(deltae);
eta=me*l1*lce*sin(deltae);

%alfa=6.7;beta=3.4;epc=3.0;eta=0;
a=[alfa,beta,epc,eta];

H=[alfa+2*epc*cos(q2)+2*eta*sin(q2),beta+epc*cos(q2)+eta*sin(q2);
   beta+epc*cos(q2)+eta*sin(q2),beta];
C=[(-2*epc*sin(q2)+2*eta*cos(q2))*dq2,(-epc*sin(q2)+eta*cos(q2))*dq2;
   (epc*sin(q2)-eta*cos(q2))*dq1,0];
G=[epc*e2*cos(q1+q2)+eta*e2*sin(q1+q2)+(alfa-beta)*e2*cos(q1);
   epc*e2*cos(q1+q2)+eta*e2*sin(q1+q2)];
S=inv(H)*(tol-C*[dq1;dq2]-G);

ddq1=S(1);
ddq2=S(2);

sys(1)=x(1);
sys(2)=x(2);
sys(3)=S(1);
sys(4)=x(3);
sys(5)=x(4);
sys(6)=S(2);