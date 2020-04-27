clear all;
close all;

n=8;           % 移位寄存器的个数
A=4;           % M序列的输出幅值，1->A,0->+A
ts=0.10;       % 时钟周期（即采样时间）

N=1000;        % 输出的个数
%Generate M-sequence
ut=chap8_19prbs(n,A,N);

G=tf([2],[20 21 1],'inputdelay',0.8);
t=0:ts:N*ts-ts;
y=lsim(G, ut, t);  %lsim函数求模型输出

figure(1);
stairs(t,ut,'r');
figure(2);
plot(t,y,'r');

save de2_file t N ut y;