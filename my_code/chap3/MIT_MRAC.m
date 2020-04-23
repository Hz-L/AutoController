clear all;
h = 0.1; L = 100/h;
num = 1; den_p = [1 1 1];den_m = [1 1 1]; n_m = length(den_m) - 1; n_p = length(den_p) - 1;
kp = 1; [Ap, Bp, Cp, Dp] = tf2ss(kp*num, den_p);
km = 1; [Am, Bm, Cm, Dm] = tf2ss(km*num, den_m);

gamma = 0.1;
yr0 = 0; u0 = 0; e0 = 0; ym0 = 0;
xp0 = zeros(n_p, 1); xm0 = zeros(n_m, 1);
kc0 = 3;
r = 1.2; 
for k = 1:L
    yr = r*sin(0.04*k);
    time(k) = k*h;
    xp(:, k) = xp0 + h*(Ap*xp0 + Bp*u0);
    yp(k) = Cp*xp(:, k) + Dp*u0;
    
    xm(:, k) = xm0 + h*(Am*xm0 + Bm*yr0);
    ym(k) = Cm*xm(:, k) + Dm*yr0;
    
    e(k) = ym(k) - yp(k);
    kc = kc0 + h*gamma*e0*ym0;
    u(k) = kc*yr;
    
    yr0 = yr; u0 = u(k); e0 = e(k); ym0 = ym(k);
    xp0 = xp(:, k); xm0 = xm(:, k);
    kc0 = kc;
    kc_list(k) = kc;
end
plot(time, ym, 'r', time, yp, ':', time, kc_list);
xlabel('t'); ylabel('y_m(t), y_p(t)');
legend('y_m(t)', 'y_p(t)', 'kc');