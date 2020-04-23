% ����FFDL��MIMO��ģ������Ӧ����
clear all; close all;

m = 2; % m����m���ϵͳ
ny = 2; nu = 2; % ϵͳ�ṹ����

N = 800; % ���泤��
Ly = 1; Lu = 1; % ϵͳα����
uk = zeros(m,nu); % ���������ֵ��uk(1,i)��ʾu1(k-i);
yk = zeros(m,ny); % ϵͳ�����ֵ
duk = zeros(m,Lu); % ��������������ֵ
dyk = zeros(m,Ly); % ϵͳ���������ֵ
yr(1,1) = 5*sin(0/50) + 2*cos(0/20); % ���������ֵ
yr(2,1) = 2*sin(0/50) + 5*cos(0/20);

% ���ÿ���������
Phihk = [zeros(m,m*Ly), [1.5  0.1; 0.1  1.5], zeros(m,m*(Lu-1))]; Phih0 = Phihk(:,Ly*m+1:(Ly+1)*m);
eta = 0.5;
mu = 1;
rho = 0.5*ones(Ly+Lu,1);
lambda = 0.01;
b1 = 0.3;
b2 = 1.3;
alpha = 1.5;

for k = 1:N
    time(k) = k;
    
    % ϵͳ���
    y(1,k) =  -0.8*sin(yk(1,1)) - 0.16*yk(1,2)...
             + uk(1,1) + 1.7*uk(1,2) - 0.5*uk(2,2) + uk(2,2)/(1+uk(2,2)^2);
    y(2,k) = -0.8*yk(2,1) - 0.16*yk(2,2)...
             + uk(2,1) + 2*uk(2,2) + 0.3*uk(1,2) + uk(1,2)/(1+uk(1,2)^2);

    % �������
    yr(1,k+1) = 2*sin(k/50) + 5*cos(k/20);
    yr(2,k+1) = 5*sin(k/50) + 2*cos(k/20);
    
    % ��������
    dy(:,k) = y(:,k) - yk(:,1); 
    dHk = [];
    for i = 1:Ly
        dHk = [dHk; dyk(:,i)];
    end
    for i = 1:Lu
        dHk = [dHk; duk(:,i)];
    end
    Phih(:,:,k) = Phihk + eta*(dy(:,k)-Phihk*dHk)*dHk'/(mu+norm(dHk)^2);
    for i = 1:m
        for j = 1:m
            if i==j
                if abs(Phih(i,Ly*m+j,k))<b2 | abs(Phih(i,Ly*m+j,k))>alpha*b2 | sign(Phih(i,Ly*m+j,k))~=sign(Phih0(i,j))
                    Phih(i,Ly*m+j,k) = Phih0(i,j);
                end
            else
                if abs(Phih(i,Ly*m+j,k))>b1 | sign(Phih(i,Ly*m+j,k))~=sign(Phih0(i,j))
                    Phih(i,Ly*m+j,k) = Phih0(i,j);
                end
            end
        end
    end
    for p = 1:Ly+Lu
        for i = 1:m
            for j = 1:m
                phih((p-1)*m*m+(i-1)*m+j,k) = Phih(i,(p-1)*m+j,k);
            end
        end
    end
    
    % ����������
    sumrpdy = zeros(m,1);
    for i = 1:Ly
        if i == 1
            sumrpdy = sumrpdy + rho(i)*Phih(:,(i-1)*m+1:i*m,k)*dy(:,k);
        else
            sumrpdy = sumrpdy + rho(i)*Phih(:,(i-1)*m+1:i*m,k)*dyk(:,i-1);
        end
    end
    sumrpdu = zeros(m,1);
    for i = Ly+2:Ly+Lu
        sumrpdu = sumrpdu + rho(i)*Phih(:,(i-1)*m+1:i*m,k)*duk(:,-Ly+i-1);
    end
    du(:,k) = Phih(:,Ly*m+1:(Ly+1)*m,k)'*(rho(Ly+1)*(yr(:,k+1)-y(:,k)) - sumrpdy - sumrpdu)/(lambda+norm(Phih(:,Ly*m+1:(Ly+1)*m,k))^2);
    u(:,k) = uk(:,1) + du(:,k);
    
    % ��������
    Phihk = Phih(:,:,k);
    
    for i = Ly:-1:2
        dyk(:,i) = dyk(:,i-1);
    end
    dyk(:,1) = dy(:,k);
    
    for i = Lu:-1:2
        duk(:,i) = duk(:,i-1);
    end
    duk(:,1) = du(:,k);
    
    for i = nu:-1:2
        uk(:,i) = uk(:,i-1);
    end
    uk(:,1) = u(:,k);
    
    for i = ny:-1:2
        yk(:,i) = yk(:,i-1);
    end
    yk(:,1) = y(:,k);
end
figure(1);
plot(time,yr(1,1:N),'r--',time,y(1,:),'b');
xlabel('k'); ylabel('�����������'); %axis([0 N -8 8]);
legend('y_{r1}(k)','y_1(k)','Location','best');
figure(2);
plot(time,yr(2,1:N),'r--',time,y(2,:),'b');
xlabel('k'); ylabel('�����������'); %axis([0 N -8 8]);
legend('y_{r2}(k)','y_2(k)','Location','best');
figure(3)
plot(time,u);
xlabel('k'); ylabel('��������'); %axis([0 N -5 4]);
legend('u_1(k)','u_2(k)','Location','best');
if Ly==1 & Lu==1
    figure(4)
    plot(time,phih(1:m*m,:),'LineWidth',1.5);
    % hold on; plot(time,0.3*ones(1,N),time,1.3*ones(1,N),time,1.95*ones(1,N));
    xlabel('k'); ylabel('α�ſ˱Ⱦ������ֵ'); axis([0 N -0.2 0.7]);
    legend('\phi_{111}(k)����ֵ','\phi_{121}(k)����ֵ','\phi_{211}(k)����ֵ','\phi_{221}(k)����ֵ','Location','best');
    figure(5)
    plot(time,phih(m*m+1:end,:),'LineWidth',1.5);
    % hold on; plot(time,0.3*ones(1,N),time,1.3*ones(1,N),time,1.95*ones(1,N));
    xlabel('k'); ylabel('α�ſ˱Ⱦ������ֵ'); %axis([0 N 0 2]);
    legend('\phi_{112}(k)����ֵ','\phi_{122}(k)����ֵ','\phi_{212}(k)����ֵ','\phi_{222}(k)����ֵ','Location','best');
end