%Sugeno type fuzzy control for single inverted pendulum
clear all;
close all;

P=[-10-10i;-10+10i];     %Stable pole point

A1=[0,1;17.2941,0];
B1=[0;-0.1765];
F1=place(A1,B1,P)

A2=[0,1;14.4706,0];
B2=[0;-0.1765];
F2=place(A2,B2,P)

A3=[0,1;5.8512,0];
B3=[0;-0.0779];
F3=place(A3,B3,P)

A4=[0,1;7.2437,0.5399];
B4=[0;-0.0779];
F4=place(A4,B4,P)

A5=[0,1;7.2437,-0.5399];
B5=[0;-0.0779];
F5=place(A5,B5,P)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
tc=newfis('tc','sugeno');
tc=addvar(tc,'input','theta',[-pi,pi]);
tc=addmf(tc,'input',1,'NG','gaussmf',[1.2,-3]);
tc=addmf(tc,'input',1,'ZR','gaussmf',[1.2,0]);
tc=addmf(tc,'input',1,'PO','gaussmf',[1.2,3]);

tc=addvar(tc,'input','omega',[-5,5]);
tc=addmf(tc,'input',2,'NG','gaussmf',[1.8,-5]);
tc=addmf(tc,'input',2,'ZR','gaussmf',[1.8,0]);
tc=addmf(tc,'input',2,'PO','gaussmf',[1.8,5]);

tc=addvar(tc,'output','u',[-200,200]);
tc=addmf(tc,'output',1,'No.1','linear',[F1(1),F1(2) 0]);
tc=addmf(tc,'output',1,'No.2','linear',[F2(1),F2(2) 0]);
tc=addmf(tc,'output',1,'No.3','linear',[F3(1),F3(2) 0]);
tc=addmf(tc,'output',1,'No.4','linear',[F4(1),F4(2) 0]);
tc=addmf(tc,'output',1,'No.5','linear',[F5(1),F5(2) 0]);

rulelist1=[1 1 4 1 1;
          1 2 3 1 1;
          1 3 5 1 1;
          2 1 2 1 1;
          2 2 1 1 1;
          3 1 5 1 1;
          3 2 3 1 1;
          3 3 4 1 1];
tc=addrule(tc,rulelist1);

model=newfis('model','sugeno');
model=addvar(model,'input','theta',[-pi,pi]);
model=addmf(model,'input',1,'NG','gaussmf',[1.2,-3]);
model=addmf(model,'input',1,'ZR','gaussmf',[1.2,0]);
model=addmf(model,'input',1,'PO','gaussmf',[1.2,3]);

model=addvar(model,'input','omega',[-5,5]);
model=addmf(model,'input',2,'NG','gaussmf',[1.8,-5]);
model=addmf(model,'input',2,'ZR','gaussmf',[1.8,0]);
model=addmf(model,'input',2,'PO','gaussmf',[1.8,5]);

model=addvar(model,'input','u',[-200,200]);
model=addmf(model,'input',3,'Any','gaussmf',[1.5,-5]);

model=addvar(model,'output','d_theta',[0,2]);
model=addmf(model,'output',1,'No.1','linear',[0 1 0 0]);
model=addmf(model,'output',1,'No.2','linear',[0 1 0 0]);
model=addmf(model,'output',1,'No.3','linear',[0 1 0 0]);
model=addmf(model,'output',1,'No.4','linear',[0 1 0 0]);
model=addmf(model,'output',1,'No.5','linear',[0 1 0 0]);

model=addvar(model,'output','d_omega',[-1,20]);
model=addmf(model,'output',2,'No.1','linear',[A1(2,1),0,B1(2),0]);
model=addmf(model,'output',2,'No.2','linear',[A2(2,1),0,B2(2),0]);
model=addmf(model,'output',2,'No.3','linear',[A3(2,1),0,B3(2),0]);
model=addmf(model,'output',2,'No.4','linear',[A4(2,1),A4(2,2),B4(2),0]);
model=addmf(model,'output',2,'No.5','linear',[A5(2,1),A5(2,2),B5(2),0]);

rulelist2=[1 1 0 4 4 1 1;
           1 2 0 3 3 1 1;
           1 3 0 5 5 1 1;
           2 1 0 2 2 1 1;
           2 2 0 1 1 1 1;
           2 3 0 2 2 1 1;
           3 1 0 5 5 1 1;
           3 2 0 3 3 1 1;
           3 3 0 4 4 1 1];
model=addrule(model,rulelist2);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
T=0.005;
x=[0.50;0];  %Initial state

for k=1:1:500
   time(k)=k*T;
   
   u(k)=(-1)*evalfis([x(1),x(2)],tc);    %u=-F*x
   
   dx=evalfis([x(1),x(2),u(k)],model)';  %dx=A*x+B*u
   
   x=x+T*dx;
   x1(k)=x(1);
   x2(k)=x(2);
end   
figure(1);
subplot(211);
plot(time,x1,'k','linewidth',2);
xlabel('time(s)'),ylabel('Angle');
subplot(212);
plot(time,x2,'k','linewidth',2);
xlabel('time(s)'),ylabel('Angle rate');

figure(2);
plot(time,u,'k','linewidth',2);
xlabel('time(s)'),ylabel('Control input');

figure(3);
subplot(211);
plotmf(tc,'input',1);
subplot(212);
plotmf(tc,'input',2);

showrule(tc);
showrule(model);