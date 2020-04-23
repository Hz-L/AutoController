% BP�������ʶ
clear all; close all;

[t,x] = ode45(@nonsys,[0 20],[1.0 1.0]); % ��΢�ַ���
y = sin(x(:,1)+x(:,2));
[N,n] = size(x); % NΪ���ݸ�����nΪϵͳ�����ά��

% ����BP�������
m = 10; % mΪ������ڵ���
eta = 0.5; % ѧϰ����
alpha = 0.05; % ��������
E = 0.02; % ȫ������
% w1k1 = rands(m,n); % �������������Ȩֵ�ĳ�ֵ: w1ki��ʾw1(k-i)
w1k1 = [-0.7027    0.9150
    0.3162   -0.9486
    0.2680    0.9422
   -0.5414   -0.4048
   -0.6355    0.0501
   -0.6673    0.7247
   -0.7008    0.7928
   -0.5945   -0.6220
    0.9099    0.3214
   -0.9682    0.8825];
w1k2 = w1k1; 
% w2k1 = rands(1,m); % �������������Ȩֵ�ĳ�ֵ: w2ki��ʾw2(k-i)
w2k1 = [0.9514 -0.7841 -0.6422 0.4931 -0.9011 -0.8574 -0.0217 0.6998 0.9941 -0.9912];
w2k2 = w2k1; 

eg1 = 100*E; 
eg = 10; % ��ʼ��ȫ�����
num = 0; % ��ʼ��ѵ������
M = 100; % ���ѵ������
tic
while(eg >= E) % ��ȫ��������ѵ������
%while(num < M) % ֱ���趨ѵ������
    num = num+1;
    es(num) = 0;
    for k = 1:N        
        % ����BP�������
        O1 = x(k,:)';    
        net2 = w1k1*O1;
        O2 = 1./(1+exp(-net2));    
        ym(k) = w2k1*O2; 
    
        e(k) = y(k) - ym(k); % ģ�����
        es(num) = es(num) + e(k)^2/2; % �ۼ����ƽ��   

        % ѵ��BP����
        dw2 = eta*e(k)*O2'; 
        w2 = w2k1 + dw2 + alpha*(w2k1-w2k2); % w2(k)

        df = exp(-net2)./(1+exp(-net2)).^2; % ���������ĵ���
        dw1 = eta*e(k)*w2k1'.*df*O1'; % ������ʽ����
        w1 = w1k1 + dw1 + alpha*(w1k1-w1k2); % w1(k)
    
        % ��������
        w1k2 = w1k1; w1k1 = w1;
        w2k2 = w2k1; w2k1 = w2;
    end
    eg = es(num);
    if eg <= eg1
        eg1 = eg1 - E/500;
        % fprintf('eg = %f      num = %d\n', eg, num);
    end
end 
toc
figure(1)
plot(t,y,'b',t,ym,'r--')
xlabel('ʱ��t���룩');
ylabel('ʵ�����/�������');
legend('ʵ�����', '�������','Location','southwest');
figure(2)
plot(1:num,es,'b')
xlabel('ѵ������������');
ylabel('ȫ����� E=0.02');