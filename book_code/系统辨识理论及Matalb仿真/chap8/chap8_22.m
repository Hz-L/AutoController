save para_file tol Y;
clear all;
close all;
load para_file;
n=size(tol);
N=n(1);

MinX=[0 0 0];  %参数搜索范围
MaxX=[100 10 200];

%设计粒子群参数
Size=50;   %种群规模
CodeL=3;   %参数个数

F=0.7;        % 变异因子：[1,2]
cr =0.6;      % 交叉因子
G=200;              % 最大迭代次数 
%初始化种群的个体
for i=1:1:CodeL       
    P(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1);
end

BestS=P(1,:); %全局最优个体
for i=2:Size
    if chap8_22obj(P(i,:),tol,Y,N)<chap8_22obj(BestS,tol,Y,N)
        BestS=P(i,:);
    end
end
Ji=chap8_22obj(BestS,tol,Y,N);
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
        h(i,:)=BestS+F*(P(r1,:)-P(r2,:));
        
        for j=1:CodeL%检查位置是否越界
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
                  v(i,j) = P(i,j);
               end
        end
%选择        
        if(chap8_22obj(v(i,:),tol,Y,N)<chap8_22obj(P(i,:),tol,Y,N))
            P(i,:)=v(i,:);
        end
%判断和更新       
       if chap8_22obj(P(i,:),tol,Y,N)<Ji %判断当此时的位置是否为最优的情况
          Ji=chap8_22obj(P(i,:),tol,Y,N);
          BestS=P(i,:);
        end
      
    end
Best_J(kg)=chap8_22obj(BestS,tol,Y,N);
end
display('true value: m  =68.6,epsilon0=0.5,IX=123.1');
BestS    %最佳个体
Best_J(kg)%最佳目标函数值

figure(1);%目标函数值变化曲线
plot(time,Best_J(time),'k','linewidth',2);
xlabel('Times');ylabel('Best J');