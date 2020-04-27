save para_file tol Y;
clear all;
close all;
load para_file;
n=size(tol);
N=n(1);

MinX=[0 0 0];  %����������Χ
MaxX=[100 10 200];

%�������Ⱥ����
Size=50;   %��Ⱥ��ģ
CodeL=3;   %��������

F=0.7;        % �������ӣ�[1,2]
cr =0.6;      % ��������
G=200;              % ���������� 
%��ʼ����Ⱥ�ĸ���
for i=1:1:CodeL       
    P(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1);
end

BestS=P(1,:); %ȫ�����Ÿ���
for i=2:Size
    if chap8_22obj(P(i,:),tol,Y,N)<chap8_22obj(BestS,tol,Y,N)
        BestS=P(i,:);
    end
end
Ji=chap8_22obj(BestS,tol,Y,N);
%������Ҫѭ����ֱ�����㾫��Ҫ��
for kg=1:1:G
     time(kg)=kg;
%����
    for i=1:Size
        r1 = 1;r2=1;r3=1;r4=1;
        while(r1 == r2|| r1 ==r3 || r2 == r3 || r1 == i|| r2 ==i || r3 == i||r4==i ||r1==r4||r2==r4||r3==r4 )
            r1 = ceil(Size * rand(1));
             r2 = ceil(Size * rand(1));
              r3 = ceil(Size * rand(1));
              r4 = ceil(Size * rand(1));
        end
        h(i,:)=BestS+F*(P(r1,:)-P(r2,:));
        
        for j=1:CodeL%���λ���Ƿ�Խ��
            if h(i,j)<MinX(j)
                h(i,j)=MinX(j);
            elseif h(i,j)>MaxX(j)
                h(i,j)=MaxX(j);
            end
        end
%����
        for j = 1:1:CodeL
              tempr = rand(1);
              if(tempr<cr)
                  v(i,j) = h(i,j);
               else
                  v(i,j) = P(i,j);
               end
        end
%ѡ��        
        if(chap8_22obj(v(i,:),tol,Y,N)<chap8_22obj(P(i,:),tol,Y,N))
            P(i,:)=v(i,:);
        end
%�жϺ͸���       
       if chap8_22obj(P(i,:),tol,Y,N)<Ji %�жϵ���ʱ��λ���Ƿ�Ϊ���ŵ����
          Ji=chap8_22obj(P(i,:),tol,Y,N);
          BestS=P(i,:);
        end
      
    end
Best_J(kg)=chap8_22obj(BestS,tol,Y,N);
end
display('true value: m  =68.6,epsilon0=0.5,IX=123.1');
BestS    %��Ѹ���
Best_J(kg)%���Ŀ�꺯��ֵ

figure(1);%Ŀ�꺯��ֵ�仯����
plot(time,Best_J(time),'k','linewidth',2);
xlabel('Times');ylabel('Best J');