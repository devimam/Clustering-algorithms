%ʵ��NJW�㷨
clear all
clc
number_loop=1;%ѭ���Ĵ���
[X,number_sample,k,class_original]=InputData('D:\�ο�����\STClustering Algorithm\flame.txt');%�������ݣ��õ����������������
% k=ceil(k);
X_all=[X;class_original];%����X_all��ʾ���ݱ��������ֵ+���������
Standard_Deviation=0.1;%�˹���ֵ��׼��
rate_correct=zeros(number_loop,1);%��¼��ȷ��
number_correct=zeros(number_loop,k);%��¼��ȷ������
time_run=zeros(number_loop,1);%��¼����ʱ��
CE=zeros(number_loop,1);%��¼������
NMI=zeros(number_loop,1);%��¼NMIֵ
RI=zeros(number_loop,1);%��¼RIֵ
FI=zeros(number_loop,1);%��¼FIֵ
ARI=zeros(number_loop,1);%��¼ARIֵ
KaI=zeros(number_loop,1);%��¼KaIֵ
IDX_all=zeros(number_sample,number_loop);%��¼ÿ�εľ�����
for i=1:number_loop  
    i
    t1=clock;
    [A]=AffinityMatrix(X,number_sample,k,Standard_Deviation);%step1���������ݼ�X���õ����ƾ���A
    [D,L]=LaplacianMatrix(A,number_sample);%step2������Ⱦ���D�����ù�ʽ�õ�����L
    [M]=EigenvectorMatrix(L,number_sample,k);%step3���ҵ�L�����k����������������γ�M���ϣ��ұ�֤�����˴�����
    [Y]=Normaliz(M,number_sample,k);%step4���Լ���M���й�һ�����õ�����Y
    [center,index_class,distance_sample,number_sample_class]=K_Means(Y,number_sample,k);%step5����Y����kmeans�㷨���о��࣬�õ�������;step6����Y�ķ�����ֱ��ӳ�䵽ԭ���ݼ�X��
    t2=clock;
    time_run(i)=etime(t2,t1);
    [corrate,numcorrect,ON,number_class]=CorrectRate(X_all,index_class,number_sample,k);%������ȷ�ʼ�ԭʼ���ĺ��µ����ĵ�λ�õĶ�Ӧ
    value_ce=1-corrate;%���������
    [value_nmi]=NormalizedMutualInformation(X_all,index_class,number_sample,k);%�����������NMIֵ
    [value_ri]=RandIndexM(X_all,index_class,number_sample,k);%�����������RandIndexֵ
    [value_fi]=FIndexM(X_all,index_class,number_sample,k);%�����������FIndexֵ
    [value_ari]=AdjustedRandIndexM(X_all,index_class,number_sample,k);%�����������AdjustedRandIndexֵ
    [value_kai]=KappaIndex(X_all,index_class,number_sample,k);%�����������KappaIndexֵ  
    rate_correct(i,1)=corrate;
    number_correct(i,:)=numcorrect;
    CE(i,1)=value_ce;
    NMI(i,1)=value_nmi;
    RI(i,1)=value_ri;
    FI(i,1)=value_fi;
    ARI(i,1)=value_ari;
    KaI(i,1)=value_kai;
    IDX_all(:,i)=index_class;
end
%���ʵ�����Ĵ������������
%ShowFigure(X,Y,class_original,index_class,number_sample,k);%��������ͼ����ʾ
%��������
mean_time_run=sum(time_run)/number_loop;%����ƽ������ʱ��
mean_rate_correct=sum(rate_correct)/number_loop;%����ƽ����ȷ��
meaan_CE=sum(CE)/number_loop;%����ƽ��������
mean_NMI=sum(NMI)/number_loop;%����ƽ��NMIֵ
mean_RI=sum(RI)/number_loop;%����ƽ��RIֵ
mean_FI=sum(FI)/number_loop;%����ƽ��FIֵ
mean_ARI=sum(ARI)/number_loop;%����ƽ��ARIֵ
mean_KaI=sum(KaI)/number_loop;%����ƽ��KaIֵ

 gscatter(X(1,:),X(2,:),index_class,'rgbcmyk','<>^*.')
%�洢������
save IDX_all IDX_all;
save information_dataset X_all number_sample k