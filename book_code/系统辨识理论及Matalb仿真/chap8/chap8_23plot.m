close all;

figure(1);
subplot(311);
plot(t,sin(2*pi*t),'r',t,y(:,1),'k','linewidth',2);
xlabel('Time/s');ylabel('position estimation');
legend('ideal position','position tracking');
subplot(312);
plot(t,2*pi*cos(2*pi*t),'r',t,y(:,2),'k','linewidth',2);
xlabel('Time/s');ylabel('speed estimation');
legend('ideal speed','speed tracking');
subplot(313);
plot(t,-2*pi*2*pi*sin(2*pi*t),'r',t,y(:,3),'k','linewidth',2);
xlabel('Time/s');ylabel('acceleration tracking');
legend('ideal acceleration','acceleration tracking');