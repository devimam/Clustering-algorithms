function [Y]=Normaliz(M,number_sample,k)
M_square=M.^2;%����M��ÿ��Ԫ�ص�ƽ��
sum_M_columns=(sum(M_square,2)).^(1/2);%�������M_square��ÿ�еĺ͵Ŀ���ֵ
for i=1:number_sample
    for j=1:k
        Y(i,j)=M(i,j)/sum_M_columns(i);
    end
end