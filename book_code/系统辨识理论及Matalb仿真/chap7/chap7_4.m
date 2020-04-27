%Sugeno fuzzy model based control for single link inverted pendulum
clear all;
close all;
warning off;

m=2;M=8;l=0.5;g=9.8;
a=l/(m+M);
A21=g/(4/3*l-a*m*l);
A=[0 1;A21 0];
B2=-a/(4/3*l-a*m*l);
B=[0;B2];

P=[-10-10i;-10+10i];     %Stable pole point
F=place(A,B,P)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
model=newfis('model','sugeno');
model=addvar(model,'input','x1',[-15,15]*pi/180);
model=addmf(model,'input',1,'ZR','trimf',[-15,0,15]*pi/180);

model=addvar(model,'input','x2',[-200,200]*pi/180);
model=addmf(model,'input',2,'ZR','trimf',[-200,0,200]*pi/180);

model=addvar(model,'input','u',[-200,600]);

model=addvar(model,'output','dx',[-200,200]*pi/180);
model=addmf(model,'output',1,'No.1','linear',[0 1 0 0]);

model=addvar(model,'output','ddx',[-200,200]*pi/180);
model=addmf(model,'output',2,'No.1','linear',[A(2,1),A(2,2),B(2) 0]);

rulelist=[1 1 0 1 1 1 1];
model=addrule(model,rulelist);
writefis(model,'out');
out = readfis('out');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ts=0.02;
x=[12,-120]*pi/180;    %From Degree to Radian

for k=1:1:500
   time(k)=k*ts;
  
   u(k)=-F*x';
   dx=evalfis([x(1),x(2),u(k)],out);    %Using fuzzy T-S model "model.fis"
   x=x+ts*dx;
   
   y1(k)=x(1);
   y2(k)=x(2);
end
figure(1);
subplot(211);
plot(time,y1,'k','linewidth',2);
xlabel('time(s)'),ylabel('Angle');
subplot(212);
plot(time,y2,'k','linewidth',2);
xlabel('time(s)'),ylabel('Angle rate');

figure(2);
plot(time,u,'k','linewidth',2);
xlabel('time(s)'),ylabel('Control input');

figure(3);
subplot(211);
plotmf(model,'input',1);
subplot(212);
plotmf(model,'input',2);

figure(4);
gensurf(out);
showrule(model)