save para_file told Y;
clear all;
close all;
 
load para_file;
 
n=size(told);
N=n(1);
 
Size=200;   %��Ⱥ��ģ
CodeL=4;    %��������
MinX=zeros(CodeL,1);   %����������Χ
MaxX(1)=10;
MaxX(2:4)=5*ones(3,1);
MaxX=[MaxX(1) MaxX(2) MaxX(3) MaxX(4)];
 
for i=1:1:CodeL        %ʮ���Ƹ����Ʊ���
    A(:,i)=MinX(i)+(MaxX(i)-MinX(i))*rand(Size,1); 
end
 
G=1500;   %����Ŵ�����
BsJ=0;
for kg=1:1:G
   time(kg)=kg;
if mod(kg,1000)==1
   kg
end
%********���������Ӧ��ֵ**********
for i=1:1:Size
    J=0;
 
    a=A(i,:);    %the ith sample
    alfa=a(1);
    beta=a(2);
    ep=a(3);
    eta=a(4);
    ai=[alfa beta ep eta];
    
for j=1:1:N
    YY=[Y(j,1) Y(j,2) Y(j,3) Y(j,4);
        Y(j,5) Y(j,6) Y(j,7) Y(j,8)];
    tol=YY*ai';
    tol1(j)=tol(1);
    tol2(j)=tol(2);
end
tol=[tol1;tol2]';
E=tol-told;
 
for j=1:1:N
    Ej(j)=sqrt(E(j,1)^2+E(j,2)^2);
    J=J+0.5*Ej(j)*Ej(j);
end
BsJi(i)=J;  %Ŀ�꺯��
end
  [OderJi,IndexJi]=sort(BsJi);
  BestJ(kg)=OderJi(1);  %Ŀ�꺯����Сֵ
  Ji=BsJi;
  Cm=max(Ji);
% fi=Cm-Ji;  %������Ӧ��ֵ
  fi=1./Ji;
  [Oderfi,Indexfi]=sort(fi);
  Bestfi(kg)=Oderfi(Size);  %��������Ӧ��ֵ
  BestS=A(Indexfi(Size),:);
%***********ѡ�����***************
  fi_sum=sum(fi);
  fi_Size=(Oderfi/fi_sum)*Size;
  fi_S=floor(fi_Size); 
  r=Size-sum(fi_S);
  Rest=fi_Size-fi_S;
  [RestValue,Index]=sort(Rest);
  for i=Size:-1:Size-r+1
      fi_S(Index(i))=fi_S(Index(i))+1;
  end
  k=1;
  for i=Size:-1:1
     for j=1:1:fi_S(i) 
      TempE(k,:)=A(Indexfi(i),:);
        k=k+1;
     end
  end
  A=TempE;
%*************�������************
  Pc=0.80; %�������
  for i=1:2:(Size-1)
    temp=rand;
    if Pc>temp
      alfa=rand; %���淽����
      TempE(i,:)=alfa*A(i+1,:)+(1-alfa)*A(i,:);
      TempE(i+1,:)=alfa*A(i,:)+(1-alfa)*A(i+1,:);
    end
  end
  TempE(Size,:)=BestS;  %�������Ÿ���
  A=TempE;
%**************�������*************
  Pm=0.10;
  Pm_rand=rand(Size,CodeL);
  Mean=(MaxX + MinX')/2; 
  Dif=(MaxX-MinX');
  for i=1:1:Size
    for j=1:1:CodeL
       if Pm>Pm_rand(i,j)  %���췽��
          TempE(i,j)=Mean(j)+Dif(j)*(rand-0.5);
       end
    end
  end
  TempE(Size,:)=BestS; %�������Ÿ���
  A=TempE;
%**********************************
end
display('true value: alfa =6.7333,beta=3.4000,epc=3.0,eta=0');

BestS %��Ѹ���

Best_J=BestJ(G) %���Ŀ�꺯��ֵ
 
figure(1);   %Ŀ�꺯��ֵ�仯����
plot(time,BestJ,'r');
xlabel('Times');ylabel('Best J');
