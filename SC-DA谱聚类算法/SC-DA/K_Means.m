function [center,index_class,distance_sample,number_sample_class]=K_Means(Y,number_sample,k)
%Y��ÿһ��Ϊһ�����ݶ���
Y=Y';%ʹY��ÿһ�д���һ�����ݶ���,Y��k*n�ľ���
index_center=randint(k,1,[1,number_sample]);%��������������,��Ϊ��ʼ����
index_class=zeros(number_sample,1)+(-1);%��¼ÿ�����ݶ��󱻻��ֵ�����
distance_sample=zeros(number_sample,1);%��¼ÿ�����ݶ��󵽸������ĵľ���
number_sample_class=zeros(k,1);%��¼ÿ���е�������
for i=1:k
    center(:,i)=Y(:,index_center(i));
    index_class(index_center(i))=i;%��¼������������
end
iterNum=100;
counter=0;
change=1;
while(counter<iterNum&&change~=0)
    counter=counter+1;
    change=0;
    for i=1:number_sample
        index=-1;
        distance=inf;
        for j=1:k
            tempDis=DistanceSquare(Y(:,i),center(:,j));
            if (distance>tempDis)
                distance=tempDis;
                index=j;
            end
        end
        if (index_class(i)==index)
            distance_sample(i)=distance;
        else
            old_index=index_class(i);
            index_class(i)=index;
            distance_sample(i)=distance;
            if (old_index~=-1)
                [center(:,old_index),number_sample_class(old_index)]=CalCenter(old_index,Y,number_sample,index_class);
            end
            [center(:,index),number_sample_class(index)]=CalCenter(index,Y,number_sample,index_class);
            change=1;
        end
    end
end
            