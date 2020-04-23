a = [1 -0.4]; b = 1; c = [1 -0.3];
na = length(a) - 1; nb = length(b) - 1; nc = length(c) - 1;
n = max(max(na, nb), nc);
a0 = [a zeros(1, n - na)]; b0 = [b zeros(1, n - nb)]; c0 = [c zeros(1, n - nc)];
deltau2 = 1; deltav2 = 1;

for i = 1:n+1
    p(i, n+1) = a0(i);
    qg(i, n+1) = b0(i);
    qh(i, n+1) = c0(i);
end

for k = n:-1:1
    for i = 1:k
        p(i, k) = (p(1, k+1)*p(i, k+1) - p(k+1, k+1)*p(k+2-i, k+1))/p(1, k+1);
        qg(i, k) = (p(1, k+1)*qg(i, k+1) - qg(k+1, k+1)*p(k+2-i, k+1))/p(1, k+1);
        qh(i, k) = (p(1, k+1)*qh(i, k+1) - qh(k+1, k+1)*p(k+2-i, k+1))/p(1, k+1);
    end
end

deltax2 = 0; deltae2 = 0;
for k = 1:n+1
    deltax2 = deltax2 + qg(k, k)^2/p(1, k);
    deltae2 = deltae2 + qh(k, k)^2/p(1, k);
end
deltax2 = deltax2*deltau2/a(1); % D[x(k)]
deltae2 = deltae2*deltae2/a(1); % D[e(k)]
ns = sqrt(deltae2/deltax2);
