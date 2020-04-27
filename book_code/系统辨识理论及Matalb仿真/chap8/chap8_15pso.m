save para_file tol Y;
clear all;
close all;
load para_file;
n=size(tol);
N=n(1);

%限定位置和速度的范围
MinX=[0 0 0];  %参数搜索范围
MaxX=[100 10 200];
Vmax=100;
Vmin=-100;           % 限定速度的范围 

%设计粒子群参数
Size=80;   %种群规模
CodeL=3;    %参数个数

c1=1.3;c2=1.7;          % 学习因子：[1,2]
wmax=0.90;wmin=0.10;    % 惯性权重最小值:(0,1)
G=100;              % 最大迭代次数
%(1)初始化种群的个体
for i=1:G         %初始化每次更新的惯性权重
    w(i)=wmax-((wmax-wmin)/G)*i;  
end  
for i=1:1:CodeL       %十进制浮点制编码
    P(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1); 
    v(:,i)=Vmin +(Vmax - Vmin)*rand(Size,1);%随机初始化速度
end
%（2）初始化个体最优和全局最优：先计算各个粒子的适应度，并初始Pi和BestS
for i=1:1:Size
    Ji(i)=chap8_15obj(P(i,:),tol,Y,N);
    Pl(i,:)=P(i,:);
end
BestS=P(1,:); %全局最优个体
for i=2:Size
    if chap8_15obj(P(i,:),tol,Y,N)<chap8_15obj(BestS,tol,Y,N)
        BestS=P(i,:);
    end
end
%（3）进入主要循环，直到满足精度要求
 for kg=1:1:G
     time(kg)=kg;
    for i=1:Size
       v(i,:)=w(kg)*v(i,:)+c1*rand*(Pl(i,:)-P(i,:))+c2*rand*(BestS-P(i,:));%加权，实现速度的更新
          for j=1:CodeL   %检查速度是否越界
            if v(i,j)<Vmin
                v(i,j)=Vmin;
            elseif  v(i,j)>Vmax
                v(i,j)=Vmax;
            end
          end
        P(i,:)=P(i,:)+v(i,:); %实现位置的更新
        for j=1:CodeL%检查位置是否越界
            if P(i,j)<MinX(j)
                P(i,j)=MinX(j);
            elseif P(i,j)>MaxX(j)
                P(i,j)=MaxX(j);
            end
        end
%自适应变异（避免粒子群算法陷入局部最优）
       if rand>0.6
          k=ceil(3*rand); %ceil朝正无穷大方向取整
          P(1,k)=100*rand;
          P(2,k)=10*rand;
          P(3,k)=200*rand;
       end    
%（4）判断和更新       
       if chap8_15obj(P(i,:),tol,Y,N)<Ji(i) %判断当此时的位置是否为最优的情况
          Ji(i)=chap8_15obj(P(i,:),tol,Y,N);
          Pl(i,:)=P(i,:);
        end
        if Ji(i)<chap8_15obj(BestS,tol,Y,N)
          BestS=Pl(i,:);
        end
    end
Best_J(kg)=chap8_15obj(BestS,tol,Y,N);
end
display('true value: m  =68.6,epsilon0=0.5,IX=123.1');
BestS    %最佳个体
Best_J(kg)%最佳目标函数值

figure(1);%目标函数值变化曲线
plot(time,Best_J(time),'k','linewidth',2);
xlabel('Times');ylabel('Best J');