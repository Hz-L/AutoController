% ����������ɫ�������еĲ���
L = 500;%���泤��
d = [1 -1.5 0.7 0.1];
c = [1 0.5 0.2];
nd = length(d) - 1;
nc = length(c) - 1;
xik = zeros(nc, 1);
ek = zeros(nd, 1);
xi = randn(L, 1);

e = zeros(L, 1);
for k = 1:L
    e(k) = -d(2:nd+1)*ek + c*[xi(k); xik];
    
    for i = nd:-1:2
        ek(i) = ek(i - 1);
    end
    ek(1) = e(k);
    
    for i = nc:-1:2
        xik(i) = xik(i - 1);
    end
    xik(1) = xi(k);
end

subplot(2, 1, 1);
plot(xi);
xlabel('k'); ylabel('������ֵ'); title('����������');
subplot(2, 1, 2);
plot(e);
xlabel('e'); ylabel('������ֵ'); title('��ɫ��������');