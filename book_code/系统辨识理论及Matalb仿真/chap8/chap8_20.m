clear all;
close all;
load de2_file;

%限定位置和速度的范围
MinX=[0 0 0 0];  %参数搜索范围
MaxX=[10 10 30 3];

%设计粒子群参数
Size=30;   %种群规模
CodeL=4;   %参数个数

F=0.95;      % 变异因子：[1,2]
cr=0.6;      % 交叉因子
G=100;              % 最大迭代次数 
%初始化种群的个体
for i=1:1:CodeL       
    X(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1);
end
BestS=X(1,:); %全局最优个体
for i=2:Size
    if chap8_20obj(X(i,:),t,N,ut,y)<chap8_20obj(BestS,t,N,ut,y)
        BestS=X(i,:);
    end
end
Ji=chap8_20obj(BestS,t,N,ut,y);
%进入主要循环，直到满足精度要求
for kg=1:1:G
     time(kg)=kg;
%变异
    for i=1:Size
        r1 = 1;r2=1;r3=1;r4=1;
        while(r1 == r2|| r1 ==r3 || r2 == r3 || r1 == i|| r2 ==i || r3 == i||r4==i ||r1==r4||r2==r4||r3==r4 )
            r1 = ceil(Size * rand(1));
            r2 = ceil(Size * rand(1));
            r3 = ceil(Size * rand(1));
            r4 = ceil(Size * rand(1));
        end
        h(i,:)=BestS+F*(X(r2,:)-X(r3,:));
        %h(i,:)=X(r1,:)+F*(X(r2,:)-X(r3,:));

       for j=1:CodeL  %检查值是否越界
            if h(i,j)<MinX(j)
                h(i,j)=MinX(j);
            elseif h(i,j)>MaxX(j)
                h(i,j)=MaxX(j);
            end
        end        
        
%交叉
        for j = 1:1:CodeL
              tempr = rand(1);
              if(tempr<cr)
                  v(i,j) = h(i,j);
               else
                  v(i,j) = X(i,j);
               end
        end
%选择        
        if chap8_20obj(v(i,:),t,N,ut,y)<chap8_20obj(X(i,:),t,N,ut,y)
            X(i,:)=v(i,:);
        end
        
%判断和更新
       if chap8_20obj(X(i,:),t,N,ut,y)<Ji %判断当此时的指标是否为最优的情况
          Ji=chap8_20obj(X(i,:),t,N,ut,y);
          BestS=X(i,:);
        end
    end
Best_J(kg)=chap8_20obj(BestS,t,N,ut,y);
end
display('true value: K=2;T1=1;T2=20;T=0.8');

BestS    %最佳个体
Best_J(kg)%最佳目标函数值

figure(1);%指标函数值变化曲线
plot(time,Best_J(time),'r','linewidth',2);
xlabel('Time');ylabel('Best J');