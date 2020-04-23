clear all;

h = 0.02; M = 40/h;
nump = [1 4]; denp = [1 9 24 20];
[Ap, Bp, Cp, Dp] = tf2ss(nump, denp); n = length(denp) - 1;
numm = 2*[1 1.5]; denm = [1 6 11 6];
[Am, Bm, Cm, Dm] = tf2ss(numm, denm);

L = [1 2];
Df = conv(L, numm);
Af = [[zeros(n - 2, 1), eye(n - 2)]; -Df(n: -1: 2)];
Bf = [zeros(n - 2, 1); 1];

yr0 = 0; yp0 = 0; u0 = 0; e0 = 0;
v10 = zeros(n - 1, 1); v20 = zeros(n - 1, 1);
xp0 = zeros(n, 1); xm0 = zeros(n, 1);
theta0 = zeros(2*n, 1);
zeta0 = zeros(2*n, 1);
r = 1; yr = r*[ones(1, M/4) -ones(1, M/4) ones(1, M/4) -ones(1, M/4)];

Gamma = 10*eye(2*n);
for k = 1:M
    time(k) = k*h;
    xp(:, k) = xp0 + h*(Ap*xp0 + Bp*u0);
    yp(k) = Cp*xp(:, k) + Dp*u0;
    
    xm(:, k) = xm0 + h*(Am*xm0 + Bm*yr0);
    ym(k) = Cm*xm(:, k) + Dm*yr0;
    e(k) = ym(k) - yp(k);
    
    v1 = v10 + h*(Af*v10 + Bf*u0);
    v2 = v20 + h*(Af*v20 + Bf*yp0);
    
    phi0 = [yr0; v10; yp0; v20];
    zeta = zeta0 + h*(-L(2)*zeta0 + phi0);
    theta(:, k) = theta0 + h*e0*Gamma*zeta0;
    phi = [yr(k); v1; yp(k); v2];
    u(k) = theta(:, k)'*phi + e(k)*zeta'*Gamma*zeta;
    
    yr0 = yr(k); yp0 = yp(k); u0 = u(k); e0 = e(k);
    v10 = v1; v20 = v2;
    xp0 = xp(:, k); xm0 = xm(:, k);
    phi0 = phi; theta0 = theta(:, k); zeta0 = zeta;
end
subplot(2, 1, 1);
plot(time, ym, 'r', time, yp, ':');
xlabel('t'); ylabel('y_m(t)¡¢y_p(t)');
legend('y_m(t)', 'y_p(t)');
subplot(2, 1, 2);
plot(time, u);
xlabel('t'); ylabel('u(t)');
