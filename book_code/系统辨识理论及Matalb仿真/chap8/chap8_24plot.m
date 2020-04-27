close all;

figure(1);
subplot(211);
plot(t,a(:,1),'r',t,a(:,2),'k','linewidth',2);
xlabel('Time/s');ylabel('acceleration estimation');
subplot(212);
plot(t,a(:,1)-a(:,2),'k','linewidth',2);
xlabel('Time/s');ylabel('acceleration estimation error');