close all;
w= logspace(-1,1)
num = [1]
den = [1,5]
H=freqs(num,den,w)

[num,den] = invfreqs(H,w,0,1);
G=tf(num,den)
