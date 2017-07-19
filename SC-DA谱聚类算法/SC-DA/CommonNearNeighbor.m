function [CNN]=CommonNearNeighbor(X,number_sample,rad_density)
%����������ľ���
Distance_sample=zeros(number_sample,number_sample);
for i=1:(number_sample-1)
    for j=(i+1):number_sample
        Distance_sample(i,j)=sqrt(DistanceSquare(X(:,i),X(:,j)));%�����������ŷʽ����
        Distance_sample(j,i)=Distance_sample(i,j);
    end
    Distance_sample(i,i)=inf;%Ϊ�˷����������Ľ���
end
%�ҵ�ÿ�������ܶȰ뾶�ڵĽ�������
Neighbor=zeros(number_sample,number_sample);
[index_neighbor]=find(Distance_sample<=rad_density);%�ҵ������Ľ���
Neighbor(index_neighbor)=1;%�ѽ��ھ����е��ǽ��ڵ�������ֵΪ1
CNN=zeros(number_sample,number_sample);
CNN=Neighbor*Neighbor;%����õ����������Ľ��ڵĽ�������