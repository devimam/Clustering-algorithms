function [D,L]=LaplacianMatrix(A,number_sample)
D=zeros(number_sample,number_sample);
L=zeros(number_sample,number_sample);
value_diag_D=zeros(number_sample,1);
value_diag_D=sum(A,2);%�����ƾ����ÿ�н��мӺ�
D=diag(value_diag_D);%�õ��Ⱦ���
L=(D^(-1/2))*A*(D^(-1/2));%�õ�L����