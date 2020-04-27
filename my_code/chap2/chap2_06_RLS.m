%������С���˲������ƣ�RLS��

a=[1 -1.5 0.7]'; b=[1 0.5]'; d=3; %�������
na=length(a)-1; nb=length(b)-1; %na��nbΪA��B�״�

L=length(InputData.data); %���泤��
uk=zeros(d+nb,1); %�����ֵ��uk(i)��ʾu(k-i)
yk=zeros(na,1); %�����ֵ
u=InputData.data;  %randn(L,1); %������ð���������
%xi=sqrt(0.1)*randn(L,1); %����������

theta=[a(2:na+1);b]; %���������ֵ

thetae_1=zeros(na+nb+1,1); %thetae��ֵ
P=10^6*eye(na+nb+1); 
for k=1:L
    phi=[-yk;uk(d:d+nb)]; %�˴�phiΪ������
    y(k)=OutputData.data(k);%phi'*theta+xi(k); %�ɼ��������
    
    %������С���˷�
    K=P*phi/(1+phi'*P*phi);
    thetae(:,k)=thetae_1+K*(y(k)-phi'*thetae_1);
    P=(eye(na+nb+1)-K*phi')*P;
    
    %��������
    thetae_1=thetae(:,k);
    
    for i=d+nb:-1:2
        uk(i)=uk(i-1);
    end
    uk(1)=u(k);
    
    for i=na:-1:2
        yk(i)=yk(i-1);
    end
    yk(1)=y(k);
end
plot([1:L],thetae); %line([1,L],[theta,theta]);
xlabel('k'); ylabel('��������a��b');
legend('a_1','a_2','b_0','b_1'); axis([0 L -2 1.5]);