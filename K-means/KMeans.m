function [u re]=KMeans(data,N) 
%N������һ���ֶ�����
%data������Ĳ��������ŵ�����
%u��ÿһ�������
%re�Ƿ��صĴ������ŵ�����


[m n]=size(data);  
ma=zeros(n);        %ÿһά������
mi=zeros(n);        %ÿһά��С����
u=zeros(N,n);       %�����ʼ�������յ�����ÿһ�������λ��
for i=1:n
   ma(i)=max(data(:,i));    %ÿһά������
   mi(i)=min(data(:,i));    %ÿһά��С����
   for j=1:N
		u(j,i)=ma(i)+(mi(i)-ma(i))*rand();  %�����ʼ��������������ÿһά[min max]�г�ʼ����Щ
   end      
end

while 1
	pre_u=u;            %��һ����õ�����λ��
	for i=1:N
		tmp{i}=[];      % ��ʽһ�е�x(i)-uj,Ϊ��ʽһʵ����׼��
		for j=1:m
			tmp{i}=[tmp{i};data(j,:)-u(i,:)];
		end
	end
	
	quan=zeros(m,N);
	for i=1:m        %��ʽһ��ʵ��
		c=[];
		for j=1:N
			c=[c norm(tmp{j}(i,:))];
		end
		[junk index]=min(c);
		quan(i,index)=norm(tmp{index}(i,:));           
	end
	cc=0;dd=0;ff=0;
	for i=1:m
		if quan(i,1)~=0
			cc=cc+1;
		elseif quan(i,2)~=0
			dd=dd+1;
		else ff=ff+1;
		end
	end
		
	for i=1:N            %��ʽ����ʵ��
	   for j=1:n

			u(i,j)=sum(quan(:,i).*data(:,j))/sum(quan(:,i));
	   end           
	end
	
	if norm(pre_u-u)<0.1  %���ϵ���ֱ��λ�ò��ٱ仯
		break;
	end
end

re=[];
for i=1:m
	tmp=[];
	for j=1:N
		tmp=[tmp norm(data(i,:)-u(j,:))];
	end
	[junk index]=min(tmp);
	re=[re; data(i,:) index];
end
    

