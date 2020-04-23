L = 60;
x1 = 1; x2 = 1; x3 = 1; x4 = 0;
S = 1;

M = zeros(L, 1);
u = zeros(L, 1);
for k = 1:L
    M(k) = xor(x3, x4);
    IM = xor(M(k), S);
    if IM == 0
        u(k) = -1;
    else
        u(k) = 1;
    end
    
    S = not(S);
    
    x4 = x3; x3 = x2; x2 = x1; x1 = M(k);
end

subplot(2, 1, 1);
stairs(M), grid;
axis([0 L/2 -0.5 1.5]); xlabel('k'); ylabel('M序列幅值'); title('M序列');
subplot(2, 1, 2);
stairs(u), grid;
axis([0 L -1.5 1.5]); xlabel('k'); ylabel('逆M序列幅值'); title('逆M序列');