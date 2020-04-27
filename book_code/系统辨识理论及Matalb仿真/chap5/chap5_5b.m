% Closed-loop system identification with frequency test (2008/1/31)
clear all;
close all;

load saopin_data;  %Load y with different Frequency
ts=0.001;
Am=0.5;
kk=0;
for F=0.5:0.5:8
kk=kk+1;
FF(kk)=F;

for i=1001:1:2000
    fai(1,i-1000) = sin(2*pi*F*i*ts);
    fai(2,i-1000) = cos(2*pi*F*i*ts);
end
Fai=fai';

fai_in(kk)=0;

Y_out=Y(kk,1001:1:2000)';
cout=inv(Fai'*Fai)*Fai'*Y_out;
fai_out(kk)=atan(cout(2)/cout(1));      % Phase Frequency(Deg.)
Af(kk)=sqrt(cout(1)^2+cout(2)^2);       % Magnitude Frequency(dB)

mag_e(kk)=20*log10(Af(kk)/Am);            % in dB.
ph_e(kk)=(fai_out(kk)-fai_in(kk))*180/pi; % in Deg.
if ph_e(kk)>0  
   ph_e(kk)=ph_e(kk)-360;
end

end
FF
FF=FF';
%%%%%%%%%%%%%%% Closed system modelling %%%%%%%%%%%%%%%%%%
mag_e1=Af'/Am;              %From dB.to ratio
ph_e1=fai_out'-fai_in';     %From Deg. to rad
hp=mag_e1.*(cos(ph_e1)+j*sin(ph_e1))   %Practical frequency response vector

S=1;
if S==1
    na=3;   %Three ranks
    nb=1;
elseif S==2
    na=3;   %Four ranks
    nb=3;
end

w=2*pi*FF;  % in rad./s
% bb and aa gives real numerator and denominator of transfer function
[bb,aa]=invfreqs(hp,w,nb,na);  % w(in rad./s) contains the frequency values

save model_Gc.mat bb aa;
Gc=tf(bb,aa)   % Transfer function fitting

hf=freqs(bb,aa,w);              % Fited frequency response vector

% Transfer function verify: Getting magnitude and phase of Bode
sysmag=abs(hf);                % ratio.
sysmag1=20*log10(sysmag);      % From ratio to dB
sysph=angle(hf);               % Rad.
sysph1=sysph*180/pi;           % From Rad.to Deg.

% Compare practical Bode and identified Bode
figure(1);
subplot(2,1,1); 
semilogx(w,mag_e,'r',w,sysmag1,'b');grid on;
xlabel('rad./s');ylabel('Mag.(dB.)');
subplot(2,1,2);
semilogx(w,ph_e,'r',w,sysph1,'b');grid on;
xlabel('rad./s');ylabel('Phase(Deg.)');

figure(2);
subplot(2,1,1); 
magError=sysmag1-mag_e';
plot(w,magError,'r');
xlabel('rad./s');ylabel('Mag.(dB.)');
subplot(2,1,2); 
phError=sysph1-ph_e';
plot(w,phError,'r');
xlabel('rad./s');ylabel('Phase(Deg.)');