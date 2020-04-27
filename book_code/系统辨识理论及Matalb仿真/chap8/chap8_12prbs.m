function Out=genPRBS(n,A,N)
Out = [];   %二进制序列初始化
%移位寄存器初始化
    for i = 1:n
        R(i) = 1;
    end
    if (R(n)==1)
        Out(1) =-A;
    end
    if(R(n)==0)
        Out(1)=A;
    end

for i=2:N
        temp=R(1);
        R(1)= xor(R(n-2),R(n));   %采用异或产生
        j=2;
        while j<=n                  
             temp1=R(j);
               R(j)=temp;
               j=j+1;
                temp=temp1;
           end        
        if (R(n)==1)
            Out(i) =-A;
         end
         if(R(n)==0)
           Out(i)=A;
         end
end