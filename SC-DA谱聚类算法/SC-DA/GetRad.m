function [rad_density]=GetRad(X,number_sample)
%����������ľ���
 Distance_sample=zeros(number_sample,number_sample);
for i=1:(number_sample-1)
    for j=(i+1):number_sample
        Distance_sample(i,j)=sqrt(DistanceSquare(X(:,i),X(:,j)));%�����������ŷʽ����
        Distance_sample(j,i)=Distance_sample(i,j);
    end
end
mean_distance=sum(sum(Distance_sample))/((number_sample-1)*number_sample);%����ƽ��ֵ
max_distance=max(Distance_sample(:));%��������������ֵ
for i=1:number_sample      
    Distance_sample(i,i)=inf;% Ϊ�˼���������������Сֵ����Ϊ�������ĶԽ��߸�ֵΪINF
end
min_distance=min(Distance_sample(:));%�������������Сֵ
distance_nearest=min(Distance_sample);%����������������ڼ�ľ���
mean_nearest=mean(distance_nearest);%����������������ڼ�ľ���ľ�ֵ
max_nearest=max(distance_nearest);%����������������ڼ�ľ�������ֵ
rad_density=20*mean_distance+54*min_distance+13*max_nearest-6*max_distance-65*mean_nearest;%�����ܶȰ뾶����