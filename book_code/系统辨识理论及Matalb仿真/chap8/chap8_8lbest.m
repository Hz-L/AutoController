function f =evaluate_localbest(x1,x2,x3)%������ӻ��������еľֲ����Ÿ���
K0=[x1;x2;x3];
K1=[chap8_8func(x1),chap8_8func(x2),chap8_8func(x3)];
[maxvalue index]=max(K1);
plocalbest=K0(index,:);
f=plocalbest;