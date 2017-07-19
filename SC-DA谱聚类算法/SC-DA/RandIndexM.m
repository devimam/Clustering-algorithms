function [RI]=RandIndexM(A,IDX,patternNum,k)
index_original=A(end,:);%��ԭʼ��Ŵ������
index_new=IDX;%�Ѿ������ı�Ŵ���þ���
k_original=max(index_original);%ԭʼ�����
k_new=max(index_new);%����õ��������
number_original=zeros(k_original,1);%��¼ԭʼ���ݼ�ÿ���������
number_new=zeros(k_new,1);%��¼��������ÿ���������
number_mutual=zeros(k_original,k_new);%��¼ԭʼ���;��������֮��Ľ������д���ԭʼ��������д������������
for i=1:patternNum
    x_temp=index_original(i);%�õ���������ԭʼ����
    y_temp=index_new(i);%�õ��������ľ���������
    number_original(x_temp)=number_original(x_temp)+1;
    number_new(y_temp)=number_new(y_temp)+1;
    number_mutual(x_temp,y_temp)=number_mutual(x_temp,y_temp)+1;
end
%�����ܵĵ����
total_pairs=(patternNum*(patternNum-1))/2;
%����ԭʼͬһ���еĶ��󱻻��ֵ�ͬһ��ĵ�Ե���ĿTP
%����ͬһ����󱻻��ֵ���ͬ��ĵ����ĿFN
TP=0;
FN=0;
for i=1:k_new
    for j=1:k
        temp_mutual=number_mutual(j,i);
        TP=TP+(temp_mutual*(temp_mutual-1))/2;
        FN=FN+(temp_mutual*(number_original(j)-temp_mutual))/2;
    end
end
%���㲻ͬ��֮��ĵ������
all_diff=0;
for i=1:k_new
    all_diff=all_diff+number_new(i)*(patternNum-number_new(i))/2;
end
%����ԭʼ��ͬ��Ķ��󱻻��ֵ���ͬ��ĵ�Ե���Ŀ
TN=all_diff-FN;
%��������ָ��RandIndex��ֵ
RI=(TP+TN)/total_pairs;