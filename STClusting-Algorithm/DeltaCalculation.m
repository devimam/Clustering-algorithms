function [deltaArray,nneighArray] = DeltaCalculation(distMatrix, rhoArray)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

N = size(distMatrix,1);
maxd=max(max(distMatrix));%�������������ֵ��������
[~,ordrho]=sort(rhoArray,'descend');%����������ܶȴӴ�С��������
deltaArray = zeros(N,1);%���ڼ�¼ÿ�������Ӧ�ľ���
nneighArray = zeros(N,1);%���ڼ�¼ÿ������������
%���´���Ϊ����delta�Ĵ���
deltaArray(ordrho(1))=-1.;%�ܶ��������Ӧ�ĳ�ʼ��
nneighArray(ordrho(1))=0; %�����ڽ���

for ii=2:N
   deltaArray(ordrho(ii))=maxd;
   for jj=1:ii-1%ɨ�����бȸö����Ӧ�ܶȴ�Ķ����ҳ���С�����Լ���Ӧ�������
     if(distMatrix(ordrho(ii),ordrho(jj))<deltaArray(ordrho(ii)))
        deltaArray(ordrho(ii))=distMatrix(ordrho(ii),ordrho(jj));
        nneighArray(ordrho(ii))=ordrho(jj);
     end
   end
end
deltaArray(ordrho(1))=max(deltaArray(:));%����Ϊ����ֵ
end