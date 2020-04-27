save para_file tol Y;
clear all;
close all;
load para_file;
n=size(tol);
N=n(1);

%�޶�λ�ú��ٶȵķ�Χ
MinX=[0 0 0];  %����������Χ
MaxX=[100 10 200];
Vmax=100;
Vmin=-100;           % �޶��ٶȵķ�Χ 

%�������Ⱥ����
Size=80;   %��Ⱥ��ģ
CodeL=3;    %��������

c1=1.3;c2=1.7;          % ѧϰ���ӣ�[1,2]
wmax=0.90;wmin=0.10;    % ����Ȩ����Сֵ:(0,1)
G=100;              % ����������
%(1)��ʼ����Ⱥ�ĸ���
for i=1:G         %��ʼ��ÿ�θ��µĹ���Ȩ��
    w(i)=wmax-((wmax-wmin)/G)*i;  
end  
for i=1:1:CodeL       %ʮ���Ƹ����Ʊ���
    P(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1); 
    v(:,i)=Vmin +(Vmax - Vmin)*rand(Size,1);%�����ʼ���ٶ�
end
%��2����ʼ���������ź�ȫ�����ţ��ȼ���������ӵ���Ӧ�ȣ�����ʼPi��BestS
for i=1:1:Size
    Ji(i)=chap8_15obj(P(i,:),tol,Y,N);
    Pl(i,:)=P(i,:);
end
BestS=P(1,:); %ȫ�����Ÿ���
for i=2:Size
    if chap8_15obj(P(i,:),tol,Y,N)<chap8_15obj(BestS,tol,Y,N)
        BestS=P(i,:);
    end
end
%��3��������Ҫѭ����ֱ�����㾫��Ҫ��
 for kg=1:1:G
     time(kg)=kg;
    for i=1:Size
       v(i,:)=w(kg)*v(i,:)+c1*rand*(Pl(i,:)-P(i,:))+c2*rand*(BestS-P(i,:));%��Ȩ��ʵ���ٶȵĸ���
          for j=1:CodeL   %����ٶ��Ƿ�Խ��
            if v(i,j)<Vmin
                v(i,j)=Vmin;
            elseif  v(i,j)>Vmax
                v(i,j)=Vmax;
            end
          end
        P(i,:)=P(i,:)+v(i,:); %ʵ��λ�õĸ���
        for j=1:CodeL%���λ���Ƿ�Խ��
            if P(i,j)<MinX(j)
                P(i,j)=MinX(j);
            elseif P(i,j)>MaxX(j)
                P(i,j)=MaxX(j);
            end
        end
%����Ӧ���죨��������Ⱥ�㷨����ֲ����ţ�
       if rand>0.6
          k=ceil(3*rand); %ceil�����������ȡ��
          P(1,k)=100*rand;
          P(2,k)=10*rand;
          P(3,k)=200*rand;
       end    
%��4���жϺ͸���       
       if chap8_15obj(P(i,:),tol,Y,N)<Ji(i) %�жϵ���ʱ��λ���Ƿ�Ϊ���ŵ����
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
BestS    %��Ѹ���
Best_J(kg)%���Ŀ�꺯��ֵ

figure(1);%Ŀ�꺯��ֵ�仯����
plot(time,Best_J(time),'k','linewidth',2);
xlabel('Times');ylabel('Best J');