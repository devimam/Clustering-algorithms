function [cluIndexes] = CluteringBasedOnCenter(rhoArray, nneighArray, centerIndexes)
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
[~,ordrho]=sort(rhoArray,'descend');%����������ܶȴӴ�С��������
NUMCLU = length(centerIndexes);
N = length(rhoArray);
cluIndexes = zeros(N,1) - 1;
for i = 1:NUMCLU
    cluIndexes(centerIndexes(i)) = i;
end
%assignation
for i=1:N
  if (cluIndexes(ordrho(i))==-1)
    cluIndexes(ordrho(i))=cluIndexes(nneighArray(ordrho(i)));
  end
end
end

