clear all;
close all;
N=4;
 
x=0:0.1:100;
for i=1:N+1
    f(i)=100/N*(i-1);
end
u=gaussmf(x,[10,0]);
gtext('E');
hold on;
 
figure(1);
plot(x,u,'b');
u=gaussmf(x,[10,25]);
plot(x,u,'c');gtext('D');hold on;
u=gaussmf(x,[10,50]);
plot(x,u,'r');gtext('C');hold on;
u=gaussmf(x,[10,75]);
plot(x,u,'k');gtext('B');hold on;
 
u=gaussmf(x,[10,100]);
plot(x,u,'y');gtext('A');hold on;
xlabel('x');
ylabel('Degree of membership');
