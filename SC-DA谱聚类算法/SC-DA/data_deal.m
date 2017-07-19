%�������ݴ���
clear all
clc
load IDX_all
load information_dataset
number_loop=20;
rate_correct=zeros(number_loop,1);%��¼��ȷ��
CE=zeros(number_loop,1);%��¼������
NMI=zeros(number_loop,1);%��¼NMIֵ
RI=zeros(number_loop,1);%��¼RIֵ
FI=zeros(number_loop,1);%��¼FIֵ
ARI=zeros(number_loop,1);%��¼ARIֵ
KaI=zeros(number_loop,1);%��¼KaIֵ
for i=1:number_loop
    [corrate]=CorrectRate(X_all,IDX_all(:,i),number_sample,k);%������ȷ�ʼ�ԭʼ���ĺ��µ����ĵ�λ�õĶ�Ӧ
    value_ce=1-corrate;%���������
    [value_nmi]=NormalizedMutualInformation(X_all,IDX_all(:,i),number_sample,k);%�����������NMIֵ
    [value_ri]=RandIndexM(X_all,IDX_all(:,i),number_sample,k);%�����������RandIndexֵ
    [value_fi]=FIndexM(X_all,IDX_all(:,i),number_sample,k);%�����������FIndexֵ
    [value_ari]=AdjustedRandIndexM(X_all,IDX_all(:,i),number_sample,k);%�����������AdjustedRandIndexֵ
    [value_kai]=KappaIndex(X_all,IDX_all(:,i),number_sample,k);%�����������KappaIndexֵ
    rate_correct(i,1)=corrate;
    CE(i,1)=value_ce;
    NMI(i,1)=value_nmi;
    RI(i,1)=value_ri;
    FI(i,1)=value_fi;
    ARI(i,1)=value_ari;
    KaI(i,1)=value_kai;
end
%��ֵ+����
mean_rate_correct=mean(rate_correct);%����ƽ����ȷ��
var_rate_correct=var(rate_correct);
mean_CE=mean(CE);%����ƽ��������
var_CE=var(CE);
mean_NMI=mean(NMI);%����ƽ��NMIֵ
var_NMI=var(NMI);
mean_RI=mean(RI);%����ƽ��RIֵ
var_RI=var(RI);
mean_FI=mean(FI);%����ƽ��FIֵ
var_FI=var(FI);
mean_ARI=mean(ARI);%����ƽ��ARIֵ
var_ARI=var(ARI);
mean_KaI=mean(KaI);%����ƽ��KaIֵ
var_KaI=var(KaI);