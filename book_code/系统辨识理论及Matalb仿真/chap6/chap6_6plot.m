close all;
figure(1);
subplot(611);
plot(t,p(:,3),'r',t,p(:,9),'b');
xlabel('t/s');ylabel('A11 identification');
subplot(612);
plot(t,p(:,4),'r',t,p(:,10),'b');
xlabel('t/s');ylabel('A12 identification');
subplot(613);
plot(t,p(:,5),'r',t,p(:,11),'b');
xlabel('t/s');ylabel('A21 identification');
subplot(614);
plot(t,p(:,6),'r',t,p(:,12),'b');
xlabel('t/s');ylabel('A22 identification');
subplot(615);
plot(t,p(:,7),'r',t,p(:,13),'b');
xlabel('t/s');ylabel('B1 identification');
subplot(616);
plot(t,p(:,8),'r',t,p(:,14),'b');
xlabel('t/s');ylabel('B2 identification');

figure(2);
subplot(611);
plot(t,p(:,3)-p(:,9),'r');
xlabel('t/s');ylabel('A11 identification error');
subplot(612);
plot(t,p(:,4)-p(:,10),'r');
xlabel('t/s');ylabel('A12 identification error');
subplot(613);
plot(t,p(:,5)-p(:,11),'r');
xlabel('t/s');ylabel('A21 identification error');
subplot(614);
plot(t,p(:,6)-p(:,12),'r');
xlabel('t/s');ylabel('A22 identification error');
subplot(615);
plot(t,p(:,7)-p(:,13),'r');
xlabel('t/s');ylabel('B1 identification error');
subplot(616);
plot(t,p(:,8)-p(:,14),'r');
xlabel('t/s');ylabel('B2 identification error');

display('The true value is: 0 1 0 -25 0 133');

P=p(length(p),:);
P(9:14)