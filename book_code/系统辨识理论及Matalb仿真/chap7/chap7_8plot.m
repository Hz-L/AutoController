close all;

figure(1);
subplot(211);
plot(t,x(:,1),'r',t,x(:,2),'k','linewidth',2);
legend('xd','x1');
xlabel('time(s)');ylabel('position tracking');
subplot(212);
plot(t,cos(t),'r',t,x(:,3),'k','linewidth',2);
legend('dxd','x2');
xlabel('time(s)');ylabel('speed tracking');

figure(2);
plot(t,f(:,1),'r',t,f(:,3),'k','linewidth',2);
legend('f','fp');
xlabel('time(s)');ylabel('f approximation');
