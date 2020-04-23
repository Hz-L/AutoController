clear all;

h = 0.01; L = 40/h;
Ap = [0 1; -6 -7]; Bp = [0; 8];
Am = [0 1; -10 -5]; Bm = [0; 2];
Sz = size(Bp); n = Sz(1); m = Sz(2);

P = [3 1; 1 1];
R1 = 1*eye(m); R2 = 1*eye(m);
F0 = zeros(m, n); K0 = zeros(m);
yr0 = zeros(m, 1); u0 = zeros(m, 1); e0 = zeros(n, 1);
xp0 = zeros(n, 1); xm0 = zeros(n, 1);

for k = 1:L
    time(k) = k*h;
    yr(k) = 1*sin(0.01*pi*time(k)) + 4*sin(0.2*pi*time(k)) + sin(1*pi*time(k));
    xp(:, k) = xp0 + h*(Ap*xp0 + Bp*u0);
    xm(:, k) = xm0 + h*(Am*xm0 + Bm*yr0);
    e(:, k) = xm(:, k) - xp(:, k);
    
    F = F0 + h*(R1*Bm'*P*e0*xp0');
    K = K0 + h*(R2*Bm'*P*e0*yr0');
    u(:, k) = K*yr(k) + F*xp(:, k);
    parae(1, k) = norm(Am - Ap - Bp*F);
    parae(2, k) = norm(Bm - Bp*K);
    
    yr0 = yr(:, k); u0 = u(:, k); e0 = e(:, k);
    xp0 = xp(:, k); xm0 = xm(:, k);
    F0 = F; K0 = K;
end

figure(1);
subplot(2, 1, 1);
plot(time, xm(1, :), 'r', time, xp(1, :), ':');
xlabel('t'); ylabel('x_m_1(t)¡¢x_p_1(t)');
legend('x_m_1(t)', 'x_p_1(t)');
subplot(2, 1, 2);
plot(time, xm(2, :), 'r', time, xp(2, :), ':');
xlabel('t'); ylabel('x_m_2(t)¡¢x_p_2(t)');
legend('x_m_2(t)', 'x_p_2(t)');
figure(2)
plot(time, parae(1, :), ':', time, parae(2, :), 'r');
xlabel('t'); ylabel('²ÎÊýÊÕÁ²Æ«²îe');
legend('||A_m - A_p - B_p*F||_2', '||B_m - B_p*K||_2');