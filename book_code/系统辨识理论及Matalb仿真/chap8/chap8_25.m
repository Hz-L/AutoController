save para_file Tol y;
clear all;
close all;
load para_file;
dt=50;
tol=Tol(1000:dt:2000);
Y=y(1000:dt:2000);
n=size(tol);
N=n(1);

MinX=[0];  %����������Χ
MaxX=[20];

%��Ʋ���
Size=30;   %��Ⱥ��ģ
CodeL=1;   %��������

F=0.7;        % �������ӣ�[1,2]
cr=0.6;       % ��������
G=100;        % ���������� 
%��ʼ����Ⱥ�ĸ���
for i=1:1:CodeL       
    P(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1);
end


BestS=P(1,:); %ȫ�����Ÿ���
for i=2:Size

    if chap8_25obj(P(i,:),tol,Y,N)<chap8_25obj(BestS,tol,Y,N)
        
        BestS=P(i,:);
    end
end
Ji=chap8_25obj(BestS,tol,Y,N);
%������Ҫѭ����ֱ�����㾫��Ҫ��
for kg=1:1:G
     time(kg)=kg;
%����
    for i=1:Size
        r1 = 1;r2=1;r3=1;r4=1;
        while(r1 == r2||r1 == i|| r2 ==i)
            r1 = ceil(Size * rand(1));
             r2 = ceil(Size * rand(1));
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
        if(chap8_25obj(v(i,:),tol,Y,N)<chap8_25obj(P(i,:),tol,Y,N))
            P(i,:)=v(i,:);
        end
%�жϺ͸���       
       if chap8_25obj(P(i,:),tol,Y,N)<Ji %�жϵ���ʱ��λ���Ƿ�Ϊ���ŵ����
          Ji=chap8_25obj(P(i,:),tol,Y,N)
          BestS=P(i,:);
        end
    end
Best_J(kg)=chap8_25obj(BestS,tol,Y,N);
end
display('true value: J=10');
BestS      %��Ѹ���
Best_J(kg) %���Ŀ�꺯��ֵ

figure(1); %Ŀ�꺯��ֵ�仯����
plot(time,Best_J(time),'k','linewidth',2);
xlabel('Times');ylabel('Best J');