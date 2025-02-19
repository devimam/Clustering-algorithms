function [RD,CD,order]=Moptics(x,matrix,k)

% -------------------------------------------------------------------------
% Function: 
 
% -------------------------------------------------------------------------
% Aim: 
% Ordering objects of a data set to obtain the clustering structure 
% -------------------------------------------------------------------------
% Input: 
% x - data set (m,n); m-objects, n-variables
% k - number of objects in a neighborhood of the selected object
% matrix - dissimilarity matrix (m by m)
% (minimal number of objects considered as a cluster)
% -------------------------------------------------------------------------
% Output: 
% RD - vector with reachability distances (m,1)
% CD - vector with core distances (m,1)
% order - vector specifying the order of objects (1,m)
% -------------------------------------------------------------------------
% Example of use:
% x=[randn(30,2)*.4;randn(40,2)*.5+ones(40,1)*[4 4]];
% [RD,CD,order]=optics(x,4)
% -------------------------------------------------------------------------
% References: 
% [1] M. Ankrest, M. Breunig, H. Kriegel, J. Sander, 
% OPTICS: Ordering Points To Identify the Clustering Structure, 
% available from www.dbs.informatik.uni-muenchen.de/cgi-bin/papers?query=--CO
% [2] M. Daszykowski, B. Walczak, D.L. Massart, Looking for natural  
% patterns in analytical data. Part 2. Tracing local density 
% with OPTICS, J. Chem. Inf. Comput. Sci. 42 (2002) 500-507
% -------------------------------------------------------------------------
% Written by Michal Daszykowski
% Department of Chemometrics, Institute of Chemistry, 
% The University of Silesia
% December 2004
% http://www.chemometria.us.edu.pl


[m,n]=size(x);
CD=zeros(1,m);
RD=ones(1,m)*10^10;

 
% Calculate Core Distances 得到每个点的核心距离 计算每个点和其他节点的距离，然后进行排序，得到前
% k个点 故而得到核心距离 
for i=1:m	
   % D=sort(dist(x(i,:),x));
    D=sort(matrix(i,:));
    CD(i)=D(k+1);  
end

order=[];
seeds=[1:m];

ind=1;

while ~isempty(seeds)
    ob=seeds(ind);        
    seeds(ind)=[]; 
    order=[order ob];
   % mm=max([ones(1,length(seeds))*CD(ob);dist(x(ob,:),x(seeds,:))]);% ob到所有点的 可达距离 max（距离，可达距离）
    mm=max([ones(1,length(seeds))*CD(ob);matrix(ob,seeds)]);% ob到所有点的 可达距离 max（距离，可达距离）
    
    ii=(RD(seeds))>mm;
    RD(seeds(ii))=mm(ii);
    [i1 ind]=min(RD(seeds));
end   

RD(1)=max(RD(2:m))+.1*max(RD(2:m));

