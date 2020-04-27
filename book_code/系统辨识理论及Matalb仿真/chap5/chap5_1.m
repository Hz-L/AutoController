figure(1); 
sys=tf([1],[60,1],'inputdelay',80); 
[y,t]=step(sys);
line(t,y),grid;
xlabel('time');ylabel('y');
