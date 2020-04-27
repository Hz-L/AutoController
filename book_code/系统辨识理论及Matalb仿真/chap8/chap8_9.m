save para_file told Y;
clear all;
close all;
load para_file;
n=size(told);
N=n(1);

%限定位置和速度的范围
MinX=[0 0 0 0];  %参数搜索范围
MaxX=[10 5 5 5];
Vmax=1;
Vmin=-1;           % 限定速度的范围 

%设计粒子群参数
Size=200;   %种群规模
CodeL=4;    %参数个数

c1=1.3;c2=1.7;          % 学习因子：[1,2]
wmax=0.90;wmin=0.10;    % 惯性权重最小值:(0,1)
G=200;                  % 最大迭代次数
%(1)初始化种群的个体
for i=1:G         %采用时变权重
    w(i)=wmax-((wmax-wmin)/G)*i;  
end  
for i=1:1:CodeL       %十进制浮点制编码
    X(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1); 
    v(:,i)=Vmin+(Vmax-Vmin)*rand(Size,1);%随机初始化速度
end
%（2）初始化个体最优和全局最优：先计算各个粒子的适应度，并初始Ji和BestS
for i=1:Size
    Ji(i)=chap8_9obj(X(i,:),told,Y,N);
    Xl(i,:)=X(i,:);
end

BestS=X(1,:); %全局最优个体初始化
for i=2:Size
    if chap8_9obj(X(i,:),told,Y,N)<chap8_9obj(BestS,told,Y,N)
        BestS=X(i,:);
    end
end
%（3）进入主要循环，直到满足精度要求
 for kg=1:1:G
     times(kg)=kg;
    for i=1:Size
       v(i,:)=w(kg)*v(i,:)+c1*rand*(Xl(i,:)-X(i,:))+c2*rand*(BestS-X(i,:));%加权，实现速度的更新
          for j=1:CodeL   %检查速度是否越界
            if v(i,j)<Vmin
                v(i,j)=Vmin;
            elseif  v(i,j)>Vmax
                v(i,j)=Vmax;
            end
          end
        X(i,:)=X(i,:)+v(i,:); %实现位置的更新
        for j=1:CodeL%检查位置是否越界
            if X(i,j)<MinX(j)
                X(i,j)=MinX(j);
            elseif X(i,j)>MaxX(j)
                X(i,j)=MaxX(j);
            end
        end         
%自适应变异,避免陷入局部最优
       if rand>0.6
            k=ceil(4*rand);   %ceil为向上取整
            if k==1
            X(i,k)=10*rand;
            else
            X(i,k)=5*rand; 
            end
       end
%（4）判断和更新       
       if chap8_9obj(X(i,:),told,Y,N)<Ji(i) %局部优化：判断当此时的位置是否为最优的情况
          Ji(i)=chap8_9obj(X(i,:),told,Y,N);
          Xl(i,:)=X(i,:);
       end
        
        if Ji(i)<chap8_9obj(BestS,told,Y,N)  %全局优化
          BestS=Xl(i,:);
        end
    end
Best_J(kg)=chap8_9obj(BestS,told,Y,N);
end
display('true value: alfa =6.7333,beta=3.4000,epc=3.0,eta=0');

BestS    %最佳个体
Best_J(kg)%最佳目标函数值

figure(1);%目标函数值变化曲线
plot(times,Best_J(times),'r','linewidth',2);
xlabel('Times');ylabel('Best J');