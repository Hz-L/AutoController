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
global rou nma
rou=800;
nma=5; 

sizes = simsizes;
sizes.NumContStates  = 6;
sizes.NumDiscStates  = 0;
sizes.NumOutputs     = 6;
sizes.NumInputs      = 17;
sizes.DirFeedthrough = 1;
sizes.NumSampleTimes = 1;
sys = simsizes(sizes);
x0  = [zeros(6,1)];
str = [];
ts  = [0 0];
V=zeros(6,1);
function sys=mdlDerivatives(t,x,u)
global rou nma

x1=u(1);x2=u(2);
dx1=u(9);dx2=u(10);
ut=u(17);
%Calculating integration of W,I
P=zeros(6,6);
Q=zeros(6,1);

p11=x1^2;p12=x1*x2;p13=0;p14=0;p15=x1*ut;p16=0;
p21=x2*x1;p22=x2^2;p23=0;p24=0;p25=x2*ut;p26=0;
p31=0;p32=0;p33=x1^2;p34=x1*x2;p35=0;p36=x1*ut;
p41=0;p42=0;p43=x2*x1;p44=x2^2;p45=0;p46=x2*ut;
p51=ut*x1;p52=ut*x2;p53=0;p54=0;p55=ut^2;p56=0;
p61=0;p62=0;p63=ut*x1;p64=ut*x2;p65=0;p66=ut^2;
P = [p11 p12 p13 p14 p15 p16;
     p21 p22 p23 p24 p25 p26;
     p31 p32 p33 p34 p35 p36;
     p41 p42 p43 p44 p45 p46;
     p51 p52 p53 p54 p55 p56;
     p61 p62 p63 p64 p65 p66];    

Q=[x1*dx1;x2*dx1;x1*dx2;x2*dx2;ut*dx1;ut*dx2];
    
W=-P;
I=Q;

ui=x;
for i=1:6
   y(i)=rou*(1-exp(-nma*ui(i)))/(1+exp(-nma*ui(i)));  %Gaussian function
end
V=[y(1) y(2) y(3) y(4) y(5) y(6)]';
x=W*V+I;%du/dt
sys=x;
function sys=mdlOutputs(t,x,u)
global rou nma

ui=x;
for i=1:1:6
    V(i)=rou*(1-exp(-nma*ui(i)))./(1+exp(-nma*ui(i)));
end
sys(1:6)=V;