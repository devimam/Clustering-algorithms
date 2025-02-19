function [u re]=KMeans(data,N) 
%N是数据一共分多少类
%data是输入的不带分类标号的数据
%u是每一类的中心
%re是返回的带分类标号的数据


[m n]=size(data);  
ma=zeros(n);        %每一维最大的数
mi=zeros(n);        %每一维最小的数
u=zeros(N,n);       %随机初始化，最终迭代到每一类的中心位置
for i=1:n
   ma(i)=max(data(:,i));    %每一维最大的数
   mi(i)=min(data(:,i));    %每一维最小的数
   for j=1:N
		u(j,i)=ma(i)+(mi(i)-ma(i))*rand();  %随机初始化，不过还是在每一维[min max]中初始化好些
   end      
end

while 1
	pre_u=u;            %上一次求得的中心位置
	for i=1:N
		tmp{i}=[];      % 公式一中的x(i)-uj,为公式一实现做准备
		for j=1:m
			tmp{i}=[tmp{i};data(j,:)-u(i,:)];
		end
	end
	
	quan=zeros(m,N);
	for i=1:m        %公式一的实现
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
		
	for i=1:N            %公式二的实现
	   for j=1:n

			u(i,j)=sum(quan(:,i).*data(:,j))/sum(quan(:,i));
	   end           
	end
	
	if norm(pre_u-u)<0.1  %不断迭代直到位置不再变化
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
    

