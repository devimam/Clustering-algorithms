%����ָ��Adjusted Rand Index
function [ARI]=AdjustedRandIndexM(A,IDX,patternNum,k)
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
number_mutual_trans=number_mutual';%�Ѿ���ת���ɣ��д����ֺ������д���ԭʼ���
%ARI��ʽ�е�����
ARI_up_left=0;
ARI_up_right=0;
ARI_down_left=0;
ARI_down_right=0;
%������ӵ������
for i=1:k_new
    for j=1:k_original
        ARI_up_left=ARI_up_left+number_mutual_trans(i,j)*(number_mutual_trans(i,j)-1)/2;
    end
end
%������ӵ��Ҳ���
sum_number_new_2_pick=0;%���㻮�ֵõ��Ľ������ͬһ��ĵ�Ժ�
for i=1:k_new
    sum_number_new_2_pick=sum_number_new_2_pick+number_new(i)*(number_new(i)-1)/2;
end
sum_number_original_2_pick=0;%����ԭʼ��������ͬһ��ĵ�Ժ�
for j=1:k_original
    sum_number_original_2_pick=sum_number_original_2_pick+number_original(j)*(number_original(j)-1)/2;
end
total_pairs=(patternNum*(patternNum-1))/2;%�����ܵĵ����
ARI_up_right=sum_number_new_2_pick*sum_number_original_2_pick/total_pairs;
%�����ĸ�������
ARI_down_left=(sum_number_new_2_pick+sum_number_original_2_pick)/2;
%�����ĸ���Ҳ���
ARI_down_right=sum_number_new_2_pick*sum_number_original_2_pick/total_pairs;
ARI=(ARI_up_left-ARI_up_right)/(ARI_down_left-ARI_down_right);